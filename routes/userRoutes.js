const express = require('express');
const userController = require('../controllers/userController');
const validateUser = require('../middlewares/validateUser');
const router = express.Router();

// Add "Hello World" route
router.get('/hello', (req, res) => {
    res.send('Hello World');
  });

router.get('/users', userController.getAllUsers);
router.post('/users', validateUser, userController.createUser);
// router.put('/users/:id', validateUser, userController.updateUser);
// router.delete('/users/:id', userController.deleteUser);
// Add update and delete routes similarly

module.exports = router;
