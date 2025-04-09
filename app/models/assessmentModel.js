const db = require("../services/db");

// Get Assessment Categories
async function getAssessmentCategories() {
    return await db.query(`
        SELECT CategoryID, CategoryName, Description 
        FROM QuizCategories 
        WHERE CategoryID IN (1, 2)
    `);
}

// Get Assessment Questions with Answers
async function getAssessmentQuestionsWithAnswers(type, languageID) {
    const rows = await db.query(`
        SELECT q.QuestionID, q.QuestionText, a.AnswerID, a.AnswerText, a.IsCorrect, q.AssessmentType
        FROM AssessmentQuestions q
        LEFT JOIN AssessmentAnswers a ON q.QuestionID = a.QuestionID
        WHERE q.LanguageID = ? AND q.AssessmentType = ?
        ORDER BY q.QuestionID, a.AnswerID
    `, [languageID, type]);

    const formatted = {};
    rows.forEach(row => {
        if (!formatted[row.QuestionID]) {
            formatted[row.QuestionID] = {
                QuestionID: row.QuestionID,
                QuestionText: row.QuestionText,
                answers: [],
                assessmentType: row.AssessmentType // Add assessmentType here
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

// Get Correct Answer for an Assessment Question
async function getCorrectAssessmentAnswer(questionID) {
    const [correct] = await db.query(`
        SELECT AnswerID, AnswerText 
        FROM AssessmentAnswers 
        WHERE QuestionID = ? AND IsCorrect = 1
    `, [questionID]);
    return correct || { AnswerText: "No correct answer available" };  // Default if no correct answer is found
}

// Get Answer Text by AnswerID
async function getAssessmentAnswerText(answerID) {
    const [result] = await db.query(`
        SELECT AnswerText FROM AssessmentAnswers WHERE AnswerID = ?
    `, [answerID]);
    return result?.AnswerText || "Unknown";
}

// Get All User Answers for an Assessment Attempt
async function getUserAnswersForAssessment(attemptID) {
    const rows = await db.query(`
        SELECT q.QuestionID, ua.AnswerID
        FROM UserAnswers ua
        LEFT JOIN AssessmentQuestions q ON ua.QuestionID = q.QuestionID
        WHERE ua.AttemptID = ?
    `, [attemptID]);

    const formatted = {};
    rows.forEach(row => {
        if (!formatted[row.QuestionID]) {
            formatted[row.QuestionID] = [];
        }
        formatted[row.QuestionID].push(row.AnswerID);
    });

    return formatted;
}
// Make sure to export it properly


// Save Assessment Results
async function saveAssessmentProgress(userID, score, languageID) {
    await db.query(`
        INSERT INTO Assessments (UserID, Score, DateTaken, LanguageID)
        VALUES (?, ?, NOW(), ?)
    `, [userID, score, languageID]);
}

module.exports = {
    getAssessmentCategories,
    getAssessmentQuestionsWithAnswers,
    getCorrectAssessmentAnswer,
    getAssessmentAnswerText,
    getUserAnswersForAssessment,
    saveAssessmentProgress,
   
};
