import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redeem/widgets/mytext.dart';

class BranchScreen extends StatelessWidget {
  const BranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Branch Screen'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Center(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  spreadRadius: 1,
                  blurRadius: 6,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Added image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    'assets/images/246_logo.png',
                    height: 100.h,
                    width: 160.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16.h),
                Mytext(
                  text: '246 Accessories Zone',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 8.h),
                Mytext(
                  text:
                      'Accessories And Mobile wholesale store in Bharatpur, Nepal',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Mytext(
                  text: 'Address: Indradev Marg, Bharatpur 44207',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 8.h),
                Mytext(
                  text: 'Phone: 9802980205',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
