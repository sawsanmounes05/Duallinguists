// forumModel.js
const db = require("../services/db");

async function getMessagesByGroupChatID(groupChatID) {
  const [rows] = await db.query(`
    SELECT m.MessageText, m.SentAt, u.Name AS Sender
    FROM GroupChatMessages m
    JOIN Users u ON m.UserID = u.UserID
    WHERE m.GroupChatID = ?
    ORDER BY m.SentAt ASC
  `, [groupChatID]);

  return rows;
}



async function postMessage(groupChatID, userID, messageText) {
  if (!groupChatID || !userID || !messageText) {
    throw new Error("Missing required fields to post message");
  }

  const sql = `
    INSERT INTO GroupChatMessages (GroupChatID, UserID, MessageText)
    VALUES (?, ?, ?)
  `;
  await db.query(sql, [groupChatID, userID, messageText]);
}


function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function getOrCreateGroupChat(languageID) {
  try {
    const selectResult = await db.query(
      `SELECT * FROM GroupChats WHERE LanguageID = ? ORDER BY GroupChatID ASC`,
      [languageID]
    );
    let existingRows = Array.isArray(selectResult) ? selectResult[0] : (selectResult.rows || []);
    if (Array.isArray(existingRows) && existingRows.length > 0) {
      return existingRows[0];
    }

    const insertResult = await db.query(
      `INSERT INTO GroupChats (LanguageID) VALUES (?)
       ON DUPLICATE KEY UPDATE GroupChatID = LAST_INSERT_ID(GroupChatID)`,
      [languageID]
    );
    let newID = Array.isArray(insertResult) ? insertResult[0].insertId : insertResult.insertId;

    await sleep(500);
    const newSelectResult = await db.query(
      `SELECT * FROM GroupChats WHERE GroupChatID = ?`,
      [newID]
    );
    let newRows = Array.isArray(newSelectResult) ? newSelectResult[0] : (newSelectResult.rows || []);
    return newRows && newRows.length > 0 ? newRows[0] : { GroupChatID: newID, LanguageID: languageID };
  } catch (err) {
    console.error("Error in getOrCreateGroupChat:", err);
    throw err;
  }
}

async function saveUserGroupChat(userID, groupChatID) {
  if (!userID || !groupChatID) {
    console.error("❌ saveUserGroupChat: Missing values", { userID, groupChatID });
    throw new Error("Missing userID or groupChatID");
  }
  try {
    await db.query(
      `INSERT IGNORE INTO GroupChatMembers (UserID, GroupChatID)
       VALUES (?, ?)`,
      [userID, groupChatID]
    );
  } catch (error) {
    console.error("Error saving group chat membership:", error);
    throw error;
  }
}

async function getUserGroupChats(userID) {
  const result = await db.query(
    `SELECT g.GroupChatID, g.LanguageID, l.LanguageName
     FROM GroupChatMembers m
     JOIN GroupChats g ON m.GroupChatID = g.GroupChatID
     JOIN LanguageList l ON g.LanguageID = l.LanguageID
     WHERE m.UserID = ?`,
    [userID]
  );
  const rows = Array.isArray(result) ? result[0] : result;
  return Array.isArray(rows) ? rows : [];
}
async function saveMessage(groupChatID, userID, messageText, sentAt) {
  await db.query(
    `INSERT INTO GroupChatMessages (GroupChatID, UserID, MessageText, SentAt) 
    VALUES (?, ?, ?, ?)`,
    [groupChatID, userID, messageText, sentAt]
  );
}





module.exports = {
  getMessagesByGroupChatID,
  postMessage,
  getOrCreateGroupChat,
  saveUserGroupChat,
  getUserGroupChats,
  saveMessage,
};