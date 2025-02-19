const express = require("express");
const connection = require("../db");

const app = express.Router();

app.get("/", (request, response) => {
    const query = "select * from city";

    connection.query(query, (error, result) => {
        response.setHeader("content-type", "application/json");
        if(error) {
            console.log(error);
            response.status(500).json({status : "error", data : "could not get cities"});
        }
        else {
            response.json({status : "success", data : result});
        }
    });
});

app.get("/:cityname", (request, response) => {
    const { cityname } = request.params;
    const query = "select * from city where name = ?";

    connection.query(query, [cityname], (error, result) => {
        response.setHeader("content-type", "application/json");
        if(error) {
            console.log(error);
            response.status(500).json({status : "error", data : "could not get cities"});
        }
        else {
            response.json({status : "success", data : result[0]});
        }
    });
});

module.exports = app;