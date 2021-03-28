const utils = require('./try.js');
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
