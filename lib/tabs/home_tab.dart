import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:StyleDraft_App/constants.dart';
import 'package:StyleDraft_App/widgets/custom_action_bar.dart';
import 'package:StyleDraft_App/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list view
                return Container(
                  padding: EdgeInsets.only(top: 408.0),
                  child: ListView(
                    padding: EdgeInsets.only(
                      top: 8.0,
                      bottom: 12.0,
                    ),
                    children: snapshot.data.docs.map((document) {
                      return ProductCard(
                        title: document.data()['name'],
                        imageUrl: document.data()['images'][0],
                        price: "₹ ${document.data()['price']}",
                        productId: document.id,
                      );
                    }).toList(),
                  ),
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
            title: "Home",
            hasBackArrrow: false,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 358.0, left: 150.0),
            child: Text(
              "New Arrivals",
              style: Constants.boldHeading,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 108.0),
              child: _tabSection(context))
        ],
      ),
    );
  }
}

Widget _tabSection(BuildContext context) {
  List bannerAdSlider = [
    "assets/top_deals_1.png",
    "assets/top_deals_2.png",
    "assets/top_deals_3.png",
  ];
  List bannerAdSlider2 = [
    "assets/brands1.jpg",
    "assets/brands2.png",
    "assets/brands3.png"
  ];
  List bannerAdSlider3 = [
    "assets/user1.png",
    "assets/user2.png",
    "assets/user3.png"
  ];
  return DefaultTabController(
    length: 3,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 24.0,
        horizontal: 14.0,
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
                      text: "Hot Deal",
                    ),
                    Tab(text: "Brands"),
                    Tab(
                      text: "Top Sellers",
                    ),
                  ]),
            ),
          ),
          Container(
            //Add this to give height
            height: 200.0,
            child: TabBarView(children: [
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 18 / 5,
                    autoPlay: true,
                  ),
                  items: bannerAdSlider.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image(
                              image: AssetImage(i),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 18 / 5,
                    autoPlay: true,
                  ),
                  items: bannerAdSlider2.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image(
                              image: AssetImage(i),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 18 / 5,
                    autoPlay: true,
                  ),
                  items: bannerAdSlider3.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image(
                              image: AssetImage(i),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ]),
          ),
        ],
      ),
    ),
  );
}
