/*
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const { Contract } = require('fabric-contract-api');

class MyAssetContract extends Contract {
    async myAssetExists(ctx, ItemName) {
        const buffer = await ctx.stub.getState(ItemName);
        return (!!buffer && buffer.length > 0);
    }

    async createContract(ctx,ItemName,price) {
        const exists = await this.myAssetExists(ctx, ItemName);
        if (exists) {
            throw new Error(`The my asset ${ItemName} already exists`);
        }
        const asset = { ItemName,price };
        const buffer = Buffer.from(JSON.stringify(asset));
        await ctx.stub.putState(ItemName, buffer);
    }

    async readMyAsset(ctx, ItemName) {
        const exists = await this.myAssetExists(ctx, ItemName);
        if (!exists) {
            throw new Error(`The my asset ${ItemName} does not exist`);
        }
        const buffer = await ctx.stub.getState(ItemName);
        const asset = JSON.parse(buffer.toString());
        return asset;
    }

    async updateContract(ctx, ItemName,Component_name ,dict) {
        const exists = await this.myAssetExists(ctx, ItemName);
        if (!exists) {
            throw new Error(`The my asset ${ItemName} does not exist`);
        }
        let date_ob = new Date();
        let date = ("0" + date_ob.getDate()).slice(-2);
        let month = ("0" + (date_ob.getMonth() + 1)).slice(-2);
        let year = date_ob.getFullYear();
        let hours = date_ob.getHours();
        let minutes = date_ob.getMinutes();
        let seconds = date_ob.getSeconds();
        let  timestamp = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;
        var data = await ctx.stub.getState(ItemName);
        data = JSON.parse(data.toString());
        var updateddata={};
        for(var key in data){
            if(key == "ItemName"){
                continue;
            }
            updateddata[key] = data[key];
        }

        dict = JSON.parse(dict);
        dict['timestamp']=timestamp;
        updateddata[Component_name]=dict;
        const buffer = Buffer.from(JSON.stringify(updateddata));
        await ctx.stub.putState(ItemName, buffer);
    }
   
    async deleteMyAsset(ctx, ItemName) {
        const exists = await this.myAssetExists(ctx, ItemName);
        if (!exists) {
            throw new Error(`The my asset ${ItemName} does not exist`);
        }
        await ctx.stub.deleteState(ItemName);
    }


}

module.exports = MyAssetContract;
