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
        <h1>Mediakit Bild Upload</h1>
        <label for="upload">Bild auswählen</label>
        <input id="upload" type="file" name="datei" accept="image/*" />
        <button type="submit">Hochladen</button>
      </form>
${pageFooter}
`;

module.exports = {
  homepage,
};
const successPage = filename => `${pageHeader}
      <p>Du hast "${filename}" erfolgreich hochgeladen.</p>
${pageFooter}
`;

module.exports = {
  homepage,
  successPage,
};
