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

// Create a route for root - /home page 
app.get("/Homepage", function(req, res) {
    res.send("Baris needs to input the query");
});


app.get("/userprofile/:id", async function(req, res) {
    try {
        const sql = `
            SELECT UserID, ProfilePicture AS profile_picture, Name AS name, 
                   Email AS email, PhoneNumber AS phone_number, Bio AS bio, 
                   CreatedAt AS created_at, LearningLanguage AS learning_language
            FROM Users WHERE UserID = ? LIMIT 1
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

app.get("/users-list", async function(req, res) {
    try {
        const users = await db.query(
            `SELECT DISTINCT UserID, ProfilePicture AS profile_picture, Name AS name, 
            Email AS email, PhoneNumber AS phone_number, Bio AS bio, 
            CreatedAt AS created_at, LearningLanguage AS learning_language 
            FROM Users`
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