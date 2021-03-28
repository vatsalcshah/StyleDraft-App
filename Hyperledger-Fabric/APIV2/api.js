'use strict';

// Classes for Node Express
const express = require('express');
const app = express();
const cors = require('cors');
const SUCCESS = 0;
const TRANSACTION_ERROR = 401;
const USER_NOT_ENROLLED = 402;
const jwt = require('jsonwebtoken');
//  connectionOptions
const utils = require('./ibputils.js');
var contract;
var username;




utils.connectGatewayFromConfig().then((gateway_contract) => {

    console.log('Connected to Network.');
    contract = gateway_contract;

    //  Setup events and monitor for events from HLFabric
   // utils.events();

}).catch((e) => {
    console.log('Connection exception.');
    console.log(e);
    console.log(e.stack);
    process.exit(-1);
});

app.use(express.json());
app.use(function (req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    res.header("Access-Control-Allow-Methods", "PUT, POST, GET, DELETE, OPTIONS");
    next();
});

app.use(cors());

function verifyToken(req, res, next) {
    // Get auth header value
    console.log(req.headers['authorization']);
    const bearerHeader = req.headers['authorization'];
    // Check if bearer is undefined
    if(typeof bearerHeader !== 'undefined') {
      // Split at the space
      const bearer = bearerHeader.split(' ');
      // Get token from array
      const bearerToken = bearer[1];
      // Set the token
      
      req.token = bearerToken;
      // Next middleware
      console.log(req.token);
      next();
    } else {
      // Forbidden
      res.sendStatus(403);
    }
  
  }

  app.post('/api/login', (req, res) => {
    // Mock user
    console.log(req.body);
    let password = req.body.password;
    console.log(password);
    if(password!="DuBaraMatPuchna"){
        res.sendStatus(403);
    }else{
    const user = {
      id: 1, 
      username: 'admin',
      email: 'admin@devfolio.com',
      pass:"DuBaraMatPuchna"
    }
  
    jwt.sign({user}, 'Hackbash', { expiresIn: '60s' }, (err, token) => {
      res.json({
        token
      });
    });
}
  });
app.post('/api/CreateAsset', verifyToken, (req, res) => {
    jwt.verify(req.token, 'Hackbash', (err) => {
        if(err) {
          res.sendStatus(403);
        }else{
    
    console.log("\n----------------------------------------");
    let ItemName = req.body.ItemName;
    let price = req.body.price;
    console.log("\n---------------------------------------------------");
    
    utils.CreateMyAsset(ItemName,price)
    .then(result =>{
        res.json({'errorCode':result})
    }, (error) => {
        //  handle error if transaction failed
        error.errorCode = 404;
        console.log('Error thrown from tx promise: ', error);
        res.json(error);
    })
    //console.log("Username:"+username);
}});
    
});

app.get('/api/GetItemInfo',(req,res) =>{
let ItemName = req.query.ItemName;
console.log("=================");
console.log(ItemName);
utils.ReadMyAsset(ItemName)
    .then(result =>{
        res.json(result)
    }, (error) => {
        //  handle error if transaction failed
        error.errorCode = 404;
        console.log('Error thrown from tx promise: ', error);
        res.json(error);
    })


});

app.post('/api/AddComponentInfo',verifyToken, (req,res) =>{
    jwt.verify(req.token, 'Hackbash', (err) => {
        if(err) {
          res.sendStatus(403);
        }else{
let ItemName  = req.body.ItemName;
let component_name = req.body.component_name;
let Dict = req.body.dict;
console.log("=================");
console.log(Dict);
utils.Buy(ItemName,component_name,JSON.stringify(Dict))
    .then(result =>{
        res.json({'errorCode':result})
    }, (error) => {
        //  handle error if transaction failed
        error.errorCode = 404;
        console.log('Error thrown from tx promise: ', error);
        res.json(error);
    })
}});
});

app.get('/api/block',(req,res) =>{
        let bnum = req.query.num;
        console.log("=================");
        console.log(bnum);
        utils.BlockInfo(bnum)
            .then(result =>{
                res.json(result)
            }, (error) => {
                //  handle error if transaction failed
                error.errorCode = 404;
                console.log('Error thrown from tx promise: ', error);
                res.json(error);
            })
        
        });
app.get('/api/Getblockbytx',(req,res) =>{
            let txid = req.query.txid;
            console.log("=================");
            console.log(txid);
            utils.getTransactionByID(txid)
                .then(result =>{
                    res.json(result)
                }, (error) => {
                    //  handle error if transaction failed
                    error.errorCode = 404;
                    console.log('Error thrown from tx promise: ', error);
                    res.json(error);
                })
            
            });
const port = process.env.PORT || 3000;
app.listen(port, (error) => {
    if (error) {
        return console.log('Error: ' + err);
    }
    console.log(`Server listening on ${port}`)
});

