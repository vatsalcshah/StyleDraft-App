import 'dart:io';

import 'package:StyleDraft_App/constants.dart';
import 'package:StyleDraft_App/services/firebase_services.dart';
import 'package:StyleDraft_App/widgets/custom_action_bar.dart';
import 'package:StyleDraft_App/widgets/image_swipe.dart';
import 'package:StyleDraft_App/widgets/product_size.dart';
import 'package:StyleDraft_App/screens/auction_page.dart';
import 'package:StyleDraft_App/screens/sell_page.dart';

import 'package:StyleDraft_App/widgets/custom_btn.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  final String productId;
  ProductPage({this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _selectedProductSize = "0";
  var res;
  Future _addToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  Future _addToSaved() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  final SnackBar _snackBar = SnackBar(
    content: Text("Product added to the cart"),
  );

  @override
  Widget build(BuildContext context) {
    final String productid = (widget.productId);

    Future<String> request(url) async {
      // produces a request object
      var request = await HttpClient().getUrl(Uri.parse(url));
      // sends the request
      var response = await request.close();

      // transforms and prints the response
      await for (var contents in response.transform(Utf8Decoder())) {
        print(contents);
        res = json.decode(contents);
        return contents;
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                // Firebase Document Data Map
                Map<String, dynamic> documentData = snapshot.data.data();

                // List of images
                List imageList = documentData['images'];
                List productSizes = documentData['size'];
                request('http://192.168.0.107:3000/api/GetItemInfo?ItemName=' +
                    "${documentData['name']}");

                // Set an initial size
                _selectedProductSize = productSizes[0];

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    ImageSwipe(
                      imageList: imageList,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 24.0,
                        right: 24.0,
                        bottom: 4.0,
                      ),
                      child: Text(
                        "${documentData['name']}",
                        style: Constants.boldHeading,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "\$${documentData['price']}",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 104.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                                side: BorderSide(color: Colors.green)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AuctionPage(
                                      productId: productid,
                                    ),
                                  ));
                            },
                            child: Text(
                              "Buy",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          RaisedButton(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                                side: BorderSide(color: Colors.red)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SellPage(
                                      productId: productid,
                                    ),
                                  ));
                            },
                            child: Text(
                              "Sell",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      ),
                      child: CustomBtn(
                        text: "Verified by HyperLedger",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                elevation: 16,
                                child: Container(
                                  color: Colors.black,
                                  height: 400.0,
                                  width: 360.0,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 60.0,
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            "${documentData['name']}",
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        child: Text(
                                          res.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        outlineBtn: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "${documentData['desc']}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "Select Size",
                        style: Constants.regularDarkText,
                      ),
                    ),
                    ProductSize(
                      productSizes: productSizes,
                      onSelected: (size) {
                        _selectedProductSize = size;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await _addToSaved();
                              Scaffold.of(context).showSnackBar(_snackBar);
                            },
                            child: Container(
                              width: 65.0,
                              height: 65.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFDCDCDC),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage(
                                  "assets/images/tab_saved.png",
                                ),
                                height: 22.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await _addToCart();
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                height: 65.0,
                                margin: EdgeInsets.only(
                                  left: 16.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Add To Cart",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              }

              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            hasBackArrrow: true,
            hasTitle: false,
            hasBackground: false,
          )
        ],
      ),
    );
  }
}

Widget _buildName({String imageAsset, String name, String score}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      children: <Widget>[
        SizedBox(height: 12),
        Container(height: 2, color: Colors.redAccent),
        SizedBox(height: 12),
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(imageAsset),
              radius: 30,
            ),
            SizedBox(width: 12),
            Text(name),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text("${score}"),
              decoration: BoxDecoration(
                color: Colors.yellow[900],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
