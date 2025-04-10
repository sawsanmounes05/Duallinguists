const express = require("express");
const bcrypt = require("bcryptjs");
const session = require("express-session");
const app = express();

// SOCKET.IO SETUP
const http = require("http");
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);

const {
  userModel,
  quizModel,
  languageModel,
  selectionModel,
  assessmentModel,
  culturalInsightModel,
  forumModel,
  progressModel,
  
  
  

} = require("./models");

// USER PROGRESS FUNCTION (if needed)
const getUserProgress = async (userID) => {
  try {
    const [userProgress] = await db.query(`
        SELECT *
        FROM UserProgress
        WHERE UserID = ?
        ORDER BY DateTaken DESC
    `, [userID]);
    return userProgress.length > 0 ? userProgress : [];
  } catch (error) {
    console.error("Error fetching user progress:", error);
    throw error;
  }
};

app.use(session({
  secret: "your-secret-key",
  resave: false,
  saveUninitialized: false,
  cookie: {
      secure: false,
      sameSite: "lax",
      maxAge: 7 * 24 * 60 * 60 * 1000 // Session lasts for 7 days
  }
}));

app.use((req, res, next) => {
  res.locals.user = req.session.user || null;
  next();
});

app.use(express.static("static"));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.set("view engine", "pug");
app.set("views", "./app/views");

function isAuthenticated(req, res, next) {
  if (req.session.user) return next();
  res.redirect("/login");
}
io.on("connection", (socket) => {
  console.log("🧠 New user connected");

  // When a user joins a room
  socket.on("joinRoom", (roomID) => {
    socket.join(roomID);  // Join the specific room
    console.log(`User joined room: ${roomID}`);
  });

  // When a user sends a message
  socket.on("newMessage", async (data) => {
    const { groupChatID, userID, messageText, sender } = data;
  
    const sentAt = new Date().toISOString().slice(0, 19).replace('T', ' '); // Timestamp
  
    // Ensure sender is passed properly
    const messageData = {
      sender,              // Sender's name
      sentAt,              // Sent timestamp
      messageText,         // The message text
      userID               // User ID
    };
  
    // Save to DB and broadcast message
    await forumModel.saveMessage(groupChatID, userID, messageText, sentAt);
    io.to(groupChatID).emit("messageBroadcast", messageData); // Emit to room
  });
  
  // Handle room leaving
  socket.on("leaveRoom", (roomID) => {
    socket.leave(roomID);  // Leave the room
    console.log(`User left room: ${roomID}`);
  });
});

// Middleware to set the selected language in the session
app.use((req, res, next) => {
  const { languageID } = req.query;
  if (languageID) {
    req.session.selectedLanguageID = languageID;
  }
  next();
});
// Middleware to check if the user is authenticated
app.use((req, res, next) => {
  if (req.session.user) {
    res.locals.user = req.session.user;
  } else {
    res.locals.user = null;
  }
  next();
});

// MIDDLEWARE & CONFIG
app.use(express.static("static"));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.set("view engine", "pug");
app.set("views", "./app/views");
// Homepage
app.get("/", (req, res) => {
  res.render("homepage");
});
app.get("/Homepage", (req, res) => {
  res.render("homepage");
});
// Login
app.get("/login", (req, res) => res.render("login"));

app.post("/login", async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await userModel.getUserByEmail(email);
        if (!user || !await bcrypt.compare(password, user.Password)) {
            return res.status(400).send("Invalid email or password.");
        }

        req.session.user = { id: user.UserID, name: user.Name };
        const redirectLanguageID = req.session.selectedLanguageID;
        if (redirectLanguageID) return res.redirect(`/selection-list?languageID=${redirectLanguageID}`);
        res.redirect(`/userprofile/${user.UserID}`);
    } catch (err) {
        res.status(500).send("Server error.");
    }
});

// Signup
app.get("/signup", async (req, res) => {
    const languages = await languageModel.getAllLanguages();
    res.render("signup", { languages });
});


app.post("/signup", async (req, res) => {
    try {
        const { name, email, password, phone_number, bio } = req.body;
        console.log("🚀 SIGNUP BODY:", req.body);

        const existingUser = await userModel.getUserByEmail(email);
        if (existingUser) {
            console.warn("⚠️ Email already exists:", email);
            return res.status(400).send("Email already exists");
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        const userId = `U${Math.floor(1000 + Math.random() * 9000)}`;
        console.log("✅ Generated userID:", userId);

        await userModel.createUser({ userId, name, email, hashedPassword, phone_number, bio });
        console.log("✅ User created successfully:", { userId, name, email });

        req.session.user = { id: userId, name };
        res.redirect("/forums");
    } catch (err) {
        console.error("❌ SIGNUP ERROR:", err);
        res.status(500).send("Signup failed.");
    }
});



// Logout
app.get("/logout", (req, res) => {
    req.session.destroy(() => res.redirect("/login"));
});

// User Profile
app.get("/userprofile/:id?", async (req, res) => {
    try {
        let userID = req.params.id || req.session.user?.id;
        if (!userID) return res.redirect("/login");

        const user = await userModel.getUserById(userID);
        if (!user) return res.status(404).send("User Not Found");

        res.render("userprofile", { user });
    } catch (err) {
        res.status(500).send("Database query failed: " + err.message);
    }
});




// Language List
app.get("/language-list", async (req, res) => {
      try {
          const languages = await languageModel.getAllLanguages();
          res.render("language-list", { languages, user: req.session.user });
      } catch (err) {
          res.status(500).send(`Database query failed: ${err.message}`);
      }
  });
  
  app.post("/select-language", (req, res) => {
      const { languageID } = req.body;
      if (!languageID) return res.status(400).send("No language selected.");
      req.session.selectedLanguageID = languageID;
      if (!req.session.user) return res.redirect("/login");
      res.redirect(`/selection-list?languageID=${languageID}`);
  });
  
  // Selection List
  app.get("/selection-list", isAuthenticated, async (req, res) => {
      const languageID = req.query.languageID;
      if (!languageID) return res.redirect("/language-list");
  
      try {
          const options = await selectionModel.getAllSelectionOptions();
          res.render("selection-list", { options, languageID });
      } catch (err) {
          res.status(500).send(`Database query failed: ${err.message}`);
      }
  });
  
  app.post("/select", isAuthenticated, async (req, res) => {
      const { selection, languageID } = req.body;
  
      if (!selection || !languageID) {
          return res.status(400).send("Missing data.");
      }
  
      const redirectMap = {
          quiz: "/quizcategories",
          assessment: "/assessment-categories",
          progress: "/progress-status",
          cultural: "/cultural-insight",
          groupchat: "/groupchat"
      };
  
      const baseRoute = redirectMap[selection];
      if (!baseRoute) {
          return res.status(400).send("Invalid selection.");
      }
  
      // Groupchat expects URL like /groupchat/:languageID (no query param)
      if (selection === "groupchat") {
          return res.redirect(`${baseRoute}/${languageID}`);
      }
  
      // All other selections use query parameters
      return res.redirect(`${baseRoute}?languageID=${languageID}`);
  });
  
  
  
  // Quiz Category Selection
  app.get("/quizcategories", async (req, res) => {
      const languageID = req.query.languageID;
      if (!languageID) return res.redirect("/language-list");
  
      try {
          const categories = await quizModel.getQuizCategories();
          res.render("quizcategories", { categories, languageID });
      } catch (err) {
          res.status(500).send(`Database query failed: ${err.message}`);
      }
  });
  
  // Regular Quiz
  app.get("/regular-quiz", async (req, res) => {
      const languageID = req.query.languageID;
      if (!languageID) return res.redirect("/language-list");
  
      try {
          const languageName = await languageModel.getLanguageName(languageID);
          if (!languageName) return res.status(404).send("Language not found.");
  
          const questions = await quizModel.getQuizQuestionsWithAnswers(1, languageID);
          res.render("regular-quiz", { questions, languageID, languageName });
      } catch (err) {
          res.status(500).send("Error retrieving quiz.");
      }
  });
  
  // Student Quiz
  app.get("/student-quiz", async (req, res) => {
      const languageID = req.query.languageID;
      if (!languageID) return res.redirect("/language-list");
  
      try {
          const languageName = await languageModel.getLanguageName(languageID);
          if (!languageName) return res.status(404).send("Language not found.");
  
          const questions = await quizModel.getQuizQuestionsWithAnswers(2, languageID);
          res.render("student-quiz", { questions, languageID, languageName });
      } catch (err) {
          res.status(500).send("Error retrieving quiz.");
      }
  });
  
  // Quiz Submission (Both Quiz Types)
  async function handleQuizSubmission(req, res) {
      try {
          const userAnswers = req.body;
          let score = 0;
          const results = [];
  
          for (let questionID in userAnswers) {
              const userAnswerID = userAnswers[questionID];
              const correct = await quizModel.getCorrectAnswer(questionID);
              const userAnswerText = await quizModel.getAnswerText(userAnswerID);
  
              const isCorrect = correct && correct.AnswerID == userAnswerID;
              if (isCorrect) score++;
  
              results.push({
                  questionID,
                  userAnswerID,
                  userAnswerText,
                  correctAnswerID: correct?.AnswerID,
                  correctAnswerText: correct?.AnswerText,
                  isCorrect
              });
          }
  
          res.render("quiz-results", { score, results });
      } catch (err) {
          res.status(500).send("Error processing quiz results.");
      }
  }
  
  app.post("/submit-quiz", handleQuizSubmission);
  app.post('/submit-student-quiz', async (req, res) => {
      const submittedAnswers = req.body;
      const questionIDs = Object.keys(submittedAnswers);
      const results = [];
      let score = 0;
  
      for (const questionID of questionIDs) {
          const selectedAnswerID = submittedAnswers[questionID];
          const answerInfo = await quizModel.getAnswerDetails(selectedAnswerID);
  
          const result = {
              questionID,
              isCorrect: answerInfo.isCorrect,
              userAnswerText: [{ AnswerText: answerInfo.answerText }],
              correctAnswerText: answerInfo.correctAnswerText
          };
  
          if (answerInfo.isCorrect) score++;
          results.push(result);
      }
  
      res.render('quiz-results', {
          score,
          results
      });
  });
  app.post("/submit-quiz", async (req, res) => {
      try {
          const userAnswers = req.body;
          let score = 0;
          const results = [];
  
          for (let questionID in userAnswers) {
              // Skip hidden form fields like languageID and quizID
              if (['languageID', 'quizID'].includes(questionID)) continue;
  
              const userAnswerID = userAnswers[questionID];
              const correct = await quizModel.getCorrectAnswer(questionID);
              const userAnswerText = await quizModel.getAnswerText(userAnswerID);
  
              const isCorrect = correct && correct.AnswerID == userAnswerID;
              if (isCorrect) score++;
  
              results.push({
                  questionID,
                  userAnswerID,
                  userAnswerText: userAnswerText ? userAnswerText.AnswerText : 'No answer selected',
                  correctAnswerID: correct?.AnswerID,
                  correctAnswerText: correct?.AnswerText,
                  isCorrect
              });
          }
  
          // Render results to the quiz-results.pug page
          res.render("quiz-results", { score, results, languageName: req.body.languageName });
      } catch (err) {
          console.error("Error processing quiz results:", err);
          res.status(500).send("Error processing quiz results.");
      }
  });
  
  
  
  // -------------------- ASSESSMENTS -------------------- //
  async function fetchAssessmentQuestions(categoryID, languageID) {
      const rows = await db.query(
          `SELECT q.QuestionID, q.QuestionText, a.AnswerID, a.AnswerText, a.IsCorrect
           FROM AssessmentQuestions q
           LEFT JOIN AssessmentAnswers a ON q.QuestionID = a.QuestionID
           WHERE q.LanguageID = ? AND q.CategoryID = ?
           ORDER BY q.QuestionID, a.AnswerID`,
          [languageID, categoryID]
      );
      const formatted = {};
      rows.forEach(row => {
          if (!formatted[row.QuestionID]) {
              formatted[row.QuestionID] = {
                  QuestionID: row.QuestionID,
                  QuestionText: row.QuestionText,
                  answers: []
              };
          }
          formatted[row.QuestionID].answers.push({
              AnswerID: row.AnswerID,
              AnswerText: row.AnswerText,
              IsCorrect: row.IsCorrect
          });
      });
      return Object.values(formatted);
  }
  
  app.get("/assessment-categories", async (req, res) => {
      const languageID = req.query.languageID;
      if (!languageID) return res.redirect("/language-list");
  
      try {
          const categories = await assessmentModel.getAssessmentCategories();
          res.render("assessmentcategories", { categories, languageID });
      } catch (err) {
          res.status(500).send(`Database query failed: ${err.message}`);
      }
  });
  
  
  
  app.get("/regular-assessment", async (req, res) => {
      const languageID = req.query.languageID;
      const languageName = await languageModel.getLanguageName(languageID);
      const questions = await assessmentModel.getAssessmentQuestionsWithAnswers("Regular", languageID);
      res.render("regular-assessment", { questions, languageID, languageName });
  });
  
  app.get("/student-assessment", async (req, res) => {
      const languageID = req.query.languageID;
      const languageName = await languageModel.getLanguageName(languageID);
      const questions = await assessmentModel.getAssessmentQuestionsWithAnswers("Student", languageID);
      res.render("student-assessment", { questions, languageID, languageName });
  });
  
  app.post("/submit-assessment", async (req, res) => {
      try {
          const userAnswers = req.body;  // User's submitted answers
          let score = 0;  // Initialize score
          let results = [];  // Array to store results for rendering
  
          // Loop through each question submitted by the user
          for (let questionID in userAnswers) {
              // Skip hidden fields or keys not representing a real question
              if (['languageID', 'assessmentID', 'assessmentType'].includes(questionID)) continue;
  
              const answerID = userAnswers[questionID];  // User's selected answer ID
              const correct = await assessmentModel.getCorrectAssessmentAnswer(questionID);  // Fetch correct answer from DB
              const userAnswerText = await assessmentModel.getAssessmentAnswerText(answerID);  // Fetch the answer text
  
              // Check if the user's answer is correct
              const isCorrect = correct?.AnswerID == answerID;
              if (isCorrect) score++;  // Increase score if the answer is correct
  
              // Store result for each question (question ID, user’s answer, correct answer, etc.)
              results.push({
                  questionID,
                  userAnswerID: answerID,
                  userAnswerText: userAnswerText || 'No answer selected',
                  correctAnswerID: correct?.AnswerID,
                  correctAnswerText: correct?.AnswerText || "No correct answer available",
                  isCorrect
              });
          }
  
          // Get the user's language ID (from the body or session)
          const languageID = req.body.languageID || req.session.selectedLanguageID;
  
          // Save user's progress if they are logged in
          const userID = req.session.user?.id;
          if (userID && languageID) {
              await assessmentModel.saveAssessmentProgress(userID, score, languageID);
          }
  
          // Render the results page and pass the score and results
          res.render("assessment-results", { score, results, languageName: req.body.languageName });
      } catch (err) {
          console.error("Error processing assessment results:", err);
          res.status(500).send("Error processing assessment results.");
      }
  });
  
  
  
  app.get("/cultural-insight", async (req, res) => {
      const languageID = req.query.languageID;
      if (!languageID) return res.redirect("/language-list");
  
      try {
          const language = await culturalInsightModel.getCulturalInsightsByLanguageID(languageID);
  
  
          if (!language) return res.status(404).send("No cultural insights found for this language.");
  
          res.render("Cultural-insights", { language });
      } catch (err) {
          console.error("Cultural insight error:", err);
          res.status(500).send("Server error fetching cultural insights.");
      }
  });
  
  
  // app.get("/progress-status", isAuthenticated, async (req, res) => {
  //     try {
  //         const userID = req.session.user.id;
  //         const quizProgress = await progressModel.getUserQuizProgress(userID);
  //         const assessmentProgress = await progressModel.getUserAssessmentProgress(userID);
  
  //         res.render("ProgressStatus", {
  //             quizProgress,
  //             assessmentProgress,
  //             user: req.session.user
  //         });
  //     } catch (err) {
  //         console.error("Progress Error:", err);
  //         res.status(500).send("Unable to load progress.");
  //     }
  // });
  // quizProgress.sort((a, b) => new Date(a.AttemptDate) - new Date(b.AttemptDate));
  // assessmentProgress.sort((a, b) => new Date(a.DateTaken) - new Date(b.DateTaken));
app.get("/forums", isAuthenticated, async (req, res) => {
    try {
      const userID = req.session.user.id;
      const recentChats = await forumModel.getUserGroupChats(userID);
      const languages = await languageModel.getAllLanguages();
      
      console.log("Recent chats for user", userID, recentChats);
  
      res.render("forums-home", {
        recentChats,
        languages,
        user: req.session.user
      });
    } catch (err) {
      console.error("Error in /forums:", err);
      res.status(500).send("Error loading forums");
    }
  });
  
  // Forum Join via Card Click
  app.post("/forums/select", isAuthenticated, (req, res) => {
    const { languageID } = req.body;
    if (!languageID) return res.status(400).send("Please select a language.");
    res.redirect(`/groupchat/${languageID}`);
  });
  
  // Group Chat Route
  app.get("/groupchat/:languageID", isAuthenticated, async (req, res) => {
    try {
      const userID = req.session.user.id;
      const languageID = req.params.languageID;
  
      const chat = await forumModel.getOrCreateGroupChat(languageID);
      const groupChatID = chat.GroupChatID;
  
      console.log("Joining Group Chat:", { userID, groupChatID, languageID });
  
      await forumModel.saveUserGroupChat(userID, groupChatID);
      console.log("Membership saved for", { userID, groupChatID });
  
      const messages = await forumModel.getMessagesByGroupChatID(groupChatID);
      const languageName = await languageModel.getLanguageName(languageID);
  
      io.to("forum-home").emit("newForumJoin", {
        userID,
        languageID,
        languageName
      });
  
      res.render("forum-chat", {
        messages,
        groupChatID,
        languageID,
        languageName,
        user: req.session.user
      });
    } catch (err) {
      console.error("❌ Error in /groupchat/:languageID:", err);
      res.status(500).send("Error joining group chat.");
    }
  });
  
  // Refresh Messages
  app.get("/groupchat/:languageID/refresh", isAuthenticated, async (req, res) => {
    try {
      const { languageID } = req.params;
      const chat = await forumModel.getOrCreateGroupChat(languageID);
      const messages = await forumModel.getMessagesByGroupChatID(chat.GroupChatID);
      res.json(messages);
    } catch (err) {
      res.status(500).json({ error: "Could not refresh messages" });
    }
  });
  
  // Send Chat Message
  app.post("/groupchat/:languageID/send", isAuthenticated, async (req, res) => {
    const userID = req.session.user.id;
    let groupChatID, messageText;
    if (req.headers['content-type']?.includes('application/json')) {
      ({ groupChatID, messageText } = req.body);
    } else {
      groupChatID = req.body.groupChatID;
      messageText = req.body.messageText;
    }
    if (!messageText || !messageText.trim()) {
      return res.status(400).json({ error: "Message cannot be empty" });
    }
    await forumModel.postMessage(groupChatID, userID, messageText);
    res.status(200).json({ success: true });
    
  });
  app.get("/api/groupchat/:groupChatID/messages", async (req, res) => {
      const { groupChatID } = req.params;
      try {
        const messages = await forumModel.getMessagesByGroupChatID(groupChatID);
        res.json(messages);
      } catch (error) {
        console.error("❌ Error in /api/groupchat/:groupChatID/messages:", error);
        res.status(500).json({ error: "Failed to get messages" });
      }
    });
    
    
    
    // Route to get and display user's progress status (quiz and assessment scores) by language
app.get("/progress-status", isAuthenticated, async (req, res) => {
      try {
          const userID = req.session.user.id;  // Get the user ID from session
          const languageID = req.query.languageID || req.session.selectedLanguageID;  // Get languageID from query or session
          
          if (!languageID) {
              return res.status(400).send("Language ID is required to view progress.");
          }
  
          // Query the database to get quiz progress for the user and the selected language
          const quizProgress = await progressModel.getUserQuizProgress(userID, languageID);
          
          // Query the database to get assessment progress for the user and the selected language
          const assessmentProgress = await progressModel.getUserAssessmentProgress(userID, languageID);
          
          // Render the progress status page and pass quiz and assessment progress data to the view
          res.render("ProgressStatus", {
              quizProgress,
              assessmentProgress,
              user: req.session.user, // Pass the user object for use in the view (e.g., name, id)
              languageID  // Pass the languageID to the view for possible use in language-related components
          });
      } catch (err) {
          console.error("Progress Error:", err);
          res.status(500).send("Unable to load progress.");
      }
  });
  
  // Error Pages
  app.use((req, res) => {
    res.status(404).render("404");
  });
  app.use((err, req, res) => {
    console.error(err.stack);
    res.status(500).render("500");
  });
  
  // Start Server
  server.listen(3000, () => {
    console.log("🚀 Server running at http://127.0.0.1:3000/");
  });
  