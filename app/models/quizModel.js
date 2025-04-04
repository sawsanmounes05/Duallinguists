const db = require("../services/db");

async function getQuizCategories() {
    return await db.query(`
        SELECT CategoryID, CategoryName, Description 
        FROM QuizCategories 
        WHERE CategoryID IN (1, 2)
    `);
}

async function getQuizQuestionsWithAnswers(categoryID, languageID) {
    const rows = await db.query(`
        SELECT q.QuestionID, q.QuestionText, a.AnswerID, a.AnswerText, a.IsCorrect
        FROM QuizQuestions q
        LEFT JOIN QuizAnswers a ON q.QuestionID = a.QuestionID
        WHERE q.LanguageID = ? AND q.CategoryID = ?
        ORDER BY q.QuestionID, a.AnswerID
    `, [languageID, categoryID]);

    const formatted = {};
    for (const row of rows) {
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
    }

    return Object.values(formatted);
}

async function getCorrectAnswer(questionID) {
    const [answer] = await db.query(`
        SELECT AnswerID, AnswerText, IsCorrect 
        FROM QuizAnswers 
        WHERE QuestionID = ? AND IsCorrect = 1
    `, [questionID]);
    return answer;
}

async function getAnswerText(answerID) {
    const [result] = await db.query("SELECT AnswerText FROM QuizAnswers WHERE AnswerID = ?", [answerID]);
    return result?.AnswerText || "Unknown";
}

module.exports = {
    getQuizCategories,
    getQuizQuestionsWithAnswers,
    getCorrectAnswer,
    getAnswerText
};
