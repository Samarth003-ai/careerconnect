const express =
    require("express");

const router =
    express.Router();

const protect =
    require("../middleware/authMiddleware");

const {
    getJobs,
} = require(
    "../controllers/jobControllers"
);

router.get(
    "/search",
    protect,
    getJobs
);

module.exports =
    router;