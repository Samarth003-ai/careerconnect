const express =
    require("express");

const router =
    express.Router();

const {
    getTemplates,
} = require(
    "../controllers/templateControllers"
);

router.get(
    "/",
    getTemplates
);

module.exports = router;