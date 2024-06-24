const db = require('../config/db');

exports.getAll = (callback) => {
  db.query('SELECT * FROM users', callback);
};

exports.create = (user, callback) => {
  db.query('INSERT INTO users (username, email) VALUES (?, ?)', [user.username, user.email], callback);
};

// Add update and delete functions similarly
