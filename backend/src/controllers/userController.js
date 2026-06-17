//if user checks his profile

const User = require("../models/User");

const getProfile = async (
    req,
    res
) => {

    try {

        const user =
            await User.findById(
                req.user.userId   //from middleware we got user id
            ).select("-password");   //select password means we need everything except password

        res.status(200).json({
            success: true,
            user,
        });

    } catch (error) {

        res.status(500).json({
            message: error.message,
        });

    }

};

module.exports = {
    getProfile,
};