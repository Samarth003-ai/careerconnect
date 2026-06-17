const mongoose = require("mongoose");

const connectDB = async () => {
  try {
    console.log(process.env.MONGODB_URI);

    const conn = await mongoose.connect(
      process.env.MONGODB_URI || process.env.LOCAL_MONGODB
    );

    console.log(
      `MongoDB Connected: ${conn.connection.host}`
    );
  } catch (error) {
    console.error(
      "Database Connection Failed:",
      error.message
    );

    process.exit(1);
  }
};

module.exports = connectDB;
