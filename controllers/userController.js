const User = require('../models/userModel');

exports.getAllUsers = (req, res) => {
  User.getAll((err, results) => {
    if (err) {
      return res.status(500).send('Error fetching users');
    }
    res.json(results);
  });
};

exports.createUser = (req, res) => {
  const { username, email } = req.body;
  User.create({ username, email }, (err, result) => {
    if (err) {
      return res.status(400).send('Error creating user');
    }
    res.status(201).send('User created successfully');
  });
};

// Add update and delete functions similarly
