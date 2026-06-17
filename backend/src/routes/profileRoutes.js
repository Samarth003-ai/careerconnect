const express = require("express");
const router = express.Router();

const protect = require("../middleware/authMiddleware");

const { createProfile, getProfile, updateProfile } = require("../controllers/profileController");

router.post("/", protect, createProfile);

router.get("/", protect, getProfile);
router.put("/", protect, updateProfile);

module.exports = router;