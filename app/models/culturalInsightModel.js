const db = require("../services/db");

async function getCulturalInsightsByLanguageID(languageID) {
    const [languageRow] = await db.query("SELECT LanguageName FROM LanguageList WHERE LanguageID = ?", [languageID]);
    if (!languageRow) return null;

    const insightsResult = await db.query("SELECT FunFacts FROM CulturalInsights WHERE LanguageID = ?", [languageID]);
    const insights = insightsResult.map(row => row.FunFacts).flatMap(fact => fact.split("\n"));

    return {
        LanguageID: languageID,
        LanguageName: languageRow.LanguageName,
        insights
    };
}

module.exports = {
    getCulturalInsightsByLanguageID
};
