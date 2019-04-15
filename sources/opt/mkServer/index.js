// index.js
const express = require('../node_modules/express');
const app = express();
const { homepage } = require('./templates.js');
const handleUpload = require('./handleUpload.js');
const fs = require('fs');
const { port, uploadDir } = require('./config.js');

//var path = require('path');
//app.use(express.static(path.join(__dirname, 'static')));
//app.use("/static", express.static(__dirname + '/static'));
try {
  fs.mkdirSync(uploadDir);
} catch (e) {
  // Wenn das Verzeichnis schon existiert, machen wir einfach weiter.
  // Bei jedem anderen Fehler lassen wir crashen.
  if (e.code !== 'EEXIST') throw e;
}
app.listen(port, (err) => {
  if (err) throw err;
  console.log(`
Listening on port ${port}
Using directory "${uploadDir}" for uploads
  `);
});

app.post('/upload', handleUpload);

app.get('/', (req, res) => {
  res.send(homepage());
});

// Für CSS und ggfs. JS
//app.use(express.static(path.join(__dirname, 'static')));
//app.use('/static', express.static(path.join(__dirname, 'public')))
//app.get('/', (req, res) => {
//  res.send('Hello\n');
//});

//app.listen(3000, (err) => {
//  if (err) throw err;
//  console.log('Listening on port 3000');
//});
