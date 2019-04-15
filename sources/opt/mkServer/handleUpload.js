// server/handleUpload.js
const Form = require('multiparty').Form;
const { uploadOptions } = require('./config.js');
const { successPage } = require('./templates.js');
var fs =require('/opt/node_modules/fs-extra');
var exec = require('child_process').execSync;
var cmd = 'zenity --info --text="File received!" --timeout=1 2> /dev/null  &';

var options = {
  encoding: 'utf8'
};


module.exports = function handleUpload(req, res) {
  const form = new Form(uploadOptions);
  form.on('file', (name, file) => {
    req.filename = file.originalFilename;
  });
  form.on('error', () => {
  });
  form.on('close', () => {
  res.send(successPage(req.filename));
  console.log(exec(cmd, options));      
 });
  
  form.parse(req, function(err, fields, files) {
  var ip = req.connection.remoteAddress.split('.').pop();
//  console.log(JSON.stringify(req.connection));
 
//  console.log(JSON.stringify(files));
//  console.log(files[Object.keys(files)[0]][0].originalFilename);
//   console.log(files[Object.keys(files)[0]][0].path);
//   console.log(form.uploadDir);
//   console.log(JSON.stringify(form));
   var newFileName = (files[Object.keys(files)[0]][0].originalFilename).split('.');
   //var newFileName[0] = newFileName[0]+
   fs.rename(files[Object.keys(files)[0]][0].path,form.uploadDir+"/"+newFileName[0]+"_IP"+ip+"."+newFileName[1], function(err) {
         if (err)
            throw err;
          console.log('renamed complete');});
  
        
});
};
