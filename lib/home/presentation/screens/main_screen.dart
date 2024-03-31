import 'package:flutter/material.dart';
import 'package:fridge/auth/presentation/screens/login_screen.dart';
import 'package:fridge/auth/presentation/screens/register_screen.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_constants.dart';
import '../../../core/resources/app_strings.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static TextStyle optionStyle = getSmallStyle(fontSize: 14.0);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    LoginScreen(),
    RegisterScreen(),
    HomeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.only(
        //       topRight: Radius.circular(30.0),
        //       topLeft: Radius.circular(30.0)
        //   ),
        //   boxShadow: [
        //     BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 4),
        //   ],
        // ),
        decoration: BoxDecoration(
    // borderRadius: BorderRadius.only(
    //       topRight: Radius.circular(30.0),
    //       topLeft: Radius.circular(30.0)
    //   ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              spreadRadius: 4
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? Image.asset(
                      AppAssets.homeSelected,
                      width: 20,
                      height: 20,
                    )
                  : Image.asset(
                      AppAssets.home,
                      width: 20,
                      height: 20,
                    ),
              label: AppStrings.bottomBarMain,
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? Image.asset(
                      AppAssets.clientsSelected,
                      width: 20,
                      height: 20,
                    )
                  : Image.asset(
                      AppAssets.clients,
                      width: 20,
                      height: 20,
                    ),
              label: AppStrings.bottomBarClients,
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? Image.asset(
                      AppAssets.fridgeSelected,
                      width: 20,
                      height: 20,
                    )
                  : Image.asset(
                      AppAssets.fridge,
                      width: 20,
                      height: 20,
                    ),
              label: AppStrings.bottomBarFridge,
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 3
                  ? Image.asset(
                      AppAssets.reportsSelected,
                      width: 20,
                      height: 20,
                    )
                  : Image.asset(
                      AppAssets.reports,
                      width: 20,
                      height: 20,
                    ),
              label: AppStrings.bottomBarReports,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff2D5AAF),
          unselectedItemColor: AppColors.dark3,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

/*
class MainScreen extends StatefulWidget {

  final int selectedIndex;
  const MainScreen({super.key, this.selectedIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late PersistentTabController _controller;
  late int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    debugPrint('Selected Tab Index $_selectedIndex');
    _controller = PersistentTabController(initialIndex: _selectedIndex);
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const LoginScreen(),
      const RegisterScreen(),
      const HomeScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        onPressed: (BuildContext? context) {
          setState(() {
            _selectedIndex = 0;
            _controller.index = 0;
          });
        },
        textStyle: getSmallStyle(
            fontSize: 14.0,
            color: _selectedIndex == 0 ? const Color(0xff2D5AAF) : AppColors.dark3
        ),
        icon: _selectedIndex == 0 ? Image.asset(AppAssets.homeSelected, width: 20, height: 20,) : Image.asset(AppAssets.home, width: 20, height: 20,),
        title: AppStrings.bottomBarMain,
        activeColorPrimary: const Color(0xff2D5AAF),
      ),
      PersistentBottomNavBarItem(
        onPressed: (BuildContext? context) {
          setState(() {
            _selectedIndex = 1;
            _controller.index = 1;
          });
        },
        textStyle: getSmallStyle(
            fontSize: 14.0,
            color: _selectedIndex == 1 ? const Color(0xff2D5AAF) : AppColors.dark3
        ),
        icon: _selectedIndex == 1 ? Image.asset(AppAssets.clientsSelected, width: 20, height: 20,) : Image.asset(AppAssets.clients, width: 20, height: 20,),
        title: AppStrings.bottomBarClients,
        activeColorPrimary: const Color(0xff2D5AAF),
      ),
      PersistentBottomNavBarItem(
        onPressed: (BuildContext? context) {
          setState(() {
            _selectedIndex = 2;
            _controller.index = 2;
          });
        },
        textStyle: getSmallStyle(
            fontSize: 14.0,
            color: _selectedIndex == 2 ? const Color(0xff2D5AAF) : AppColors.dark3
        ),
        icon: _selectedIndex == 2 ? Image.asset(AppAssets.fridgeSelected, width: 20, height: 20,) : Image.asset(AppAssets.fridge, width: 20, height: 20,),
        title: AppStrings.bottomBarFridge,
        activeColorPrimary: const Color(0xff2D5AAF),
      ),
      PersistentBottomNavBarItem(
        onPressed: (BuildContext? context) {
          setState(() {
            _selectedIndex = 3;
            _controller.index = 3;
          });
        },
        textStyle: getSmallStyle(
            fontSize: 14.0,
            color: _selectedIndex == 3 ? const Color(0xff2D5AAF) : AppColors.dark3
        ),
        icon: _selectedIndex == 3 ? Image.asset(AppAssets.reportsSelected, width: 20, height: 20,) : Image.asset(AppAssets.reports, width: 20, height: 20,),
        title: AppStrings.bottomBarReports,
        activeColorPrimary: const Color(0xff2D5AAF),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        decoration: const NavBarDecoration(
          colorBehindNavBar: AppColors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0)
          ),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 4),
          ],
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: AppConstants.sliderAnimationTime,
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: AppConstants.sliderAnimationTime,
        ),
        navBarStyle: NavBarStyle.style6
      ),
    );
  }
}*/
