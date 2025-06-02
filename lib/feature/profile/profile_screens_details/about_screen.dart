import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redeem/widgets/mytext.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> name1 = ['Founded', 'Employees', 'Customer', 'Country'];
    final List<String> name2 = ['2020', '500+', '20000+', 'Nepal'];
    return Scaffold(
      appBar: AppBar(toolbarHeight: 80.h, title: Text('About Us')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Container(
                width: 350.h,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  // border: Border.all(width: 1),
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
                    Center(
                      child: Image.asset(
                        'assets/images/246_logo.png',
                        height: 100.h,
                        width: 150.w,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: Mytext(
                        text: "Our Company",
                        fontSize: 24.sp,
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
                              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et ',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Mytext(
                          text:
                              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    ListView.separated(
                      itemCount: name1.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Mytext(
                            text: name1[index],
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),

                          trailing: Mytext(
                            text: name2[index],
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20.h,
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
