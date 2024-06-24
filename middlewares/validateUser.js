const { body, validationResult } = require('express-validator');

const validateUser = [
  body('username').isString().notEmpty(),
  body('email').isEmail(),
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    next();
  }
];

module.exports = validateUser;
