// progressModel.js
  // Assuming you have a db.js file to handle database queries
  const db = require("../services/db");
// Function to get user's quiz progress by language
async function getUserQuizProgress(userID, languageID) {
    try {
        const query = `
            SELECT ActivityID, Score, TakenAt, LanguageID
            FROM UserProgress
            WHERE UserID = ? AND ActivityType = 'Quiz' AND LanguageID = ?
            ORDER BY TakenAt DESC;
        `;
        const [quizProgress] = await db.query(query, [userID, languageID]);
        return quizProgress;
    } catch (error) {
        console.error("Error fetching quiz progress:", error);
        throw error;
    }
}


// Function to get user's assessment progress by language
async function getUserAssessmentProgress(userID, languageID) {
    try {
        const query = `
            SELECT ActivityID, Score, TakenAt, LanguageID
            FROM UserProgress
            WHERE UserID = ? AND ActivityType = 'Assessment' AND LanguageID = ?
            ORDER BY TakenAt DESC;
        `;
        const [assessmentProgress] = await db.query(query, [userID, languageID]);
        return assessmentProgress;
    } catch (error) {
        console.error("Error fetching assessment progress:", error);
        throw error;
    }
}


module.exports = {
    getUserQuizProgress,
    getUserAssessmentProgress
};
