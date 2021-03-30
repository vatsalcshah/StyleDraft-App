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

•Fashion—a $2.5 trillion sector—is the second most polluting industry on Earth, right behind oil. The pressure to reduce costs and speed up production time means that environmental corners are cut in the name of profit. Fast Fashion’s negative impact includes the use of cheap, toxic textile dyes – with the fashion industry the second largest polluter of clean water globally after agriculture.
The speed at which garments are produced also means that more and more clothes are disposed of by consumers, creating a huge amount of textile waste. In Canada, the average person throws out 81 pounds of textiles annually, while North Americans send 9.5 million tons of clothing to the landfill every year — most of which could be reused.
On April 24, 2013 the world got a reality check when the Rana Plaza clothing manufacturing complex in Bangladesh collapsed, killing over 1,000 workers and injuring over 2,500. There are approximately 40 million garment workers in the world today; many of whom do not have rights or protections. They are some of the lowest paid workers in the world and roughly 85% of all garment workers are women. The exploitation of women’s work is too big to ignore.

• There is an abundance of applications where buyers and sellers can exchange products but there is a lack of a trustable platform where the organization is involved in the transparency of transcations this causes scepticism for users. Trading applications are also not involved in the process of validating the authenticity of the product which further increases the mistrust.

# Our Hack

![Alt Text](https://media.giphy.com/media/5z0cCCGooBQUtejM4v/giphy.gif)

•With fast fashion seasons now changing every single week, new garments are being produced far too often. Ditch fast fashion like it’s last week’s trends and start shopping thrift! Shopping thrift is the best way to reduce your clothing footprint. It is a great way to find high quality, unique garments at a fraction of the price of buying new.

• Users will be able to track the journey of each product from the seller to our facility and finally till their doorstep using HyperLedger Fabric which is a private blockchain technology by IBM. Each product will be assessed at our facility and the exact condition of the product will be noted in the hyperledger, along with that fake products will be removed from the chain of supply.

## Getting started

#### 1. [Setup Flutter](https://flutter.dev/docs/get-started/install)

#### 2. Clone the repo

```sh
$ git clone https://github.com/mdanics/fluttergram.git
$ cd fluttergram/
```

#### 3. Setup the firebase app

1. You'll need to create a Firebase instance. Follow the instructions at https://console.firebase.google.com.
2. Once your Firebase instance is created, you'll need to enable Google authentication.

* Go to the Firebase Console for your new instance.
* Click "Authentication" in the left-hand menu
* Click the "sign-in method" tab
* Click "Google" and enable it

3. Create Cloud Functions (to make the Feed work)
* Create a new firebase project with `firebase init`
* Copy this project's `functions/lib/index.js` to your firebase project's `functions/index.js`
* Push the function `getFeed` with `firebase deploy --only functions`  In the output, you'll see the getFeed URL, copy that.
* Replace the url in the `_getFeed` function in `feed.dart` with your cloud function url from the previous step.

_**If this does not work**  and you get the error `Error: Error parsing triggers: Cannot find module './notificationHandler'` Try following [these steps](https://github.com/mdanics/fluttergram/issues/25#issuecomment-434031430). If you are still unable to get it to work please open a new issue._

_You may need to create the neccessary index by running `firebase functions:log` and then clicking the link_

_**If you are getting no errors, but an empty feed** You must post photos or follow users with posts as the getFeed function only returns your own posts & posts from people you follow._

4. Enable the Firebase Database
* Go to the Firebase Console
* Click "Database" in the left-hand menu
* Click the Cloudstore "Create Database" button
* Select "Start in test mode" and "Enable"

5. (skip if not running on Android)

* Create an app within your Firebase instance for Android, with package name com.yourcompany.news
* Run the following command to get your SHA-1 key:

```
keytool -exportcert -list -v \
-alias androiddebugkey -keystore ~/.android/debug.keystore
```

* In the Firebase console, in the settings of your Android app, add your SHA-1 key by clicking "Add Fingerprint".
* Follow instructions to download google-services.json
* place `google-services.json` into `/android/app/`.

6. (skip if not running on iOS)

* Create an app within your Firebase instance for iOS, with your app package name
* Follow instructions to download GoogleService-Info.plist
* Open XCode, right click the Runner folder, select the "Add Files to 'Runner'" menu, and select the GoogleService-Info.plist file to add it to /ios/Runner in XCode
* Open /ios/Runner/Info.plist in a text editor. Locate the CFBundleURLSchemes key. The second item in the array value of this key is specific to the Firebase instance. Replace it with the value for REVERSED_CLIENT_ID from GoogleService-Info.plist

Double check install instructions for both
   - Google Auth Plugin
     - https://pub.dartlang.org/packages/firebase_auth
   - Firestore Plugin
     -  https://pub.dartlang.org/packages/cloud_firestore



# Screenshots :
  ## User Authentication
 <img src = "https://user-images.githubusercontent.com/41834661/111059247-0b1a7980-84ba-11eb-8028-ac79490d5196.PNG" width ="400" height ="700">   <img src = "https://user-images.githubusercontent.com/41834661/111059271-4cab2480-84ba-11eb-89d5-e6892ca7d708.PNG" width ="400" height ="700">
  
  ## Homepage
   <img src = "https://user-images.githubusercontent.com/53492853/112750424-29b65f80-8fe6-11eb-8d3a-6f3a9ffe3aed.PNG" width ="400" height ="700">   <img src = "https://user-images.githubusercontent.com/53492853/112750428-31760400-8fe6-11eb-93a9-e4ff6988b0ee.PNG" width ="400" height ="700">
  
  ## Product Screen
  <img src = "https://user-images.githubusercontent.com/53492853/112750426-2e7b1380-8fe6-11eb-8715-0c5dd7da15be.PNG" width ="400" height ="700"> 
  
  ## Search
   <img src = "https://user-images.githubusercontent.com/53492853/112977202-66639180-9173-11eb-8406-dff4d1bcebca.PNG" width ="400" height ="700">   <img src = "https://user-images.githubusercontent.com/53492853/112977211-682d5500-9173-11eb-9df5-858417f390cf.PNG" width ="400" height ="700">
  
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
 
