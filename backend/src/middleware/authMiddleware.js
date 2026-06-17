const jwt = require("jsonwebtoken");

const protect = async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization; //flutter sends this as ex- "Bearer(1st part & we ignore it) <token>(2nd part & we use it)"
        if (!authHeader || !authHeader.startsWith("Bearer ")) {
            return res.status(401).json({
                success: false,
                message: "Not authorized",
            });
        }
        const token = authHeader.split(" ")[1];
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded; // attach user info
        next();
    } catch (error) {
        return res.status(401).json({
            success: false,
            message: "Invalid token",
        });
    }
};

module.exports = protect;
