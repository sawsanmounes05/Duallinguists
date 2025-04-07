const express = require("express");
const bcrypt = require("bcryptjs");
const session = require("express-session");


const {
    userModel,
    quizModel,
    languageModel,
    selectionModel,
    assessmentModel,
    culturalInsightModel,
    forumModel
    
  } = require("./models");
  
const app = express();
// Add the function at the top or within a controller file
const getUserProgress = async (userID) => {
    try {
        const [userProgress] = await db.query(`
            SELECT *
            FROM UserProgress
            WHERE UserID = ?
            ORDER BY DateTaken DESC
        `, [userID]);

        if (userProgress.length > 0) {
            console.log("User progress found:", userProgress);
            return userProgress;
        } else {
            console.log("No progress data found for user:", userID);
            return [];
        }
    } catch (error) {
        console.error("Error fetching user progress:", error);
        throw error;
    }
};


// SESSION SETUP
app.use(session({
    secret: "your-secret-key",
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false, sameSite: "lax" }
}));

app.use((req, res, next) => {
    res.locals.user = req.session.user || null;
    next();
});

// MIDDLEWARE & CONFIG
app.use(express.static("static"));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.set("view engine", "pug");
app.set("views", "./app/views");

function isAuthenticated(req, res, next) {
    if (req.session.user) return next();
    res.redirect("/login");
}

// ROUTES

// Homepage
app.get("/", (req, res) => {
    res.render("homepage");
});
// Homepage
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

// Users List
app.get("/users-list", async (req, res) => {
    try {
        const users = await userModel.getAllUsers();
        if (!users || users.length === 0) return res.status(404).send("No users found.");
        res.render("users-list", { users });
    } catch (err) {
        res.status(500).send(`Database query failed: ${err.message}`);
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
app.post("/submit-student-quiz", handleQuizSubmission);
app.post("/submit-quiz", async (req, res) => {
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

        const userID = req.session.user?.id;
        if (userID) {
            await progressModel.saveQuizProgress(userID, score); // Save quiz progress
        }

        res.render("quiz-results", { score, results });
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
        const userAnswers = req.body;
        let score = 0;
        let results = [];

        for (let questionID in userAnswers) {
            const answerID = userAnswers[questionID];

            const correct = await assessmentModel.getCorrectAssessmentAnswer(questionID);
            const userAnswerText = await assessmentModel.getAssessmentAnswerText(answerID);

            const isCorrect = correct?.AnswerID == answerID;
            if (isCorrect) score++;

            results.push({
                questionID,
                userAnswerID: answerID,
                userAnswerText,
                correctAnswerID: correct?.AnswerID,
                correctAnswerText: correct?.AnswerText,
                isCorrect
            });
        }
        const userID = req.session.user?.id;
        if (userID) {
            await progressModel.saveAssessmentProgress(userID, score);
        }
        res.render("assessment-results", { score, results });
    } catch (err) {
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

// Forums homepage with language selector
app.get("/forums", isAuthenticated, async (req, res) => {
    const languages = await languageModel.getAllLanguages();
    res.render("forums-home", { languages });
});

// Handle language selection
app.post("/forums/select", isAuthenticated, (req, res) => {
    const { languageID } = req.body;
    if (!languageID) return res.status(400).send("Please select a language.");
    res.redirect(`/groupchat/${languageID}`);
});

// Load forum chat for selected language
app.get("/groupchat/:languageID", isAuthenticated, async (req, res) => {
    const { languageID } = req.params;
    const userID = req.session.user.id;

    const chat = await forumModel.getOrCreateGroupChat(languageID);
    const messages = await forumModel.getMessagesByGroupChatID(chat.GroupChatID);
    const languageName = await languageModel.getLanguageName(languageID);

    res.render("forum-chat", {
        messages,
        groupChatID: chat.GroupChatID,
        languageID,
        languageName,
        user: req.session.user
    });
});

app.post("/groupchat/:languageID/send", isAuthenticated, async (req, res) => {
    const { groupChatID, messageText } = req.body;
    const userID = req.session.user.id;

    if (!messageText.trim()) return res.redirect("back");

    await forumModel.postMessage(groupChatID, userID, messageText);
    res.redirect("back");
});



// SERVER + ERROR HANDLING
app.listen(3000, () => console.log("🚀 Server running at http://127.0.0.1:3000/"));

app.use((req, res) => {
    res.status(404).render("404");
});

app.use((err, req, res) => {
    console.error(err.stack);
    res.status(500).render("500");
});



