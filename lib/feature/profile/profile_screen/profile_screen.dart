import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redeem/constant/constant.dart';
import 'package:redeem/feature/Login/login_screen/login_screen.dart';
import 'package:redeem/feature/Login/service/auth_service.dart';
import 'package:redeem/feature/profile/profile_screens_details/about_screen.dart';
import 'package:redeem/feature/profile/profile_screens_details/branch_screen.dart';
import 'package:redeem/feature/profile/profile_screens_details/feedback/feedback_screen/feedback_screen.dart';
import 'package:redeem/feature/profile/profile_screens_details/privacy_policy_screen.dart';
import 'package:redeem/widgets/mytext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<IconData> icons = [
    Icons.contacts,
    Icons.domain,
    Icons.chat_bubble,
    Icons.verified_user,
  ];
  final List<String> iconNames = [
    'About Us ',
    'Branches',
    'Feedback',
    'Privacy Policy',
  ];

  final AuthService _authService = AuthService();

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // userName =
      //     prefs.getString('user_name') ??
      //     'User'; // Fetch user_name or use default

      userAddress = prefs.getString('user_address') ?? 'Address';
      userPoints = prefs.getString('user_total_points') ?? "error user points";
      userPhone = prefs.getString('user_phone') ?? "error user phone number";
      seasonalPoints =
          (prefs.getDouble('user_seasonal_points') ?? 0).toString();
      userEmail = prefs.getString('user_email') ?? "error user email";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadUserData,
        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(), // Ensure scroll even if content is short
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.symmetric(horizontal: 15.w),
                    height: 75.h,
                    width: 290.w,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // decoration: BoxDecoration(border: Border.all(width: 1)),
                          child: Image.asset(
                            'assets/images/user_new.png',
                            fit: BoxFit.cover,
                            width: 50.w,
                            height: 50.h,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0.w, 0),
                              // padding: EdgeInsets.fromLTRB(6.w, 0, 0, 0),
                              height: 20.h,
                              width: 240.w,
                              decoration: BoxDecoration(
                                // border: Border.all(width: 1),
                              ),
                              child: Mytext(
                                text:
                                    userEmail == null
                                        ? 'User'
                                        : userEmail ?? 'User',
                                // text: "sanishshrestha29@gmail.com",
                                fontSize:
                                    (userEmail != null &&
                                            userEmail!.length > 18)
                                        ? 12.sp
                                        : 14.sp,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible,
                                maxLines: 2,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 39.w, 0),
                              height: 20.h,
                              width: 200.w,
                              decoration: BoxDecoration(
                                // border: Border.all(width: 1),
                              ),
                              child: Mytext(
                                text: "Number: ${userPhone ?? 'error'}",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.fromLTRB(0, 0, 85.w, 0),
                            //   child: Mytext(
                            //     text: 'Address: $userAddress',
                            //     fontSize: 14.sp,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.0),
                          ),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: SizedBox(
                              height: 100.h,
                              width: 350.h,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Mytext(
                                        text:
                                            "Are you sure you want to logout?",
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 110.w,
                                        height: 40.h,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Mytext(
                                            text: 'No',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 110.w,
                                        height: 40.h,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _authService.logout();
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return LoginScreen();
                                                },
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                  255,
                                                  246,
                                                  103,
                                                  98,
                                                ),
                                          ),
                                          child: Mytext(
                                            text: 'Yes',
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Container(
                      // decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Icon(
                        Icons.logout,
                        color: Colors.black,
                        size: 30.sp,
                      ),
                    ),
                    tooltip: 'Logout',
                  ),
                ],
              ),
              Divider(height: 5, indent: 5, endIndent: 5, color: Colors.grey),

              ListView.separated(
                itemCount: icons.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade400, Colors.blue.shade700],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          icons[index],
                          size: 32.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Mytext(
                      text: iconNames[index],
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutScreen(),
                          ),
                        );
                      } else if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BranchScreen();
                            },
                          ),
                        );
                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return FeedbackScreen();
                            },
                          ),
                        );
                      } else if (index == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PrivacyPolicyScreen();
                            },
                          ),
                        );
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20,
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                      indent: 16,
                      endIndent: 16,
                    ),
                  );
                },
              ),
              SizedBox(height: 10.h),
              Divider(height: 1, color: Colors.grey, indent: 16, endIndent: 16),
            ],
          ),
        ),
      ),
    );
  }
}
