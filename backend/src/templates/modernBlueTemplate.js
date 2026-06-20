const modernBlueTemplate = (resume) => {

  return `
    <html>

    <head>

      <style>

        body{
          font-family: Arial, sans-serif;
          padding: 30px;
          line-height: 1.5;
        }

        h1{
          color:#1565c0;
          margin-bottom:0;
        }

        h2{
          color:#1565c0;
          border-bottom:1px solid #ddd;
          padding-bottom:5px;
          margin-top:25px;
        }

        .contact{
          margin-bottom:20px;
        }

        ul{
          padding-left:20px;
        }

      </style>

    </head>

    <body>

      <h1>
        ${resume.personalInfo.name || ""}
      </h1>

      <div class="contact">

        <div>
          ${resume.personalInfo.email || ""}
        </div>

        <div>
          ${resume.personalInfo.phone || ""}
        </div>

        <div>
          ${resume.personalInfo.linkedin || ""}
        </div>

        <div>
          ${resume.personalInfo.github || ""}
        </div>

      </div>

      <h2>
        Professional Summary
      </h2>

      <p>
        ${resume.summary || ""}
      </p>

      <h2>
        Skills
      </h2>

      <ul>

        ${resume.skills
      .map(
        skill =>
          `<li>${skill}</li>`
      )
      .join("")}

      </ul>

    </body>

    </html>
    `;
};

module.exports = modernBlueTemplate;