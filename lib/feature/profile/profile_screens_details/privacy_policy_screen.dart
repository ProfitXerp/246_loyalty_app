import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redeem/widgets/mytext.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 80.h, title: Text('Privacy Policy')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Container(
                width: 350.h,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      color: Colors.grey,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Center(
                      child: Image.asset(
                        'assets/images/privacy_icon.png',
                        height: 90.h,
                        width: 90.w,
                      ),
                    ),

                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0.w, 0),
                      child: Mytext(
                        text: 'How We Use Information',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Mytext(
                          text:
                              'We use the information we collect to provide, maintain, and improve our services, process transactions, and communicate with you.',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Mytext(
                      text: 'How We Use Information',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Mytext(
                          text:
                              'In accordance with this policy, we will not distribute, sell, or otherwise disclose your personal information to third parties without your express permission.',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Mytext(
                      text: 'Data Security',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 10.h),

                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Mytext(
                          text:
                              'We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
