const db = require("../services/db");

async function getMessagesByGroupChatID(groupChatID) {
    const [rows] = await db.query(`
      SELECT m.MessageID, m.MessageText, m.SentAt, u.Name AS Sender
      FROM GroupChatMessages m
      JOIN Users u ON m.UserID = u.UserID
      WHERE m.GroupChatID = ?
      ORDER BY m.SentAt ASC
    `, [groupChatID]);
  
    return Array.isArray(rows) ? rows : [];
  }



  async function postMessage(groupChatID, userID, messageText) {
    await db.query(`
      INSERT INTO GroupChatMessages (GroupChatID, UserID, MessageText)
      VALUES (?, ?, ?)
    `, [groupChatID, userID, messageText]);
  }
  
async function getOrCreateGroupChat(languageID) {
    const [existing] = await db.query(`
        SELECT * FROM GroupChats WHERE LanguageID = ? LIMIT 1
    `, [languageID]);

    if (existing) return existing;

    const result = await db.query(`
        INSERT INTO GroupChats (LanguageID) VALUES (?)
    `, [languageID]);

    return {
        GroupChatID: result.insertId,
        LanguageID: languageID
    };
}

module.exports = {
    getMessagesByGroupChatID,
    postMessage,
    getOrCreateGroupChat
};
