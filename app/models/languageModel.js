const db = require("../services/db");

async function getAllLanguages() {
    return await db.query("SELECT LanguageID, LanguageName FROM LanguageList");
}

async function getLanguageName(languageID) {
    const [lang] = await db.query("SELECT LanguageName FROM LanguageList WHERE LanguageID = ?", [languageID]);
    return lang?.LanguageName || null;
}

module.exports = {
    getAllLanguages,
    getLanguageName
};
