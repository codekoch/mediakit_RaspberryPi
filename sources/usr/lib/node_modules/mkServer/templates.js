// server/templates.js 
const pageHeader = `<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width" />
    <style>
* {
  font-family: sans-serif;
  box-sizing: border-box;
}

img {
  max-width: 100%;
}

.wrapper > form {
  displ
    </style>
    <title>Mediakit</title>
  </head>
  <body>
    <div class="wrapper">
`;

const pageFooter = `    </div>
    <script src="/upload.js" />
  </body>
</html>
`;

const homepage = () => `${pageHeader}
      <form action="/upload" method="post" enctype="multipart/form-data">
        <h1>mediakit Upload Server</h1>
        <input id="upload" type="file" name="datei" />
        <button type="submit">Upload</button>
      </form>
${pageFooter}
`;

module.exports = {
  homepage,
};
const successPage = filename => `${pageHeader}
      <p>Du hast "${filename}" erfolgreich hochgeladen.</p>
      <a href="http://mk:3000">zur&uuml;ck</a>
${pageFooter}
`;

module.exports = {
  homepage,
  successPage,
};
