// ignore: avoid_web_libraries_in_flutter

import 'package:StyleDraft_App/constants.dart';
import 'package:StyleDraft_App/services/firebase_services.dart';
import 'package:StyleDraft_App/widgets/custom_action_bar.dart';
import 'package:StyleDraft_App/widgets/image_swipe.dart';
import 'package:StyleDraft_App/widgets/product_size.dart';
import 'package:StyleDraft_App/widgets/custom_slider.dart';
import 'package:StyleDraft_App/widgets/custom_btn.dart';

import 'package:flutter/material.dart';

class SellPage extends StatefulWidget {
  final String productId;
  SellPage({this.productId});

  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _selectedProductSize = "0";

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
    double _value = 50;
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
                int high_bid = documentData['price'] + 500;
                int low_ask = documentData['price'] - 200;
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
                        "₹ ${documentData['price']}",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 84.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Highest Bid",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14.0,
                            ),
                            child: Text("|"),
                          ),
                          Text(
                            "Lowest Ask",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 84.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "₹ " + high_bid.toString(),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 70,
                          ),
                          Text(
                            "₹ " + low_ask.toString(),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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
                    Container(width: 10.0, child: _tabSection(context,documentData['price']))


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

Widget _tabSection(BuildContext context,int check) {
  return DefaultTabController(
    length: 2,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 24.0,
        horizontal: 24.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              child: TabBar(
                  unselectedLabelColor: Colors.redAccent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.redAccent, Colors.orangeAccent]),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.redAccent),
                  tabs: [
                    Tab(
                      text: "Place Ask",
                    ),
                    Tab(text: "Sell Now"),
                  ]),
            ),
          ),
          Container(
            //Add this to give height

            height: 200,
            child: TabBarView(children: [
              Container(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelText: 'Price',
                          prefixIcon: IconButton(
                            icon: Icon(Icons.credit_card),
                            color: Colors.blue,
                            onPressed: () {},
                          ),
                          hintText: 'Cost Price',
                        ),
                      ),
                      CustomBtn(
                        text: "Confirm Value",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                elevation: 16,
                                child: Container(
                                  height: 400.0,
                                  width: 360.0,
                                  child: Center(
                                    child: Text(
                                      "Your Demand Price is Recieved",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        outlineBtn: true,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        "Checkout :- "+"₹ "+check.toString(),
                        style: Constants.boldHeading,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: CustomBtn(
                        text: "Confirm Sale",
                        onPressed: () {},
                        outlineBtn: true,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    ),
  );
}
