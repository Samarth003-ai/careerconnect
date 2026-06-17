const jwt = require("jsonwebtoken");

const protect = async (req, res, next) => {
    try {

        const authHeader = req.headers.authorization;  //flutter sends this as ex- "Bearer(1st part & we ignore it) <token>(2nd part & we use it)"

        if (
            !authHeader ||
            !authHeader.startsWith("Bearer ")   //check if token is present and starts with Bearer
        ) {
            return res.status(401).json({
                success: false,
                message: "Not authorized",
            });
        }

        const token = authHeader.split(" ")[1];  //split the string at space and takes 2nd part as token

        const decoded = jwt.verify(   //verifies the token
            token,
            process.env.JWT_SECRET
        );

        req.user = decoded;  //attaches user info to request for access in next middlewares

        next();

    } catch (error) {

        return res.status(401).json({
            success: false,
            message: "Invalid token",
        });

    }
};

module.exports = protect;