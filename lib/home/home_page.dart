import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/cart_page/cart_history.dart';
import 'package:food_delivery/home/main_food_Page.dart';
import 'package:food_delivery/order/order_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../account/account_page.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex=0;
   //PersistentTabController? _controller;


  List pages =[
    MainFoodPage(),
    OrderPage(),
    CartHistory(),
    AccountPage()
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

    @override
    void initState(){
      super.initState();
      //_controller = PersistentTabController(initialIndex: 0);
    }

  //   List<Widget> _buildScreens() {
  //   return [
  //     MainFoodPage(),
  //     Container(child: Center(child: Text("Next page"))),
  //     Container(child: Center(child: Text("Next next page"))),
  //     Container(child: Center(child: Text("Next next next page")))
  //   ];
  // }
 /* List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: appColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.archivebox),
        title: ("history"),
        activeColorPrimary: appColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: ("cart"),
        activeColorPrimary: appColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("me"),
        activeColorPrimary: appColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }*/
  /*Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: Colors.white70,
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: NavBarStyle.style1,
      // Choose the nav bar style with this property
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: appColors.mainColor,
          unselectedItemColor:  Colors.black54,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: onTapNav,
          items: const[
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home,),
                label: "home",

            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.archivebox,),
                label: "history"
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.shopping_cart,),
                label: "cart"
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person,),
                label: "me"
            ),
          ]),
    );
  }




}
