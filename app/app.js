// Import express.js
const express = require("express");

// Create express app
var app = express();

// Add static files location
app.use(express.static("static"));

// Use the Pug templating engine
app.set('view engine', 'pug');
app.set('views', './app/views');

// Get the functions in the db.js file to use
const db = require('./services/db');

app.use(express.urlencoded({ extended: true })); // Ensure form data is parsed
app.use(express.json()); // Ensure JSON data is parsed

// -------------------- ROUTES -------------------- //


// Homepage
app.get("/Homepage", (req, res) => {
    res.render("homepage");
});

// -------------------- LANGUAGE SELECTION -------------------- //
// Fetch User Profile Data
// Fetch User Profile Data
// Fetch User Profile Data
app.get("/userprofile/:id", async (req, res) => {
    try {
        const sql = `
            SELECT UserID, Name AS name, Email AS email, 
                   PhoneNumber AS phone_number, Bio AS bio, 
                   ProfilePicture AS profile_picture, CreatedAt AS created_at
            FROM Users
            WHERE UserID = ? LIMIT 1
        `;

        const users = await db.query(sql, [req.params.id]);

        if (!users || users.length === 0) {
            return res.status(404).send("User Not Found");
        }

        console.log(" Fetched User Profile:", users[0]);
        res.render("userprofile", { user: users[0] });
    } catch (err) {
        console.error(" Database Error:", err);
        res.status(500). send("Database query failed: " + err.message);
    }
});



// -------------------- LOGIN -------------------- //
app.get("/login", (req, res) => {
    res.render("login");
});

app.post("/login", async (req, res) => {
    try {
        const { email, password } = req.body;
        console.log("🔹 Login Attempt:", email);

        // Fetch user from database
        const users = await db.query(
            "SELECT * FROM Users WHERE Email = ? AND Password = ?",
            [email, password]
        );

        if (users.length === 0) {
            console.log(" Error: Invalid email or password.");
            return res.status(400).send("Invalid email or password.");
        }

        const user = users[0];
        console.log(` Login successful. Redirecting to /userprofile/${user.UserID}`);
        res.redirect(`/userprofile/${user.UserID}`); // Redirect to user profile
    } catch (err) {
        console.error("Login error:", err);
        res.status(500).send("Server error.");
    }
});

// -------------------- SIGNUP -------------------- //
app.get("/signup", (req, res) => {
    res.render("signup");
});

app.post("/signup", async (req, res) => {
    try {
        const { name, email, password, phone_number, bio } = req.body;
        console.log(" Signup Attempt:", email);

        // Check if email already exists
        const existingUser = await db.query("SELECT * FROM Users WHERE Email = ?", [email]);
        if (existingUser.length > 0) {
            console.log(" Error: Email already registered.");
            return res.status(400).send("Email already registered. Please log in.");
        }

        // Generate a unique UserID
        const userId = `U${Math.floor(1000 + Math.random() * 9000)}`;

        // Insert new user into the database
        await db.query(
            `INSERT INTO Users (UserID, Name, Email, Password, PhoneNumber, Bio, CreatedAt) 
             VALUES (?, ?, ?, ?, ?, ?, NOW())`,
            [userId, name, email, password, phone_number, bio]
        );

        console.log(` User ${name} registered successfully.`);
        res.redirect("/login"); // Redirect to login after signup
    } catch (err) {
        console.error(" Signup error:", err);
        res.status(500).send("Server error.");
    }
});

// -------------------- LOGOUT -------------------- //
app.get("/logout", (req, res) => {
    res.redirect("/login");
});

// -------------------- LANGUAGE SELECTION -------------------- //

app.get("/language-list", async (req, res) => {
    try {
        const languages = await db.query("SELECT LanguageID, LanguageName FROM LanguageList");

        if (!languages || languages.length === 0) {
            return res.status(404).send("No languages found in database.");
        }

        console.log(" Fetched Languages:", languages);
        res.render("language-list", { languages });
    } catch (err) {
        console.error(" Database Error:", err);
        res.status(500).send(`Database query failed: ${err.message}`);
    }
});

app.post("/select-language", (req, res) => {
    const { languageID } = req.body;

    if (!languageID) {
        console.log(" No language selected.");
        return res.status(400).send("No language selected.");
    }

    console.log(" Language Selected:", languageID);

    // Redirect with `languageID` in the URL
    res.redirect(`/selection-list?languageID=${languageID}`);
});

// -------------------- SELECTION LIST -------------------- //

app.get("/selection-list", async (req, res) => {
    const languageID = req.query.languageID;

    if (!languageID) {
        console.log(" Language ID missing! Redirecting to /language-list");
        return res.redirect("/language-list");
    }

    try {
        const options = await db.query("SELECT SelectionID, SelectionName, Description FROM SelectionOptions");

        if (!options || options.length === 0) {
            return res.status(404).send("No selection options found in database.");
        }

        console.log(" Fetched Selection Options:", options);
        res.render("selection-list", { options, languageID });
    } catch (err) {
        console.error(" Database Error:", err);
        res.status(500).send(`Database query failed: ${err.message}`);
    }
});

app.post("/select", async (req, res) => {
    try {
        console.log(" Received POST request at /select");
        console.log(" Full Request Body:", req.body); // Debug request data

        const selectedOption = req.body.selection;
        const languageID = req.body.languageID;

        console.log(" Selected Option:", selectedOption);
        console.log(" Language ID:", languageID);

        if (!selectedOption) {
            console.log(" Error: No option selected.");
            return res.status(400).send("No option selected.");
        }

        if (!languageID) {
            console.log(" Error: Missing Language ID.");
            return res.status(400).send("Language ID is missing.");
        }

        let redirectUrl = "";

        // Define selection-based redirects
        switch (selectedOption) {
            case "quiz":
                redirectUrl = `/quizcategories?languageID=${languageID}`;
                break;
            case "assessment":
                redirectUrl = `/assessment?languageID=${languageID}`;
                break;
            case "progress":
                redirectUrl = `/progress-status?languageID=${languageID}`;
                break;
            case "cultural":
                redirectUrl = `/cultural-insight?languageID=${languageID}`;
                break;
            default:
                console.log(" Error: Invalid selection.");
                return res.status(400).send("Invalid selection.");
        }

        console.log(` Redirecting to: ${redirectUrl}`);
        res.redirect(redirectUrl);
    } catch (err) {
        console.error(" Error processing selection:", err);
        res.status(500).send("Error processing selection.");
    }
});



// -------------------- QUIZ CATEGORY SELECTION -------------------- //

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


// -------------------- SERVER START -------------------- //
app.listen(3000, function () {
    console.log(`🚀 Server running at http://127.0.0.1:3000/`);
});