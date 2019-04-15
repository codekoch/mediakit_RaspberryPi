// server/config.js
const path = require('path');

//const uploadDir = path.join(process.cwd(), 'IN');
const uploadDir = '/home/mk/Pictures';
module.exports = {
  port: process.env.NODE_ENV === 'production' ? 80 : 3000,
  uploadDir,
  uploadOptions: {
    uploadDir,
  },
};
