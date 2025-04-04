const db = require("../services/db");

async function getAllUsers() {
    const [users] = await db.query(`
        SELECT UserID, ProfilePicture, Name, Email, PhoneNumber, Bio, CreatedAt
        FROM Users ORDER BY CreatedAt DESC
    `);
    return users;
}

async function getUserById(userId) {
    const [user] = await db.query(`
        SELECT UserID, Name AS name, Email AS email,
               PhoneNumber AS phone_number, Bio AS bio,
               ProfilePicture AS profile_picture, CreatedAt AS created_at
        FROM Users WHERE UserID = ? LIMIT 1
    `, [userId]);
    return user;
}

async function getUserByEmail(email) {
    const [user] = await db.query("SELECT * FROM Users WHERE Email = ?", [email]);
    return user;
}

async function createUser({ userId, name, email, hashedPassword, phone_number, bio }) {
    return await db.query(`
        INSERT INTO Users (UserID, Name, Email, Password, PhoneNumber, Bio, CreatedAt)
        VALUES (?, ?, ?, ?, ?, ?, NOW())
    `, [userId, name, email, hashedPassword, phone_number, bio]);
}

module.exports = {
    getAllUsers,
    getUserById,
    getUserByEmail,
    createUser
};
