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

// Create a route for root - /
app.get("/", function(req, res) {
    res.send("Hello world!");
});

app.get("/Homepage", (req, res) => {
    res.render("homepage");
});


app.get("/quizcategories", async (req, res) => {
    try {
        // Fetch the Category Name and Description for Regular and Student quizzes
        const categories = await db.query(
            "SELECT CategoryName, Description FROM QuizCategories WHERE CategoryID IN (1, 2)"
        );

        if (!categories || categories.length === 0) {
            return res.status(404).send("No quiz categories found.");
        }

        console.log("Fetched Quiz Categories:", JSON.stringify(categories, null, 2));

        // Render the categories in the view
        res.render("quizcategories", { categories });
    } catch (err) {
        console.error("Database Error:", err);
        res.status(500).send(`Database query failed: ${err.message}`);
    }
});






app.get("/language-list", async (req, res) => {
    try {
        // Fetch all languages dynamically from the LanguageList table
        const languages = await db.query("SELECT LanguageID, LanguageName FROM LanguageList");

        if (!languages || languages.length === 0) {
            return res.status(404).send("No languages found in database.");
        }

        console.log("Fetched Languages:", languages);
        res.render("language-list", { languages });
    } catch (err) {
        console.error("Database Error:", err);
        res.status(500).send(`Database query failed: ${err.message}`);
    }
});





app.get("/users-list", async (req, res) => {
    try {
        const users = await db.query(
            `SELECT u.UserID, u.ProfilePicture AS profile_picture, u.Name AS name, 
                    u.Email AS email, u.PhoneNumber AS phone_number, u.Bio AS bio, 
                    u.CreatedAt AS created_at, 
                    COALESCE(l.Description, 'Not specified') AS language_description, 
                    COALESCE(l.Region, 'Unknown') AS language_region
             FROM Users u
             LEFT JOIN LanguageDetail l ON u.UserID = l.DetailID
             ORDER BY u.CreatedAt DESC`
        );

        if (!users || users.length === 0) {
            return res.status(404).send("No users found in database.");
        }

        console.log("Fetched Users:", users);
        res.render('users-list', { users });
    } catch (err) {
        console.error("Database Error:", err);
        res.status(500).send(`Database query failed: ${err.message}`);
    }
});


app.get("/userprofile/:id", async (req, res) => {
    try {
        const sql = `
            SELECT u.UserID, u.ProfilePicture AS profile_picture, u.Name AS name, 
                   u.Email AS email, u.PhoneNumber AS phone_number, u.Bio AS bio, 
                   u.CreatedAt AS created_at, 
                   COALESCE(l.Description, 'Not specified') AS language_description, 
                   COALESCE(l.Region, 'Unknown') AS language_region
            FROM Users u
            LEFT JOIN LanguageDetail l ON u.UserID = l.DetailID
            WHERE u.UserID = ? LIMIT 1
        `;

        const users = await db.query(sql, [req.params.id]);

        if (!users || users.length === 0) {
            return res.status(404).send("User Not Found");
        }

        console.log("Fetched User Profile:", users[0]);
        res.render("userprofile", { user: users[0] });
    } catch (err) {
        console.error("Database Error:", err);
        res.status(500).send("Database query failed: " + err.message);
    }
});

// Login page
app.get("/login", (req, res) => {
    res.render("login");
});

// Handle login
app.post("/login", async (req, res) => {
    try {
        const { email, password } = req.body;
        const users = await db.query('SELECT * FROM Users WHERE Email = ? AND Password = ?', [email, password]);

        if (users.length === 0) {
            return res.status(400).send("Invalid email or password.");
        }

        req.session.user = users[0]; // Store user in session
        res.redirect(`/userprofile/${users[0].UserID}`); // Redirect to user profile
    } catch (err) {
        console.error("Login error:", err);
        res.status(500).send("Server error");
    }
});


// Signup page
app.get("/signup", (req, res) => {
    res.render("signup");
});

// Handle signup (Saves user to database)
app.post("/signup", async (req, res) => {
    try {
        const { name, email, password, phone_number, bio } = req.body;

        // Check if email already exists
        const existingUser = await db.query('SELECT * FROM Users WHERE Email = ?', [email]);
        if (existingUser.length > 0) {
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

        console.log(`User ${name} registered successfully.`);
        res.redirect("/login"); // Redirect to login after signup
    } catch (err) {
        console.error("Signup error:", err);
        res.status(500).send("Server error");
    }
});

// Handle logout
app.get("/logout", (req, res) => {
    req.session.destroy(() => {
        res.redirect("/login");
    });
});

// Function to fetch quiz questions
async function fetchQuizQuestions(categoryID) {
    try {
        const rows = await db.query(
            `SELECT q.QuestionID, q.QuestionText, a.AnswerID, a.AnswerText, a.IsCorrect
             FROM QuizQuestions q 
             JOIN QuizAnswers a ON q.QuestionID = a.QuestionID 
             JOIN QuizDetails d ON q.QuizID = d.QuizID 
             WHERE d.CategoryID = ?`, 
            [categoryID]
        );

        if (!rows.length) {
            console.log(`No questions found for category: ${categoryID}`);
            return [];
        }

        return formatQuestions(rows);
    } catch (error) {
        console.error("Error fetching quiz questions:", error);
        return [];
    }
}

// Format questions into a structured format
function formatQuestions(rows) {
    const questions = {};

    rows.forEach(row => {
        if (!questions[row.QuestionID]) {
            questions[row.QuestionID] = {
                QuestionID: row.QuestionID,
                QuestionText: row.QuestionText,
                answers: []
            };
        }
        questions[row.QuestionID].answers.push({
            AnswerID: row.AnswerID,
            AnswerText: row.AnswerText,
            IsCorrect: row.IsCorrect
        });
    });

    return Object.values(questions);
}

// Regular Quiz Route
app.get("/regular-quiz", async (req, res) => {
    try {
        const questions = await fetchQuizQuestions(1);
        res.render("regular-quiz", { questions });
    } catch (error) {
        console.error("Database Error:", error);
        res.status(500).send("Error retrieving regular quiz questions.");
    }
});

// Student Quiz Route
app.get("/student-quiz", async (req, res) => {
    try {
        const questions = await fetchQuizQuestions(2);
        res.render("student-quiz", { questions });
    } catch (error) {
        console.error("Database Error:", error);
        res.status(500).send("Error retrieving student quiz questions.");
    }
});

// Handle Quiz Submission
app.post("/submit-quiz", async (req, res) => {
    try {
        const userAnswers = req.body;
        let score = 0;
        let results = [];

        for (let key in userAnswers) {
            const answerID = userAnswers[key];
            const correctAnswer = await db.query("SELECT IsCorrect FROM QuizAnswers WHERE AnswerID = ?", [answerID]);

            if (correctAnswer.length && correctAnswer[0].IsCorrect === 1) {
                score++;
                results.push({ question: key, isCorrect: true });
            } else {
                results.push({ question: key, isCorrect: false });
            }
        }

        res.render("quiz-results", { score, results });
    } catch (error) {
        console.error("Error processing quiz submission:", error);
        res.status(500).send("Error processing quiz results.");
    }
});



// Create a route for testing the db
app.get("/db_test", function(req, res) {
    // Assumes a table called test_table exists in your database
    sql = 'select * from test_table';
    db.query(sql).then(results => {
        console.log(results);
        res.send(results)
    });
});

// Create a route for /goodbye
// Responds to a 'GET' request
app.get("/goodbye", function(req, res) {
    res.send("Goodbye world!");
});

// Create a dynamic route for /hello/<name>, where name is any value provided by user
// At the end of the URL
// Responds to a 'GET' request
app.get("/hello/:name", function(req, res) {
    // req.params contains any parameters in the request
    // We can examine it in the console for debugging purposes
    console.log(req.params);
    //  Retrieve the 'name' parameter and use it in a dynamically generated page
    res.send("Hello " + req.params.name);
});

// Start server on port 3000
app.listen(3000,function(){
    console.log(`Server running at http://127.0.0.1:3000/`);
});
