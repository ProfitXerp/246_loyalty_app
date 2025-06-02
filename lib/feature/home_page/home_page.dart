import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redeem/constant/constant.dart';
import 'package:redeem/feature/Login/service/auth_service.dart';
import 'package:redeem/feature/home_page/home_content/home_content.dart';
import 'package:redeem/feature/notification/notification.dart';
import 'package:redeem/feature/profile/profile_screen/profile_screen.dart';
import 'package:redeem/feature/redeem/redeemScreen/redeem_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;
  final List<Widget> _pages = [RedeemScreen(), HomePage(), ProfileScreen()];

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName =
          prefs.getString('user_name') ??
          'User'; // Fetch user_name or use default

      userAddress = prefs.getString('user_address') ?? 'Address';
      userPoints = prefs.getString('user_total_points') ?? "error user points";
      userPhone = prefs.getString('user_phone') ?? "error user phone number";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80.h,
        title: Row(
          children: [
            SizedBox(
              height: 50.h,
              width: 50.w,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                child: Container(
                  height: 20.h,
                  width: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    // border: Border.all(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    image: DecorationImage(
                      image: AssetImage('assets/images/naya_user.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            SizedBox(
              height: 60.h,
              width: 235.w,
              // decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/246_logo.png',
                    fit: BoxFit.fitWidth,
                    height: 55.h,
                    width: 90.w,
                  ),
                  Image.asset(
                    'assets/images/246_name.png',
                    fit: BoxFit.contain,
                    height: 50.h,
                    width: 135.w,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NotificationScreen();
                  },
                ),
              );
            },
            icon: Icon(Icons.notifications, size: 30.sp, color: Colors.black),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          RedeemScreen(),

          HomeContentWidget(
            // userPoints: userPoints ?? '0',
            onRefreshUserData: () {
              _loadUserData();
            },
          ),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Redeem',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
