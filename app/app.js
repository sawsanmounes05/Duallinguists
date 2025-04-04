const express = require("express");
const bcrypt = require("bcryptjs");
const session = require("express-session");

const { userModel, quizModel, languageModel, selectionModel } = require("./models");

const app = express();

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
app.get("/signup", (req, res) => res.render("signup"));

app.post("/signup", async (req, res) => {
    try {
        const { name, email, password, phone_number, bio } = req.body;
        const existingUser = await userModel.getUserByEmail(email);
        if (existingUser) return res.status(400).send("Email already registered.");

        const hashedPassword = await bcrypt.hash(password, 10);
        const userId = `U${Math.floor(1000 + Math.random() * 9000)}`;

        await userModel.createUser({
            userId,
            name,
            email,
            hashedPassword,
            phone_number,
            bio
        });

        res.redirect("/login");
    } catch (err) {
        res.status(500).send("Server error.");
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

// Assessment
app.get("/assessment", (req, res) => {
    res.render("Assessment");
});

// Assessment Answers
app.get("/assessment-answers", (req, res) => {
    res.render("AssessmentAnswers");
});

// Cultural Insights
app.get("/cultural-insights", (req, res) => {
    res.render("CulturalInsights");
});

// Forums
app.get("/forums", (req, res) => {
    res.render("Forums", { users: [] }); // Placeholder for forum users
});

// Progress Status
app.get("/progress-status", (req, res) => {
    res.render("ProgressStatus");
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



