const db = require("../services/db");

async function getQuizCategories() {
    return await db.query(`
        SELECT CategoryID, CategoryName, Description 
        FROM QuizCategories 
        WHERE CategoryID IN (1, 2)
    `);
}
async function getAnswerDetails(answerID) {
    try {
        // Get the selected answer's details
        const [selected] = await db.query(
            'SELECT AnswerText, IsCorrect, QuestionID FROM AssessmentAnswers WHERE AnswerID = ?',
            [answerID]
        );

        if (!selected) {
            throw new Error(`AnswerID ${answerID} not found`);
        }

        // Get the correct answer for this question
        const [correct] = await db.query(
            'SELECT AnswerText FROM AssessmentAnswers WHERE QuestionID = ? AND IsCorrect = 1',
            [selected.QuestionID]
        );

        return {
            isCorrect: selected.IsCorrect === 1,
            answerText: selected.AnswerText,
            correctAnswerText: correct ? correct.AnswerText : 'N/A'
        };
    } catch (error) {
        console.error('Error fetching answer details:', error);
        return {
            isCorrect: false,
            answerText: 'N/A',
            correctAnswerText: 'N/A'
        };
    }
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
    const [result] = await db.query("SELECT AnswerText FROM AssessmentAnswers WHERE AnswerID = ?", [answerID]);
    return result?.AnswerText || "N/A";
}


module.exports = {
    getQuizCategories,
    getQuizQuestionsWithAnswers,
    getCorrectAnswer,
    getAnswerText,
    getAnswerDetails,
};
