import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redeem/feature/Login/service/auth_service.dart';
import 'package:redeem/feature/home_page/banner/banner_screen/banner_screen.dart';
import 'package:redeem/feature/home_page/log/log_screen/log_screen.dart';
import 'package:redeem/feature/home_page/scheme/scheme_screen/scheme_screen.dart';
import 'package:redeem/feature/redeem/redeemModel/redeem_model.dart';
import 'package:redeem/widgets/mytext.dart';

class HomeContentWidget extends StatefulWidget {
  final VoidCallback onRefreshUserData;
  // final String userPoints;
  const HomeContentWidget({
    super.key,
    // required this.userPoints,
    required this.onRefreshUserData,
  });

  @override
  State<HomeContentWidget> createState() => _HomeContentWidgetState();
}

class _HomeContentWidgetState extends State<HomeContentWidget> {
  String? userName;
  String? userPoints;
  String? annualPoints;
  final List<Scheme> _schemes = [];
  final AuthService _authService = AuthService();

  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _loadUserData();
    // _loadSchemes();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _loadUserData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer when widget is disposed
    super.dispose();
  }
  // void _loadSchemes() async {
  //   try {
  //     final result = await SchemeService().fetchSchemes();
  //     setState(() {
  //       _schemes.addAll(result);
  //       // _isLoading = false;
  //     });
  //   } catch (e) {
  //     print('Error fetching schemes: $e');
  //     setState(() {
  //       // _hasError = true;
  //       // _isLoading = false;
  //     });
  //   }
  // }

  Future<void> _loadUserData() async {
    final userData = await _authService.getUserData();
    setState(() {
      userName = userData['userName'] ?? 'User';
      userPoints = userData['userPoints'] ?? '0';
      annualPoints = userData['annualPoints'] ?? '0';
    });
  }

  final List<Map<String, dynamic>> schemes = [
    {'name': "scheme-1", 'num': "999"},
    {'name': "scheme-2", 'num': "999"},
    {'name': "scheme-3", 'num': "999"},
    {'name': "scheme-4", 'num': "999"},
  ];
  final List<Color> containerColors = [
    Colors.lightGreen[400]!,
    Colors.pink[400]!,
    Colors.orange[400]!,
    Colors.teal[400]!,
  ];
  final List<Color> containerColors2 = [
    Colors.lightGreen[200]!,
    Colors.pink[200]!,
    Colors.orange[200]!,
    Colors.teal[200]!,
  ];

  String getGreetings() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadUserData,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 10.h),
            SizedBox(
              height: 200.h,
              width: 300.w,
              child: BannerScreen(),
              // decoration: BoxDecoration(border: Border.all(width: 1)),
              // child: Image.network(
              //   'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
              //   fit: BoxFit.cover,
              // ),
            ),
            SizedBox(height: 10.h),
            Container(
              width: 370.w,
              height: 110.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 209, 207, 207),
                    spreadRadius: 1,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 1, 66, 83),
                    const Color.fromARGB(255, 38, 232, 194),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadiusDirectional.vertical(
                  bottom: Radius.circular(20.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(height: 1.h),
                      Text(
                        getGreetings(),
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                        width: 150.w,
                        // decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Mytext(
                          text: userName ?? ' User',
                          fontSize:
                              (userName != null && userName!.length > 18)
                                  ? 9.sp
                                  : 13.sp, // Change font size if long
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          overflow: TextOverflow.visible,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 20.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Mytext(
                                text: "Verified",
                                fontSize: 12.sp,
                                // fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.left,
                                color: Color.fromARGB(255, 1, 72, 5),
                                overflow: TextOverflow.visible,
                                // maxLines: 1,
                                maxLines: 1,
                              ),
                            ),
                            Icon(
                              Icons.check_circle,
                              size: 16.sp,
                              color: const Color.fromARGB(255, 1, 72, 5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 90.h,
                    width: 170.w,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.green),
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 1, 66, 83),
                          const Color.fromARGB(255, 38, 232, 194),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.h,
                          width: 120.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 50.h,
                                width: 40.w,
                                child: Image.asset(
                                  'assets/images/badge.png',
                                  height: 90.h,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Flexible(
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Mytext(
                                    text: annualPoints ?? '0',
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                      255,
                                      250,
                                      200,
                                      17,
                                    ),
                                    overflow: TextOverflow.visible,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          height: 30.h,
                          width: 140.w,
                          decoration: BoxDecoration(
                            // color: Colors.white,
                            // border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Mytext(
                            text: 'Reward Balance',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(child: SchemeScreen()),
            SizedBox(child: LogScreen()),
          ],
        ),
      ),
    );
  }
}
