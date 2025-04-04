const db = require("../services/db");

async function getAllSelectionOptions() {
    return await db.query("SELECT SelectionID, SelectionName, Description FROM SelectionOptions");
}

module.exports = {
    getAllSelectionOptions
};
