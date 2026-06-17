const templates =
    require(
        "../utils/resumeTemplates"
    );

const getTemplates =
    async (req, res) => {

        try {

            res.status(200).json({
                success: true,
                templates,
            });

        } catch (error) {

            res.status(500).json({
                message:
                    error.message,
            });

        }

    };

module.exports = {
    getTemplates,
};