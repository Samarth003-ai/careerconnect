const modernBlueTemplate =
    (resume) => {

        return `
  <html>

  <body>

    <h1>
      ${resume.personalInfo.name}
    </h1>

    <p>
      ${resume.summary}
    </p>

    <h2>Skills</h2>

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

module.exports =
    modernBlueTemplate;