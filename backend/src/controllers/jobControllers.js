const { searchJobs } =
    require("../services/jobService");

const getJobs = async (
    req,
    res
) => {

    try {

        const query =
            req.query.q;       //obtain query from request

        if (!query) {
            return res.status(400).json({
                success: false,
                message:
                    "Search query required",
            });
        }

        const jobs =                    //api call of jsearch
            await searchJobs(query);

        res.status(200).json({
            success: true,
            jobs,
        });

    } catch (error) {

        res.status(500).json({
            success: false,
            message:
                error.message,
        });

    }

};

module.exports = {
    getJobs,
};