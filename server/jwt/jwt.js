// // jwt.js
// const jwt = require('jsonwebtoken');
// const secretKey = 'my-secret-key'; // Ganti dengan kunci yang kuat

// // jwt.js

// const generateToken = (user) => {
//   const token = jwt.sign(
//     { userId: user.id, username: user.username, role: user.role }, // Misalnya, user memiliki properti 'role'
//     secretKey,
//     { expiresIn: '1h' }
//   );
//   console.log('Generated token:', token);
//   return token;
// };

// const verifyToken = (req, res, next) => {
//   const authHeader = req.headers.authorization;

//   if (!authHeader || !authHeader.authorization('Bearer ')) {
//     return res.status(401).json({ err: 'Unauthorized - Bearer Token not provided' });
//   }

//   const token = authHeader.split(' ')[1];

//   if (!token) {
//     return res.status(401).json({ err: 'Unauthorized - Token not provided' });
//   }

//   jwt.verify(token, secretKey, (err, decoded) => {
//     if (err) {
//       return res.status(401).json({ err: 'Unauthorized - Invalid token' });
//     }

//     req.user = decoded;
//     next();
//   });
// };

// module.exports = {
//   generateToken,
//   verifyToken // Rename verifyToken to match the exported name
// };
