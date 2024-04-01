import 'package:flutter/material.dart';
import 'package:fridge/auth/presentation/screens/login_screen.dart';
import 'package:fridge/auth/presentation/screens/register_screen.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_strings.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
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
      backgroundColor: AppColors.primaryLight,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 4),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
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
      ),
    );
  }
}
