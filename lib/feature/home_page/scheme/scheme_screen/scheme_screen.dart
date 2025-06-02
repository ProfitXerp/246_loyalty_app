import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:redeem/feature/home_page/scheme/scheme_model/scheme_model.dart';
import 'package:redeem/feature/home_page/scheme/scheme_service/scheme_service.dart';
import 'package:redeem/widgets/mytext.dart';
import 'package:shimmer/shimmer.dart';

class SchemeScreen extends StatefulWidget {
  const SchemeScreen({super.key});

  @override
  State<SchemeScreen> createState() => _SchemeScreenState();
}

class _SchemeScreenState extends State<SchemeScreen> {
  final List<Scheme> _schemes = [];
  bool _isLoading = true;
  bool _hasError = false;

  final List<Color> containerColors = [
    const Color.fromARGB(255, 217, 237, 182),
    const Color.fromARGB(255, 236, 204, 213),
    const Color.fromARGB(255, 234, 210, 175),
    const Color.fromARGB(255, 180, 240, 234),
    const Color.fromARGB(255, 239, 243, 232),
    const Color.fromARGB(255, 236, 204, 213),
    const Color.fromARGB(255, 234, 210, 175),
    const Color.fromARGB(255, 180, 240, 234),
  ];

  final List<Color> containerColors2 = [
    const Color.fromARGB(255, 218, 238, 190),
    const Color.fromARGB(255, 234, 214, 220),
    const Color.fromARGB(255, 245, 216, 172),
    const Color.fromARGB(255, 186, 240, 235),
    const Color.fromARGB(255, 232, 237, 225),
    const Color.fromARGB(255, 234, 214, 220),
    const Color.fromARGB(255, 245, 216, 172),
    const Color.fromARGB(255, 186, 240, 235),
  ];

  @override
  void initState() {
    super.initState();
    _loadSchemes();
  }

  void _loadSchemes() async {
    try {
      final List<Scheme> result = await SchemeService().fetchSchemes();
      setState(() {
        _schemes.addAll(result);
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching schemes: $e');
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  Widget _buildShimmerLoader() {
    return SizedBox(
      height: 140.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            width: 175.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 15.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(height: 10.h, width: 70.w, color: Colors.white),
                  SizedBox(height: 5.h),
                  Container(height: 10.h, width: 50.w, color: Colors.white),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: _buildShimmerLoader());
    }
    if (_hasError) {
      return const Center(child: Text('Failed to load schemes.'));
    }
    if (_schemes.isEmpty) {
      return const Center(child: Text('No schemes available.'));
    }
    return SizedBox(
      height: 140.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        scrollDirection: Axis.horizontal,
        itemCount: _schemes.length,
        itemBuilder: (context, index) {
          final scheme = _schemes[index];
          double limit = double.tryParse(scheme.rule?.limit ?? '') ?? 0;
          double remaining = limit - (scheme.totalPoints);
          String remainingPointsText = scheme.rule != null ? '$remaining' : '';
          double percentage = limit > 0 ? (scheme.totalPoints / limit) : 0;

          // Calculate days left
          int daysLeft = 0;
          try {
            final deadlineDate = DateTime.parse(scheme.deadline);
            final now = DateTime.now();
            daysLeft = deadlineDate.difference(now).inDays;
          } catch (e) {
            daysLeft = 0;
          }

          return GestureDetector(
            onTap: () {},
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder:
            //           (context) => SchemeDetailScreen(
            //             schemeName: schemes[index]['name'],
            //             schemeNum: schemes[index]['num'],
            //           ),
            //     ),
            //   );
            // },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              width: 175.w,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.green),
                gradient: LinearGradient(
                  colors: [
                    containerColors[index % containerColors.length],
                    containerColors2[index % containerColors2.length],
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(0, 4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 25.h,
                          width: 35.w,
                          child: Image.asset('assets/images/badge.png'),
                        ),
                        SizedBox(width: 5.w),
                        Mytext(
                          text: _schemes[index].totalPoints.toStringAsFixed(2),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: LinearPercentIndicator(
                        lineHeight: 14.0,
                        animation: true,
                        animationDuration: 20,
                        percent: percentage.clamp(0.0, 1.0),
                        center: Text(
                          " ${(percentage.clamp(0.0, 1.0) * 100).toStringAsFixed(1)}%",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        progressColor: Colors.greenAccent,
                        backgroundColor: Colors.white,
                        barRadius: Radius.circular(20.r),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Mytext(
                      text:
                          percentage >= 1.0
                              ? 'You have successfully completed'
                              : '$remainingPointsText P required ($daysLeft days left)',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    SizedBox(height: 8.h),
                    Mytext(
                      text: _schemes[index].name,
                      fontSize: _schemes[index].name.length > 10 ? 8.sp : 11.sp,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      color: const Color.fromARGB(255, 29, 98, 32),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
