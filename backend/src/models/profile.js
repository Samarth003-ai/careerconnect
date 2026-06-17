//new model to stire user exprerince

const mongoose = require("mongoose");

const profileSchema = new mongoose.Schema(
    {
        user: {
            type: mongoose.Schema.Types.ObjectId,   // builds relation bw profile and user data
            ref: "User",
            required: true,
        },

        bio: {
            type: String,
            default: "",
        },

        skills: [
            {
                type: String,
            },
        ],

        education: [
            {
                college: String,
                degree: String,
                cgpa: String,
                duration: String,
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
        "Profile",
        profileSchema
    );