'use strict';

// Bring key classes into scope, most importantly Fabric SDK network class
const fs = require('fs');
const path = require('path');
const { Wallets ,Gateway, BlockListener,ListenerOptions} = require('fabric-network');
const { json } = require('body-parser');
const util = require('util');
const { BlockDecoder } = require('fabric-common');

var configdata;
var network;
var orgMSPID;

var contract = null;

const utils = {};


utils.connectGatewayFromConfig = async () => {


console.log("*********************** connectGatewayFromConfig function: ********************* ");
    const connectionProfileJson = (await fs.readFileSync('gatewayv2/DevfolioVOrg1GatewayConnection.json')).toString();
    const connectionProfile = JSON.parse(connectionProfileJson);
    const walletPath = path.join(process.cwd(), '/walletsv2/Org1');
    const wallet =  await Wallets.newFileSystemWallet(walletPath);
    //const gateway = new Gateway();
    //await gateway.connect(connectionProfile, {identity: 'Org1 admin',wallet});

     try {
    let peerIdentity='Org1 admin'
     
    let response;
    // Check to see if we've already enrolled the user.
    const userExists = await wallet.get(peerIdentity);
    if (!userExists) {
      console.log('An identity for the user ' + peerIdentity + ' does not exist in the wallet');
      response.error = 'An identity for the user ' + peerIdentity + ' does not exist in the wallet. Register ' + peerIdentity + ' first';
      return response;
    }
    //connect to Fabric Network, but starting a new gateway
    const gateway = new Gateway();
    // Set up the MSP Id
     orgMSPID = connectionProfile.client.organization;
     console.log('MSP ID: ' + orgMSPID);
     
    await gateway.connect(connectionProfile, {identity: peerIdentity,wallet,discovery:  { "enabled": true, "asLocalhost": true }});
    //use our config file, our peerIdentity, and our discovery options to connect to Fabric network.
    //await gateway.connect(ccp_org, { wallet, identity: peerIdentity, discovery:  { "enabled": true, "asLocalhost": true } });
    //connect to our channel that has been created on IBM yash/Internship_projects Platform
    const network = await gateway.getNetwork('mychannel');
    //connect to our insurance contract that has been installed / instantiated on IBM yash/Internship_projects Platform
     contract = await network.getContract('Devfolio'); 
  } catch (error) {
    console.error(`Failed to submit transaction: ${error}`);
  }finally{
return contract;
}

}





utils.CreateMyAsset = async function(ItemName,price) {
     
  const connectionProfileJson = (await fs.readFileSync('gatewayv2/DevfolioVOrg1GatewayConnection.json')).toString();
    const connectionProfile = JSON.parse(connectionProfileJson);
    const walletPath = path.join(process.cwd(), '/walletsv2/Org1');
    const wallet =  await Wallets.newFileSystemWallet(walletPath);
        let id = 'Org1 admin';
      try{ 

        const userGateway = new Gateway();
        await userGateway.connect(connectionProfile, { wallet, identity: id, discovery:{ "enabled": true, "asLocalhost": true }});

        network = await userGateway.getNetwork('mychannel');

        // Get addressability to the smart contract as specified in config
        var res = {}
        contract = await network.getContract('Devfolio');
        const transaction = contract.createTransaction('createContract');
        res['txId']=transaction.getTransactionId();
            
        await transaction.submit( ItemName,price);
        console.log('Transaction has been submitted');
        await network.addBlockListener(async (event) => {
          // Handle block event
          console.log(event.blockNumber.getLowBits());
           res['blockNumber']=event.blockNumber.getLowBits();
          // Listener may remove itself if desired
      });
       
        res['status']="Transaction completed";
        // Disconnect from the gateway.
        await userGateway.disconnect();
        return res;

    } catch (error) {
        console.error(`Failed to submit transaction: ${error}`);
        res.error = error.message;
        return res; 
    }
}

utils.Buy = async function(ItemName,Component_name ,dict) {
     
     const connectionProfileJson = (await fs.readFileSync('gatewayv2/DevfolioVOrg1GatewayConnection.json')).toString();
    const connectionProfile = JSON.parse(connectionProfileJson);
    const walletPath = path.join(process.cwd(), '/walletsv2/Org1');
    const wallet =  await Wallets.newFileSystemWallet(walletPath);
        let id = 'Org1 admin';
    
  try{ 

    const userGateway = new Gateway();
    await userGateway.connect(connectionProfile, { wallet, identity: id, discovery:{ "enabled": true, "asLocalhost": true }});
    network = await userGateway.getNetwork('mychannel');

    // Get addressability to the smart contract as specified in config
    contract = await network.getContract('Devfolio');
    var res={};
    const transaction = contract.createTransaction('updateContract');
    res['txId']=transaction.getTransactionId();
            
        
        await network.addBlockListener(async (event) => {
          // Handle block event
          console.log(event.blockNumber.getLowBits());
           res['blockNumber']=event.blockNumber.getLowBits();
          // Listener may remove itself if desired
      });
       
        res['status']="Transaction completed";

    await transaction.submit(ItemName,Component_name ,dict);
    console.log('Transaction has been submitted');
    await network.addBlockListener(async (event) => {
      // Handle block event
      console.log(event.blockNumber.getLowBits());
       res['blockNumber']=event.blockNumber.getLowBits();
      // Listener may remove itself if desired
  });
   
    res['status']="Transaction completed";


    // Disconnect from the gateway.
     userGateway.disconnect();
    return res;

} catch (error) {
    console.error(`Failed to submit transaction: ${error}`);
    response.error = error.message;
    return response; 
}
}



utils.ReadMyAsset = async function(ItemName) {

    try {
      const connectionProfileJson = (await fs.readFileSync('gatewayv2/DevfolioVOrg1GatewayConnection.json')).toString();
      const connectionProfile = JSON.parse(connectionProfileJson);
      const walletPath = path.join(process.cwd(), '/walletsv2/Org1');
      const wallet =  await Wallets.newFileSystemWallet(walletPath);
          let id = 'Org1 admin'; 
        
        const userGateway = new Gateway();
        await userGateway.connect(connectionProfile, { wallet, identity: id, discovery:{ "enabled": true, "asLocalhost": true }});

        
        network = await userGateway.getNetwork('mychannel');

        // Get addressability to the smart contract as specified in config
        contract = await network.getContract('Devfolio');
     
        
        const result = await contract.evaluateTransaction('readMyAsset',ItemName);

        console.log(`Transaction has been evaluated, result is: ${result.toString()}`);

        return JSON.parse(result.toString());

    } catch (error) {
        console.error(`Failed to evaluate transaction: ${error}`);
        response.error = error.message;
        return response;
    }
}
utils.BlockInfo = async function(bnum) {

    try {
      const connectionProfileJson = (await fs.readFileSync('gatewayv2/DevfolioVOrg1GatewayConnection.json')).toString();
      const connectionProfile = JSON.parse(connectionProfileJson);
      const walletPath = path.join(process.cwd(), '/walletsv2/Org1');
      const wallet =  await Wallets.newFileSystemWallet(walletPath);
          let id = 'Org1 admin';
        const userGateway = new Gateway();
        await userGateway.connect(connectionProfile, { wallet, identity: id, discovery:{ "enabled": true, "asLocalhost": true }});
        network = await userGateway.getNetwork("mychannel");

        var contract = network.getContract("qscc");

            let response_payload = await contract.evaluateTransaction('GetBlockByNumber','mychannel',bnum);
            response_payload =  BlockDecoder.decode(response_payload);
            if (response_payload) {
               console.log(response_payload);
                console.log(JSON.parse(response_payload['data']['data'][0]['payload']['data']['actions'][0]['payload']['action']['proposal_response_payload']['extension']['results']['ns_rwset'][0]['rwset']['writes'][0]['value']));
               return response_payload;
            } else {
                return 'response_payload is null';
           }
        } catch (error) {
            return error.toString();
        } 

}

utils.getTransactionByID = async function ( trxnID) {
	try {
    const connectionProfileJson = (await fs.readFileSync('gatewayv2/DevfolioVOrg1GatewayConnection.json')).toString();
    const connectionProfile = JSON.parse(connectionProfileJson);
    const walletPath = path.join(process.cwd(), '/walletsv2/Org1');
    const wallet =  await Wallets.newFileSystemWallet(walletPath);
        let id = 'Org1 admin';
        const userGateway = new Gateway();
        await userGateway.connect(connectionProfile, { wallet, identity: id, discovery:{ "enabled": true, "asLocalhost": true }});
        network = await userGateway.getNetwork("mychannel");
        
        var contract = network.getContract("qscc");

        let response_payload = await contract.evaluateTransaction('GetTransactionByID','mychannel',trxnID);
        response_payload =  BlockDecoder.decodeTransaction(response_payload);
		if (response_payload) {
           console.log(JSON.parse(response_payload['transactionEnvelope']['payload']['data']['actions'][0]['payload']['action']['proposal_response_payload']['extension']['results']['ns_rwset'][0]['rwset']['writes'][0]['value']));
			return response_payload;
		} else {
			return 'response_payload is null';
		}
	} catch (error) {
		return error.toString();
	}
};
module.exports = utils;
