const db = require("../services/db");
async function getUserQuizProgress(userID) {
    const [rows] = await db.query(`
        SELECT * FROM UserProgress
        WHERE UserID = ? AND QuizScore IS NOT NULL
        ORDER BY LastUpdated DESC
    `, [userID]);
    return rows;
}

async function getUserProgress(userID) {
    const [result] = await db.query(`
        SELECT * FROM UserProgress WHERE UserID = ?
    `, [userID]);
    return result;
}

async function saveQuizProgress(userID, score) {
    const [existing] = await db.query(`SELECT * FROM UserProgress WHERE UserID = ?`, [userID]);

    if (existing) {
        await db.query(`
            UPDATE UserProgress 
            SET QuizScore = ?, LastUpdated = CURRENT_TIMESTAMP 
            WHERE UserID = ?
        `, [score, userID]);
    } else {
        await db.query(`
            INSERT INTO UserProgress (UserID, QuizScore) 
            VALUES (?, ?)
        `, [userID, score]);
    }
}

async function saveAssessmentProgress(userID, score) {
    const [existing] = await db.query(`SELECT * FROM UserProgress WHERE UserID = ?`, [userID]);

    if (existing) {
        await db.query(`
            UPDATE UserProgress 
            SET AssessmentScore = ?, LastUpdated = CURRENT_TIMESTAMP 
            WHERE UserID = ?
        `, [score, userID]);
    } else {
        await db.query(`
            INSERT INTO UserProgress (UserID, AssessmentScore) 
            VALUES (?, ?)
        `, [userID, score]);
    }
}

module.exports = {
    getUserProgress,
    saveQuizProgress,
    saveAssessmentProgress,
    getUserQuizProgress // Add this line
};
