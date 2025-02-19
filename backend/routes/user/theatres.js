const express = require("express");
const connection = require("../db");

const app = express.Router();

app.get("/:city_id", (request, response) => {
    const { city_id } = request.params;
    const query = "select * from theatre where city_id = ?";

    connection.query(query, [city_id], (error, result) => {
        response.setHeader("content-type", "application/json");
        if(error) {
            console.log(error);
            response.status(500).json({status : "error", data : "could not get cities"});
        }
        else {
            response.json({status : "success", data : result});
        }
    })
});

module.exports = app;