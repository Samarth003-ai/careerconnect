const mongoose = require("mongoose");

const resumeSchema =
    new mongoose.Schema(
        {
            user: {
                type:
                    mongoose.Schema.Types.ObjectId,


                ref: "User",

                required: true,
            },

            title: {
                type: String,
                required: true,
            },

            template: {
                type: String,

                default:
                    "ats_friendly",
            },

            personalInfo: {
                name: String,
                email: String,
                phone: String,
                address: String,
                linkedin: String,
                github: String,
            },
            summary: {
                type: String,
                default: "",
            },
            education: [
                {
                    college: String,
                    degree: String,
                    cgpa: String,
                    duration: String,
                }
            ],
            projects: [
                {
                    title: String,
                    description: String,
                    techStack: [String],
                }
            ],



            skills: [
                {
                    type: String,
                },
            ],




            experience: [
                {
                    company: String,
                    role: String,
                    duration: String,
                    description: String,
                },
            ],
        },

        {
            timestamps: true,
        }
    );

module.exports =
    mongoose.model(
        "Resume",
        resumeSchema
    );