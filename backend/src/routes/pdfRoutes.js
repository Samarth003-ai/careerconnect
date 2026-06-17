const express =
    require("express");

const router =
    express.Router();

const protect =
    require("../middleware/authMiddleware");

const {
    generatePDF,
} = require(
    "../controllers/pdfController"
);

router.get(
    "/:id",
    protect,
    generatePDF
);

module.exports =
    router;