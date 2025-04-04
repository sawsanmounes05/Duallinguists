// Import express.js
const express = require("express");
const bcrypt = require("bcryptjs");

// Create express app
const app = express();

// Add session middleware
const session = require("express-session");
// --------- SESSION --------- //
app.use(session({
    secret: "your-secret-key",
    resave: false,
    saveUninitialized: true,
    cookie: {
        secure: false, // change to true if using HTTPS
        sameSite: 'lax' // helps retain session on redirects
    }
}));

// ---------session id--------- //
app.use((req, res, next) => {
    res.locals.user = req.session.user || null;
    next();
});

// Add cookie parser middleware
// Add static files location
app.use(express.static("static"));

// Use the Pug templating engine
app.set('view engine', 'pug');
app.set('views', './app/views');

// Get the functions in the db.js file to use
const db = require('./services/db');

app.use(express.urlencoded({ extended: true })); // Ensure form data is parsed
app.use(express.json()); // Ensure JSON data is parsed

// -------------------- MIDDLEWARE -------------------- //
function isAuthenticated(req, res, next) {
    if (req.session.user) return next();
    res.redirect("/login");
}

// -------------------- ROUTES -------------------- //

// Homepage
app.get("/Homepage", (req, res) => {
    res.render("homepage");
});

// Login
app.get("/login", (req, res) => res.render("login"));

app.post("/login", async (req, res) => {
    try {
        const { email, password } = req.body;
        const users = await db.query("SELECT * FROM Users WHERE Email = ?", [email]);
        if (users.length === 0 || !await bcrypt.compare(password, users[0].Password)) {
            return res.status(400).send("Invalid email or password.");
        }
        req.session.user = { id: users[0].UserID, name: users[0].Name };
        const redirectLanguageID = req.session.selectedLanguageID;
        if (redirectLanguageID) return res.redirect(`/selection-list?languageID=${redirectLanguageID}`);
        res.redirect(`/userprofile/${users[0].UserID}`);
    } catch (err) {
        res.status(500).send("Server error.");
    }
});

// Signup
app.get("/signup", (req, res) => res.render("signup"));

app.post("/signup", async (req, res) => {
    try {
        const { name, email, password, phone_number, bio } = req.body;
        const existingUser = await db.query("SELECT * FROM Users WHERE Email = ?", [email]);
        if (existingUser.length > 0) return res.status(400).send("Email already registered.");

        const hashedPassword = await bcrypt.hash(password, 10);
        const userId = `U${Math.floor(1000 + Math.random() * 9000)}`;

        await db.query(
            `INSERT INTO Users (UserID, Name, Email, Password, PhoneNumber, Bio, CreatedAt) 
             VALUES (?, ?, ?, ?, ?, ?, NOW())`,
            [userId, name, email, hashedPassword, phone_number, bio]
        );

        res.redirect("/login");
    } catch (err) {
        res.status(500).send("Server error.");
    }
});

// Logout
app.get("/logout", (req, res) => {
    req.session.destroy(() => res.redirect("/login"));
});

app.get("/userprofile/:id?", async (req, res) => {
    try {
        let userID = req.params.id;

        // ✅ If user is logged in but no ID in URL or it's 'undefined'
        if ((!userID || userID === "undefined") && req.session.user && req.session.user.id) {
            userID = req.session.user.id;
        }

        // ❌ If still no user ID, redirect to login
        if (!userID) {
            return res.redirect('/login'); // or show custom error
        }

        const sql = `
            SELECT UserID, Name AS name, Email AS email, 
                   PhoneNumber AS phone_number, Bio AS bio, 
                   ProfilePicture AS profile_picture, CreatedAt AS created_at
            FROM Users
            WHERE UserID = ? LIMIT 1
        `;

        const users = await db.query(sql, [userID]);

        if (!users || users.length === 0) {
            return res.status(404).send("User Not Found");
        }

        res.render("userprofile", { user: users[0] });
    } catch (err) {
        console.error("Database Error:", err);
        res.status(500).send("Database query failed: " + err.message);
    }
});


// Edit User Profile            
// Users List
app.get("/users-list", async (req, res) => {
    try {
        const [users] = await db.query(`SELECT UserID, ProfilePicture, Name, Email, PhoneNumber, Bio, CreatedAt FROM Users ORDER BY CreatedAt DESC`);
        if (!users.length) return res.status(404).send("No users found.");
        res.render("users-list", { users });
    } catch (err) {
        res.status(500).send(`Database query failed: ${err.message}`);
    }
});
/ -------------------- QUIZ CATEGORY SELECTION -------------------- //

app.get("/quizcategories", async (req, res) => {
    const languageID = req.query.languageID;

    if (!languageID) {
        console.log(" Language ID missing! Redirecting to /language-list");
        return res.redirect("/language-list");
    }

    try {
        const categories = await db.query(
            "SELECT CategoryID, CategoryName, Description FROM QuizCategories WHERE CategoryID IN (1, 2)"
        );

        if (!categories || categories.length === 0) {
            return res.status(404).send("No quiz categories found.");
        }

        console.log(" Retrieved Language ID:", languageID);
        res.render("quizcategories", { categories, languageID });
    } catch (err) {
        console.error(" Database Error:", err);
        res.status(500).send(`Database query failed: ${err.message}`);
    }
});


// -------------------- QUIZ PAGES -------------------- //

async function fetchQuizQuestions(categoryID, languageID) {
    console.log("🔍 Fetching questions for Category:", categoryID, "Language:", languageID);

    if (!languageID || !categoryID) {
        console.log(" Error: Missing languageID or categoryID in fetchQuizQuestions.");
        return [];
    }

    try {
        const rows = await db.query(
            `SELECT q.QuestionID, q.QuestionText, a.AnswerID, a.AnswerText, a.IsCorrect
             FROM QuizQuestions q
             LEFT JOIN QuizAnswers a ON q.QuestionID = a.QuestionID
             WHERE q.LanguageID = ? AND q.CategoryID = ?
             ORDER BY q.QuestionID, a.AnswerID`,
            [languageID, categoryID]
        );

        if (!rows.length) {
            console.log(` No questions found for Category ${categoryID} and Language ${languageID}`);
            return [];
        }

        console.log(" Raw Data Fetched from Database:", rows);

        // Format questions so that each question has a list of answers
        const formattedQuestions = {};
        rows.forEach(row => {
            if (!formattedQuestions[row.QuestionID]) {
                formattedQuestions[row.QuestionID] = {
                    QuestionID: row.QuestionID,
                    QuestionText: row.QuestionText,
                    answers: []
                };
            }
            formattedQuestions[row.QuestionID].answers.push({
                AnswerID: row.AnswerID,
                AnswerText: row.AnswerText,
                IsCorrect: row.IsCorrect
            });
        });

        console.log(" Formatted Questions:", Object.values(formattedQuestions));
        return Object.values(formattedQuestions);
    } catch (error) {
        console.error(" Error fetching quiz questions:", error);
        return [];
    }
}




app.get("/regular-quiz", async (req, res) => {
    const languageID = req.query.languageID;

    if (!languageID) {
        console.log(" Language ID missing, redirecting.");
        return res.redirect("/language-list");
    }

    try {
        const languageData = await db.query(
            "SELECT LanguageName FROM LanguageList WHERE LanguageID = ?",
            [languageID]
        );

        if (!languageData.length) {
            console.log(" No language found for ID:", languageID);
            return res.status(404).send("Language not found.");
        }

        const languageName = languageData[0].LanguageName;
        console.log(` Language Retrieved: ${languageName}`);

        // Fetch quiz questions for Regular Quiz (Category 1)
        const questions = await fetchQuizQuestions(1, languageID);
        console.log(" Questions Sent to Pug:", questions);

        res.render("regular-quiz", { questions, languageID, languageName });
    } catch (error) {
        console.error(" Database Error:", error);
        res.status(500).send("Error retrieving regular quiz questions.");
    }
});
app.post("/submit-quiz", async (req, res) => {
    try {
        const userAnswers = req.body; // User's submitted answers
        let score = 0;
        let results = [];

        console.log(" User Quiz Submission:", userAnswers);

        // Iterate over each question the user answered
        for (let questionID in userAnswers) {
            const answerID = userAnswers[questionID];

            // Fetch correct answer from the database
            const correctAnswer = await db.query(
                "SELECT AnswerID, AnswerText, IsCorrect FROM QuizAnswers WHERE QuestionID = ? AND IsCorrect = 1",
                [questionID]
            );

            if (correctAnswer.length > 0) {
                const isCorrect = correctAnswer[0].AnswerID == answerID;
                if (isCorrect) score++;

                results.push({
                    questionID: questionID,
                    userAnswerID: answerID,
                    userAnswerText: await db.query("SELECT AnswerText FROM QuizAnswers WHERE AnswerID = ?", [answerID]),
                    correctAnswerID: correctAnswer[0].AnswerID,
                    correctAnswerText: correctAnswer[0].AnswerText,
                    isCorrect: isCorrect
                });
            }
        }

        console.log(` User scored ${score} correct answers.`);
        console.log(" Answer Results:", results);

        res.render("quiz-results", { score, results });
    } catch (error) {
        console.error(" Error processing quiz submission:", error);
        res.status(500).send("Error processing quiz results.");
    }
});



app.get("/student-quiz", async (req, res) => {
    const languageID = req.query.languageID;

    if (!languageID) {
        console.log(" Language ID missing, redirecting.");
        return res.redirect("/language-list");
    }

    try {
        const languageData = await db.query(
            "SELECT LanguageName FROM LanguageList WHERE LanguageID = ?",
            [languageID]
        );

        if (!languageData.length) {
            console.log(" No language found for ID:", languageID);
            return res.status(404).send("Language not found.");
        }

        const languageName = languageData[0].LanguageName;
        console.log(` Language Retrieved: ${languageName}`);

        // Fetch quiz questions for Student Quiz (Category 2)
        const questions = await fetchQuizQuestions(2, languageID);
        console.log(" Questions Sent to Pug:", questions);

        res.render("student-quiz", { questions, languageID, languageName });
    } catch (error) {
        console.error(" Database Error:", error);
        res.status(500).send("Error retrieving student quiz questions.");
    }
});

app.post("/submit-student-quiz", async (req, res) => {  
    try {
        const userAnswers = req.body; // User's submitted answers
        let score = 0;
        let results = [];

        console.log(" User Quiz Submission:", userAnswers);

        // Iterate over each question the user answered
        for (let questionID in userAnswers) {
            const answerID = userAnswers[questionID];

            // Fetch correct answer from the database
            const correctAnswer = await db.query(
                "SELECT AnswerID, AnswerText, IsCorrect FROM QuizAnswers WHERE QuestionID = ? AND IsCorrect = 1",
                [questionID]
            );

            if (correctAnswer.length > 0) {
                const isCorrect = correctAnswer[0].AnswerID == answerID;
                if (isCorrect) score++;

                results.push({
                    questionID: questionID,
                    userAnswerID: answerID,
                    userAnswerText: await db.query("SELECT AnswerText FROM QuizAnswers WHERE AnswerID = ?", [answerID]),
                    correctAnswerID: correctAnswer[0].AnswerID,
                    correctAnswerText: correctAnswer[0].AnswerText,
                    isCorrect: isCorrect
                });
            }
        }

        console.log(` User scored ${score} correct answers.`);
        console.log(" Answer Results:", results);

        res.render("quiz-results", { score, results });
    } catch (error) {
        console.error(" Error processing quiz submission:", error);
        res.status(500).send("Error processing quiz results.");
    }
}
);
// -------------------- ASSESSMENT -------------------- //      
// Language List
app.get("/language-list", async (req, res) => {
    try {
        const languages = await db.query("SELECT LanguageID, LanguageName FROM LanguageList");
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
        const options = await db.query("SELECT SelectionID, SelectionName, Description FROM SelectionOptions");
        res.render("selection-list", { options, languageID });
    } catch (err) {
        res.status(500).send(`Database query failed: ${err.message}`);
    }
});

app.post("/select", isAuthenticated, async (req, res) => {
    const { selection, languageID } = req.body;
    if (!selection || !languageID) return res.status(400).send("Missing data.");

    const redirectMap = {
        quiz: "/quizcategories",
        assessment: "/assessment",
        progress: "/progress-status",
        cultural: "/cultural-insight"
    };

    if (!redirectMap[selection]) return res.status(400).send("Invalid selection.");
    res.redirect(`${redirectMap[selection]}?languageID=${languageID}`);
});

// -------------------- SERVER -------------------- //
app.listen(3000, () => console.log("🚀 Server running at http://127.0.0.1:3000/"));
// -------------------- ERROR HANDLING -------------------- //
app.use((req, res) => {
    res.status(404).render("404");
});
app.use((err, req, res) => {
    console.error(err.stack);
    res.status(500).render("500");
});