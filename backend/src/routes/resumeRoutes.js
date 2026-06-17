const express = require("express");

const router = express.Router();

const protect = require("../middleware/authMiddleware");

const { createResume, getResumes, getResumeById, updateResume, deleteResume, duplicateResume, selectTemplate } = require("../controllers/resumeController");
router.get("/", protect, getResumes);
router.post("/", protect, createResume);
router.get("/:id", protect, getResumeById);
router.put("/:id", protect, updateResume);
router.post("/:id/duplicate", protect, duplicateResume)
router.put("/:id/template", protect, selectTemplate);
router.delete("/:id", protect, deleteResume);

module.exports = router;