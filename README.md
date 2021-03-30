# StyleDraft
<img src = "https://user-images.githubusercontent.com/41834661/111059515-3ef69e80-84bc-11eb-8372-83ec66919459.png" width ="400" height ="400">

StyleDraft serves as an online thrift store, facilitating auctions between sellers and buyers, then collecting transaction and payment fees.HyperLedger Fabric provides transparency using blockchain technology. Sellers send purchased items to StyleDraft facilities for inspection and verification, then authenticated products are shipped to buyers.StyleDraft features a "stock market-like" variable pricing framework and discloses price histories for specific items.

Technologies Stack 
1) Dart(Flutter)
2) HyperLedger Fabric
3) FireBase
4) Firestore
5) JSON
6) NodeJS
7) Adobe XD

# The Problem 

![Alt Text](https://media.giphy.com/media/ANbD1CCdA3iI8/giphy.gif)

There is an abundance of applications where buyers and sellers can exchange products but there is a lack of a trustable platform where the organization is involved in the transparency of transcations this causes scepticism for users. Trading applications are also not involved in the process of validating the authenticity of the product which further increases the mistrust.

# Our Hack

![Alt Text](https://media.giphy.com/media/5z0cCCGooBQUtejM4v/giphy.gif)

Users will be able to track the journey of each product from the seller to our facility and finally till their doorstep using HyperLedger Fabric which is a private blockchain technology by IBM. Each product will be assessed at our facility and the exact condition of the product will be noted in the hyperledger, along with that fake products will be removed from the chain of supply.

# Screenshots :
  ## User Authentication
 <img src = "https://user-images.githubusercontent.com/41834661/111059247-0b1a7980-84ba-11eb-8028-ac79490d5196.PNG" width ="400" height ="700">   <img src = "https://user-images.githubusercontent.com/41834661/111059271-4cab2480-84ba-11eb-89d5-e6892ca7d708.PNG" width ="400" height ="700">
  
  ## Homepage
   <img src = "https://user-images.githubusercontent.com/53492853/112750424-29b65f80-8fe6-11eb-8d3a-6f3a9ffe3aed.PNG" width ="400" height ="700">   <img src = "https://user-images.githubusercontent.com/53492853/112750428-31760400-8fe6-11eb-93a9-e4ff6988b0ee.PNG" width ="400" height ="700">
  
  ## Product Screen
  <img src = "https://user-images.githubusercontent.com/53492853/112750426-2e7b1380-8fe6-11eb-8715-0c5dd7da15be.PNG" width ="400" height ="700"> 
  
  ## Search
   <img src = "https://user-images.githubusercontent.com/41834661/111059357-fab6ce80-84ba-11eb-9bdf-9492c41c5a40.PNG" width ="400" height ="700">   <img src = "https://user-images.githubusercontent.com/41834661/111059363-04d8cd00-84bb-11eb-9a54-b7260f42c172.PNG" width ="400" height ="700">
  
  ## Auction Pages
  <img src = "https://user-images.githubusercontent.com/41834661/111059403-410c2d80-84bb-11eb-94ff-6940c3b288ec.PNG" width ="400" height ="700">   <img src = "https://user-images.githubusercontent.com/41834661/111059412-4c5f5900-84bb-11eb-9a7a-dccffe58a7a6.PNG" width ="400" height ="700">


# API Endpoints For Hyperledger
```bash
$ cd APIV2\
$ npm install
$ node api.js
```

| Parameter | Example 
| - | - 
| `environment` | `localhost:3000`
## API Endpoints
```bash
$ # Create a Token (This will return a jwt Token which will last 1 min which can be used to make post requests)
$ curl -X POST -H "Content-Type: application/json" -d '{"password":"DuBaraMatPuchna"}' http://{environment}/api/login
$ # Example
$ curl -X POST -H "Content-Type: application/json" -d '{"password":"DuBaraMatPuchna"}' http://{environment}/api/login
```


```bash
$ # Create a Contract for item 
$ curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer {Token}" -d '{"ItemName":"{Item_name}","price":"{price}"}' http://{environment}/api/CreateAsset
$ # Example
$ curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImUwOGI0NzM0YjYxNmE0MWFhZmE5MmNlZTVjYzg3Yjc2MmRmNjRmYTIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vdGVuc29ycGxhY2UtZWQiOiJ0ZW5zb3JwbGFjZS1lYWIzYyIsImF1dGhfdGltZSI6MTYxMDAxMTU3NiwidXNlcl9pZCI6ImxqN3J6OVZOR1pOS0ZFVmRMWGNialRvWmpERTIiLCJzdWIiOiJsajdyejlWTkdaTktGRVZkTFhjYmpUb1pqREUyIiwiaWF0IjoxNjEwMDExNTc3LCJleHAiOjE2MTAwMTUxNzcsImVtYWlsIjoiYWRtaW5AdGVuc29ycGxhY2UuaW8iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiYWRtaW5AdGVuc29ycGxhY2UuaW8iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQw9koQNvc3GM0iGfvAekTUcHwZHfNL-7_zuePier58QiX3cD_4jcWta3y1r9CjsZVg2gVxUe7ne0nNg5YPoFNnsciGbZxhRM-alLlcgAdxmctVEt5OKEyGVjrsCoBRN2ckF1IR5j-aElp21iaU6ilAsaFWzraM9k9GfsjOIuYh0AeunT6Cs" -d '{"ItemName":"item3","price":"11495"}' http://{environment}/api/CreateAsset
```
```bash
$ # Get Item Details
$ curl  http://{environment}/api/GetItemInfo?ItemName={itemname} | jq
$ # Example
$ curl  http://{environment}/api/GetItemInfo?ItemName=item1 | jq
`
```bash
$ # Add Components Details
$ curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer {Token}" -d '{"ItemName":"{name}","component_name":"{component_name}","dict":{dictionary where key=location and value=value}"}' http://{environment}/api/AddBuyerInfo
$ # Example
$ curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImUwOGI0NzM0YjYxNmE0MWFhZmE5MmNlZTVjYzg3Yjc2MmRmNjRmYTIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vdGVuc29ycGxhY2UtZWQiOiJ0ZW5zb3JwbGFjZS1lYWIzYyIsImF1dGhfdGltZSI6MTYxMDAxMTU3NiwidXNlcl9pZCI6ImxqN3J6OVZOR1pOS0ZFVmRMWGNialRvWmpERTIiLCJzdWIiOiJsajdyejlWTkdaTktGRVZkTFhjYmpUb1pqREUyIiwiaWF0IjoxNjEwMDExNTc3LCJleHAiOjE2MTAwMTUxNzcsImVtYWlsIjoiYWRtaW5AdGVuc29ycGxhY2UuaW8iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiYWRtaW5AdGVuc29ycGxhY2UuaW8iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQw9koQNvc3GM0iGfvAekTUcHwZHfNL-7_zuePier58QiX3cD_4jcWta3y1r9CjsZVg2gVxUe7ne0nNg5YPoFNnsciGbZxhRM-alLlcgAdxmctVEt5OKEyGVjrsCoBRN2ckF1IR5j-aElp21iaU6ilAsaFWzraM9k9GfsjOIuYh0AeunT6Cs" -d '{"ItemName":"LeBron witness 6 ep","component_name":"sole","dict":{"location":"USA","vendor":"nike"}}' http://{environment}/api/AddComponentInfo
```

```bash
$ # Get Block Details by using blocknumber
$ curl  http://{environment}/api/block?num={Block_number} | jq
$ # Example
$ curl  http://{environment}/api/block?num=4 | jq
```
```bash
$ # Get Block Details by using blotransactionId which we get during post requests.
$ curl  http://{environment}/api/Getblockbytx?txid={TransactionId} | jq
$ # Example
$ curl  http://{environment}/api/Getblockbytx?txid=VZOR1pOS0ZFVmRMWGNialRvWmpERTIiLCJzdWIiOiJsajdyejlWTkdaTktG | jq
```
 
