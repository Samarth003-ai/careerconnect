const Profile = require("../models/profile");

//after user registers create profile for him

const createProfile = async (
    req,
    res
) => {
    try {

        const {
            bio,
            skills,
            education,
            experience,
        } = req.body;

        const profile =
            await Profile.create({
                user: req.user.userId,
                bio,
                skills,
                education,
                experience,
            });

        res.status(201).json({
            success: true,
            profile,
        });

    } catch (error) {

        res.status(500).json({
            message: error.message,
        });

    }
};

const getProfile = async (req, res) => {
    try {
        const profile = await Profile.findOne({ user: req.user.userId });

        if (!profile) {


            return res.status(404).json({
                message: "no profile",
            })
        }

        res.status(200).json({
            success: true,
            profile,
        })


    } catch (error) {
        res.status(500).json({
            message: error.message,
        })
    }
}

const updateProfile = async (
    req,
    res
) => {

    try {

        const profile =
            await Profile.findOneAndUpdate(     ///mongo finds and updates with the new req sent
                {
                    user:
                        req.user.userId,
                },

                req.body,   //new values to be updated

                {
                    new: true,      //it returns updated value, in other words tells mongo to return updated value
                }
            );

        if (!profile) {
            return res.status(404).json({
                success: false,
                message:
                    "Profile not found",
            });
        }

        res.status(200).json({
            success: true,
            profile,
        });

    } catch (error) {

        res.status(500).json({
            message: error.message,
        });

    }

};

module.exports = {
    createProfile,
    updateProfile,
    getProfile,
};