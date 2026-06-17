const axios = require("axios");

const searchJobs = async (query) => {   //front end sends query like GET /api/jobs/search?q=flutter developer  here flutter develepoer is query
    const response = await axios.get(
        "https://jsearch.p.rapidapi.com/search",    //sends request here
        {
            params: {                        //creates final url
                query,            //https://jsearch.p.rapidapi.com/search?query=flutter+developer&page=1&num_pages=1
                page: 1,          //example above
                num_pages: 1,
            },
            headers: {
                "X-RapidAPI-Key": process.env.JSEARCH_API_KEY,
                "X-RapidAPI-Host": "jsearch.p.rapidapi.com",
            }
        },
    );
    return response.data;
}

module.exports = { searchJobs };