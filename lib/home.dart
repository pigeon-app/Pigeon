import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
// TODO: Replace once Flutter PR #21896 is merged
import 'util/scrollable_bottom_sheet.dart';
import 'util/scrollable_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.name}) : super(key: key);

  final String name;

  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  ScrollableController sController = ScrollableController();
  ScrollState prevScrollState = ScrollState.minimum;
  AnimationController aController;
  Animation<double> appBarOpacity;
  Animation<double> appBarElevation;

  @override
  void initState() {
    super.initState();

    aController = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    );

    appBarElevation = Tween(
      begin: 0.0,
      end: 4.0,
    ).animate(
        CurvedAnimation(
          parent: aController,
          curve: Interval(
            0.85, 1.0,
          ),
        )
    );

    appBarOpacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: aController,
        curve: Interval(
          0.0, 0.9,
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var drawerHalfHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kBottomNavigationBarHeight -
        kToolbarHeight;

    return AnimatedBuilder(
      animation: aController,
      builder: (context, child) {
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text(widget.name),
                  decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .primaryColor,
                  ),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.directions_car), title: Text('Drive')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), title: Text('Manage')),
            ],
            currentIndex: _selectedIndex,
            onTap: _onNavBarTapped,
          ),
          body: Stack(
            children: <Widget>[
              FlutterMap(
                options: MapOptions(
                  center: LatLng(37.568360, -122.012040),
                  zoom: 17.0,
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']),
                ],
              ),
              Positioned(
                bottom: 0.0,
                child: ScrollableBottomSheetByContent(
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    padding: EdgeInsets.all(16.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Four deliveries available nearby.",
                            style: Theme
                                .of(context)
                                .primaryTextTheme
                                .title),
                        SizedBox(height: 12),
                        Text("Swipe up or tap for details.",
                            style: Theme
                                .of(context)
                                .primaryTextTheme
                                .body1),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Column(
                        children: List.generate(100, (i) {
                          return Text("Item $i");
                        })),
                  ),
                  controller: sController,
                  halfHeight: drawerHalfHeight,
                  autoPop: false,
                  scrollTo: ScrollState.minimum,
                  snapAbove: false,
                  snapBelow: true,
                  callback: (state) {
                    return _onBottomSheetStateChange(context, state);
                  },
                ),
              ),
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  title: Text(widget.name),
                  elevation: appBarElevation.value,
                  backgroundColor: Colors.white.withOpacity(appBarOpacity.value),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  void _onNavBarTapped(int index) {
    // TODO: Change contents of persistent bottom sheet
    // TODO: Animate
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onBottomSheetStateChange(BuildContext context, ScrollState state) {
    if (prevScrollState != ScrollState.minimum && state == ScrollState.minimum) {
      aController.reverse();
    } else if (prevScrollState == ScrollState.minimum && state != ScrollState.minimum) {
      aController.forward();
    }

    prevScrollState = state;
  }
}

