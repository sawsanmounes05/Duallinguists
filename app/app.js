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

// Create a route for root - /categories
app.get("/categories", function(req, res) {
    res.send("Baris needs to input the query");
});

// Create a route for root - /Language-detail
app.get("/Language-detail", function(req, res) {
    res.send("Baris needs to input the query");
});
// Create a route for root - /languages - listing page
app.get("/Language-list", function(req, res) {
    res.send("Baris needs to input the query");
});

app.get("/languagelist", async function(req, res) {
    try {
        const sql = `
            SELECT 
                u.UserID, 
                u.ProfilePicture AS profile_picture, 
                u.Name AS name,   
                l.LanguageName AS learning_language
            FROM Users u
            LEFT JOIN LanguageList l ON u.LearningLanguage = l.LanguageID
            WHERE u.UserID = ? 
            LIMIT 1
        `; 

        const users = await db.query(sql, [req.params.id]);

        if (!users || users.length === 0) {
            return res.status(404).send("User Not Found");
        }

        console.log("Fetched User Profile:", users[0]); // Debugging
        res.render("userprofile", { user: users[0] });
    } catch (err) {
        console.error("Database Error:", err);
        res.status(500).send("Database query failed: " + err.message);
    }
});

app.get("/quizcategories", async (req, res) => {
    try {
        // Fetch all quiz categories using correct column names
        const categories = await db.query("SELECT CategoryID, CategoryName, Description FROM QuizCategories");

        if (!categories || categories.length === 0) {
            return res.status(404).send("No quiz categories found in database.");
        }

        console.log("Fetched Quiz Categories:", categories);
        res.render("quizcategories", { categories });
    } catch (err) {
        console.error("Database Error:", err);
        res.status(500).send(`Database query failed: ${err.message}`);
    }
});


// Language detail route
app.get("/Language-detail", (req, res) => {
    res.send("Baris needs to input the query");
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
