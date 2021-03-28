import 'package:StyleDraft_App/tabs/home_tab.dart';
import 'package:StyleDraft_App/tabs/saved_tab.dart';
import 'package:StyleDraft_App/tabs/search_tab.dart';
import 'package:flutter/material.dart';
import 'package:cool_nav/cool_nav.dart';
import '';

class FlipBoxNavigationBarHome extends StatefulWidget {
  FlipBoxNavigationBarHome({Key key}) : super(key: key);

  @override
  _FlipBoxNavigationBarHomeState createState() =>
      _FlipBoxNavigationBarHomeState();
}

class _FlipBoxNavigationBarHomeState extends State<FlipBoxNavigationBarHome> {
  int currentIndex;

  _updateIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  List<Widget> Tabs = [
    HomeTab(),
    SearchTab(),
    SavedTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Tabs[currentIndex],
        bottomNavigationBar: FlipBoxNavigationBar(
          currentIndex: currentIndex,
          verticalPadding: 20.0,
          items: <FlipBoxNavigationBarItem>[
            FlipBoxNavigationBarItem(
              name: 'Home',
              selectedIcon: Icons.home_sharp,
              unselectedIcon: Icons.home_outlined,
              selectedBackgroundColor: Colors.deepOrange[400],
              unselectedBackgroundColor: Colors.blueGrey,
            ),
            FlipBoxNavigationBarItem(
              name: 'Search',
              selectedIcon: Icons.search_sharp,
              unselectedIcon: Icons.search_outlined,
              selectedBackgroundColor: Colors.deepOrange[400],
              unselectedBackgroundColor: Colors.blueGrey,
            ),
            FlipBoxNavigationBarItem(
              name: 'Saved',
              selectedIcon: Icons.bookmarks,
              unselectedIcon: Icons.bookmarks_outlined,
              selectedBackgroundColor: Colors.deepOrange[400],
              unselectedBackgroundColor: Colors.blueGrey,
            ),
          ],
          onTap: _updateIndex,
        ));
  }
}
