const Resume = require("../models/Resume");

const createResume = async (req, res) => {
    try {
        const resume = await Resume.create({
            user: req.user.userId,
            title: req.body.title,
            template: req.body.template
        })

        res.status(201).json({
            success: true,
            resume,
        })
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
        })
    }
}

const getResumes = async (req, res) => {     //to get all the resumes of user
    try {
        const resumes = await Resume.find({
            user: req.user.userId,
        });

        res.status(200).json({
            success: true,
            resumes,
        })
    }
    catch (error) {
        res.status(500).json({
            message: error.message,
        })
    }
}

//to get a single resume

const getResumeById = async (
    req,
    res
) => {

    try {

        const resume =
            await Resume.findOne({    //here to identify we use both bcoz same _id can be present in someone else's resume
                _id: req.params.id,

                user:
                    req.user.userId,
            });

        if (!resume) {
            return res.status(404).json({
                success: false,
                message:
                    "Resume not found",
            });
        }

        res.status(200).json({
            success: true,
            resume,
        });

    } catch (error) {

        res.status(500).json({
            message:
                error.message,
        });

    }

};

//update resume

const updateResume = async (
    req,
    res
) => {

    try {

        const resume =
            await Resume.findOneAndUpdate(

                {
                    _id:
                        req.params.id,

                    user:
                        req.user.userId,
                },

                req.body,

                {
                    new: true,
                }

            );

        if (!resume) {
            return res.status(404).json({
                success: false,
                message:
                    "Resume not found",
            });
        }

        res.status(200).json({
            success: true,
            resume,
        });

    } catch (error) {

        res.status(500).json({
            message:
                error.message,
        });

    }

};

//delete
const deleteResume = async (
    req,
    res
) => {

    try {

        const resume =
            await Resume.findOneAndDelete({

                _id:
                    req.params.id,

                user:
                    req.user.userId,
            });

        if (!resume) {
            return res.status(404).json({
                success: false,
                message:
                    "Resume not found",
            });
        }

        res.status(200).json({
            success: true,
            message:
                "Resume deleted",
        });

    } catch (error) {

        res.status(500).json({
            message:
                error.message,
        });

    }

};


//duplicate resume

const duplicateResume = async (req, res) => {
    try {
        const existingResume = await Resume.findOne({
            _id: req.params.id,
            user: req.user.userId
        });
        if (!existingResume) {
            return res.status(404).json({
                success: false,
                message:
                    "Resume not found"
            })
        }
        const resumeData = existingResume.toObject();

        delete resumeData._id;
        delete resumeData.updatedAt;
        delete resumeData.createdAt;

        const duplicatedResume = await Resume.create(resumeData);

        res.status(201).json({
            success: true,
            resume: duplicatedResume,
            message: "resume duplicated successfully",
        })


    }
    catch (error) {
        res.status(500).json({
            message: error.message,
        })
    }
}
//this us used to select template for a template as a user selcts a template , in resume model itt saves this 
const selectTemplate = async (req, res) => {
    try {
        const { template } = req.body;
        const resume = await Resume.findOneAndUpdate({
            _id: req.params.id,
            user: req.user.userId,
        }, {
            template: template,
        },
            {
                new: true,
            });

        if (!resume) {
            return res.status(404).json({
                success: false,
                message: "resume not found"
            });
        }

        res.status(200).json({
            success: true,
            resume,

        })
    } catch (error) {
        res.status(500).json({
            message: error.message,
        })
    }
}

module.exports = {
    createResume, getResumes, getResumeById, updateResume, deleteResume, duplicateResume, selectTemplate
}