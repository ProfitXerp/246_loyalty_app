import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redeem/constant/constant.dart';
import 'package:redeem/feature/Login/login_screen/login_screen.dart';
import 'package:redeem/feature/Login/service/auth_service.dart';
import 'package:redeem/widgets/mytext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          children: [
            SizedBox(
              height: 50.0,
              width: 50.0,
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    // offset : Offset(0, 5)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  image: DecorationImage(
                    image: AssetImage('assets/images/user_placeholder.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getGreetings(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                  ),
                ),
                Text(
                  userName ?? 'User',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _authService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadUserData,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              // BannerScreen(),
              // CircularIndicatorScreen(),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(80),
                        offset: Offset(0, 5),
                        blurRadius: 10,
                      ),
                    ],
                  ),

                  height: 180.h,
                  width: 390.w,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Mytext(
                            text: "Reward Balance",
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 225, 8, 174),
                          ),

                          SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/coin.png',
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 8,
                                ), // spacing between image and text
                                Mytext(
                                  text: '$userPoints',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFF758C),
                                  Color(0xFFFFB88C),
                                ], // pink to orange gradient
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(
                                30,
                              ), // pill shape
                            ),
                            child: Text('data'),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFF758C),
                                  Color(0xFFFFB88C),
                                ], // pink to orange gradient
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                              ),
                              borderRadius: BorderRadius.circular(
                                30,
                              ), // pill shape
                            ),
                            child: Text('data'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          // Expanded(
                          //   child: Divider(
                          //     color: Colors.grey,
                          //     thickness: 0.5,
                          //     endIndent: 8,
                          //   ),
                          // ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Balance History',
                          //       style: TextStyle(
                          //         fontSize: 16,
                          //         fontWeight: FontWeight.w500,
                          //         color: Colors.black87,
                          //       ),
                          //     ),
                          //     SizedBox(width: 4.w),
                          //     Icon(
                          //       Icons.arrow_drop_down,
                          //       color: Color(0xFFFFA500), // Orange arrow
                          //       size: 24,
                          //     ),
                          //   ],
                          // ),
                          // const Expanded(
                          //   child: Divider(
                          //     color: Colors.grey,
                          //     thickness: 0.5,
                          //     indent: 8,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 250, child: BannerScreen()),
              // SizedBox(height: 320, child: CircularIndicatorScreen()),
              SizedBox(height: 20),
              // BannerScreen(),
              // Center(
              //   child: Stack(
              //     children: [
              //       // Background image
              //       SizedBox(
              //         // decoration: BoxDecoration(
              //         //   border: Border.all(width: 1),
              //         //   borderRadius: BorderRadius.circular(20),
              //         // ),
              //         height: 200,
              //         width: 350,
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(20),
              //           child: Image.asset(
              //             'assets/images/reward_card.png',
              //             fit: BoxFit.cover,
              //             height: double.infinity,
              //             width: double.infinity,
              //           ),
              //         ),
              //       ),
              //       // Overlay medal and badge images
              //       // Positioned(
              //       //   top: 0,
              //       //   left: 5,
              //       //   child: Container(
              //       //     height: 50,
              //       //     width: 50,
              //       //     decoration: const BoxDecoration(
              //       //       image: DecorationImage(
              //       //         image: AssetImage('assets/images/medal.png'),
              //       //         fit: BoxFit.contain,
              //       //       ),
              //       //     ),
              //       //   ),
              //       // ),
              //       // Positioned(
              //       //   top: 10,
              //       //   right: 130,
              //       //   child: Container(
              //       //     height: 80,
              //       //     width: 150,
              //       //     decoration: const BoxDecoration(),
              //       //     child: Text(
              //       //       'Reward Card',
              //       //       style: TextStyle(
              //       //         fontSize: 24,
              //       //         fontWeight: FontWeight.bold,
              //       //         color: Colors.white,
              //       //       ),
              //       //     ),
              //       //   ),
              //       // ),
              //       Positioned(
              //         top: 60,
              //         right: 265,
              //         child: Container(
              //           height: 30,
              //           width: 90,
              //           decoration: BoxDecoration(
              //             // border: Border.all(width: 1),
              //             // image: DecorationImage(
              //             //   image: AssetImage('assets/images/badge.png'),
              //             //   fit: BoxFit.contain,
              //             // ),
              //           ),
              //           child: Row(
              //             children: [
              //               // Image.asset('assets/images/reward_badge.png'),
              //               SizedBox(width: 20),
              //               Text(
              //                 '$userPoints',
              //                 style: TextStyle(
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         left: 10,
              //         top: 150,
              //         right: 10,
              //         child: SizedBox(
              //           height: 50,
              //           width: 20,
              //           // decoration: BoxDecoration(border: Border.all(width: 1)),
              //           child: Text(
              //             '$userPhone',
              //             style: TextStyle(
              //               fontSize: 20,
              //               fontWeight: FontWeight.bold,
              //               // color: Colors.white,
              //             ),
              //           ),
              //         ),
              //       ),

              //       Positioned(
              //         left: 190,
              //         top: 60,
              //         right: 10,
              //         child: SizedBox(
              //           height: 50,
              //           width: 20,
              //           // decoration: BoxDecoration(border: Border.all(width: 1)),
              //           child: Text(
              //             '$userName',
              //             style: TextStyle(
              //               fontSize: 20,
              //               fontWeight: FontWeight.bold,
              //               // color: Colors.white,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => RedemptionScreen()),
              //     );
              //     print('data button is pressed');
              //   },
              //   child: Text('data'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
