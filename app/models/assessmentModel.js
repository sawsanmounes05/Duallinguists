const db = require("../services/db");

// Get Assessment Categories
async function getAssessmentCategories() {
    return await db.query(`
        SELECT CategoryID, CategoryName, Description 
        FROM QuizCategories 
        WHERE CategoryID IN (1, 2)
    `);
}

async function getAssessmentQuestionsWithAnswers(type, languageID) {
    const rows = await db.query(`
        SELECT q.QuestionID, q.QuestionText, a.AnswerID, a.AnswerText, a.IsCorrect
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
                answers: []
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
    return correct;
}

// Get Answer Text by AnswerID
async function getAssessmentAnswerText(answerID) {
    const [result] = await db.query(`
        SELECT AnswerText FROM AssessmentAnswers WHERE AnswerID = ?
    `, [answerID]);
    return result?.AnswerText || "Unknown";
}

module.exports = {
    getAssessmentCategories,
    getAssessmentQuestionsWithAnswers,
    getCorrectAssessmentAnswer,
    getAssessmentAnswerText
};
