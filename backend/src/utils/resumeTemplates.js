
//we could have stored these in mongo also but since they reamin constant throughout it doesn require
const resumeTemplates = [
    {
        id: "ats_friendly",

        name: "ATS Friendly",

        description:
            "Simple ATS compatible resume",

        thumbnail:
            "ats_preview.png",
    },

    {
        id: "modern_blue",

        name: "Modern Blue",

        description:
            "Professional corporate template",

        thumbnail:
            "modern_blue.png",
    },

    {
        id: "creative_sidebar",

        name: "Creative Sidebar",

        description:
            "Modern sidebar design",

        thumbnail:
            "sidebar.png",
    },

    {
        id: "student_resume",

        name: "Student Resume",

        description:
            "Perfect for freshers",

        thumbnail:
            "student.png",
    },
];

module.exports =
    resumeTemplates;