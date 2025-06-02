import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redeem/feature/home_page/log/log_model/log_model.dart';
import 'package:redeem/feature/home_page/log/log_service/log_service.dart';
import 'package:redeem/widgets/mytext.dart';
import 'package:shimmer/shimmer.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  List<LogModel> logs = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    try {
      final fetchedLogs = await LogService().fetchLogs();
      setState(() {
        logs = fetchedLogs;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Widget buildWidgetBuilder() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200.h,
              width: 370.w,
              decoration: BoxDecoration(color: Colors.grey.shade300),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 20.h),
                        Container(
                          height: 40.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      height: 50.h,
                      width: 340.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: buildWidgetBuilder());
    } else if (errorMessage != null) {
      return Center(child: Text('Error: $errorMessage'));
    } else if (logs.isEmpty) {
      return const Center(child: Text('No logs found.'));
    } else {
      return Column(
        children: [
          SizedBox(height: 10.h),
          Container(
            color: Colors.grey[100],
            child: Row(
              children: [
                SizedBox(width: 10.w),
                SizedBox(height: 50.h),
                Mytext(
                  text: "Recent Activity",
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Container(
            width: 370.w,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              // border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              itemCount: logs.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final log = logs[index];
                String dateOnly = log.createdAt.split('T').first;
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 237, 241, 239),
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    height: 70.h,
                    width: 60.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Mytext(
                              text: '${log.voucherSeries}/ ${log.billNo}',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            Mytext(
                              text: dateOnly,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 0),
                              height: 30.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: const Color.fromARGB(255, 12, 132, 16),
                                ),
                                color: const Color.fromARGB(255, 27, 162, 149),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 4.h,
                                ),
                                child: Mytext(
                                  text: '+${log.points}',

                                  // text: '+3000.00',
                                  fontSize:
                                      (log.points.length) > 2 ? 11.sp : 8.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Mytext(
                              text: log.subuser.name,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                              color: const Color.fromARGB(255, 3, 126, 139),
                            ),
                            Mytext(
                              text:
                                  "Rs:${double.tryParse(log.amount)?.toStringAsFixed(1) ?? log.amount}",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 3, 126, 139),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:redeem/feature/home_page/log/log_model/log_model.dart';
// import 'package:redeem/feature/home_page/log/log_service/log_service.dart';

// class LogScreen extends StatefulWidget {
//   const LogScreen({super.key});

//   @override
//   State<LogScreen> createState() => _LogScreenState();
// }

// class _LogScreenState extends State<LogScreen> {
//   List<LogModel> logs = [];
//   bool isLoading = true;
//   String? errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _loadLogs();
//   }

//   Future<void> _loadLogs() async {
//     try {
//       final fetchedLogs = await LogService().fetchLogs();
//       setState(() {
//         logs = fetchedLogs;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = e.toString();
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     } else if (errorMessage != null) {
//       return Center(child: Text('Error: $errorMessage'));
//     } else if (logs.isEmpty) {
//       return const Center(child: Text('No logs found.'));
//     } else {
//       return SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children:
//                 logs.map((log) {
//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Points: ${log.points} (${log.pointStatus})',
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(height: 4),
//                           Text('Amount: ${log.amount}'),
//                           Text('Category: ${log.pointCategory}'),
//                           Text('Scheme: ${log.scheme.name}'),
//                           Text('Retailer: ${log.retailer.name}'),
//                           Text('Date: ${log.createdAt}'),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//           ),
//         ),
//       );
//     }
//   }
// }
