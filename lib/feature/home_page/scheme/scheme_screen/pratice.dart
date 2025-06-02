// class SchemeDetailScreen extends StatelessWidget {
//   final Scheme scheme;

//   const SchemeDetailScreen({
//     super.key,
//     required this.scheme,
//   });

//   String _formatDate(String dateStr) {
//     try {
//       final date = DateTime.parse(dateStr);
//       return DateFormat('dd MMM yyyy').format(date);
//     } catch (e) {
//       return dateStr; // Return original string if parsing fails
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.colorScheme.surface,
//       appBar: AppBar(
//         title: Text(
//           scheme.name,
//           style: theme.textTheme.titleLarge?.copyWith(
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         backgroundColor: theme.colorScheme.primary,
//         foregroundColor: theme.colorScheme.onPrimary,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Header Card
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               elevation: 4,
//               shadowColor: theme.shadowColor.withOpacity(0.1),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       theme.colorScheme.primary.withOpacity(0.1),
//                       theme.colorScheme.secondary.withOpacity(0.05),
//                     ],
//                   ),
//                 ),
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Scheme Details',
//                       style: theme.textTheme.headlineSmall?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: theme.colorScheme.primary,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Container(
//                       height: 3,
//                       width: 40,
//                       decoration: BoxDecoration(
//                         color: theme.colorScheme.primary,
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),

//             // Details Card
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               elevation: 2,
//               shadowColor: theme.shadowColor.withOpacity(0.1),
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildInfoRow(
//                       context,
//                       icon: Icons.label_outline,
//                       label: "Name",
//                       value: scheme.name,
//                     ),
//                     _buildDivider(),
//                     _buildInfoRow(
//                       context,
//                       icon: Icons.category_outlined,
//                       label: "Type",
//                       value: scheme.type,
//                     ),
//                     _buildDivider(),
//                     _buildInfoRow(
//                       context,
//                       icon: Icons.info_outline,
//                       label: "Status",
//                       value: scheme.status,
//                       statusColor: _getStatusColor(scheme.status, theme),
//                     ),
//                     _buildDivider(),
//                     _buildInfoRow(
//                       context,
//                       icon: Icons.play_arrow_outlined,
//                       label: "Start Date",
//                       value: _formatDate(scheme.start),
//                     ),
//                     _buildDivider(),
//                     _buildInfoRow(
//                       context,
//                       icon: Icons.schedule_outlined,
//                       label: "Deadline",
//                       value: _formatDate(scheme.deadline),
//                     ),
//                     _buildDivider(),
//                     _buildInfoRow(
//                       context,
//                       icon: Icons.account_balance_wallet_outlined,
//                       label: "Default Limit",
//                       value: scheme.defaultLimit,
//                     ),
//                     _buildDivider(),
//                     _buildInfoRow(
//                       context,
//                       icon: Icons.rule_outlined,
//                       label: "Custom Rule Limit",
//                       value: scheme.rule?.limit ?? "Not specified",
//                       isLastItem: true,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required String value,
//     Color? statusColor,
//     bool isLastItem = false,
//   }) {
//     final theme = Theme.of(context);

//     return Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: isLastItem ? 8.0 : 12.0,
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: theme.colorScheme.primary.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(
//               icon,
//               size: 20,
//               color: theme.colorScheme.primary,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: theme.textTheme.bodySmall?.copyWith(
//                     color: theme.colorScheme.onSurface.withOpacity(0.7),
//                     fontWeight: FontWeight.w500,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: theme.textTheme.bodyLarge?.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: statusColor ?? theme.colorScheme.onSurface,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDivider() {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       height: 1,
//       color: Colors.grey.withOpacity(0.2),
//     );
//   }

//   Color _getStatusColor(String status, ThemeData theme) {
//     switch (status.toLowerCase()) {
//       case 'active':
//         return Colors.green;
//       case 'inactive':
//         return Colors.red;
//       case 'pending':
//         return Colors.orange;
//       case 'completed':
//         return Colors.blue;
//       default:
//         return theme.colorScheme.onSurface;
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:redeem/feature/home_page/scheme/scheme_model/scheme_model.dart';
// import 'package:redeem/feature/home_page/scheme/scheme_service/scheme_service.dart';
// import 'package:redeem/widgets/mytext.dart';
// import 'package:shimmer/shimmer.dart';

// class SchemeScreen extends StatefulWidget {
//   const SchemeScreen({super.key});

//   @override
//   State<SchemeScreen> createState() => _SchemeScreenState();
// }

// class _SchemeScreenState extends State<SchemeScreen> {
//   final List<Scheme> _schemes = [];
//   bool _isLoading = true;
//   bool _hasError = false;

//   final List<Color> containerColors = [
//     Colors.lightGreen[400]!,
//     Colors.pink[400]!,
//     Colors.orange[400]!,
//     Colors.teal[400]!,
//   ];

//   final List<Color> containerColors2 = [
//     Colors.lightGreen[200]!,
//     Colors.pink[200]!,
//     Colors.orange[200]!,
//     Colors.teal[200]!,
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _loadSchemes();
//   }

//   void _loadSchemes() async {
//     try {
//       final List<Scheme> result = await SchemeService().fetchSchemes();
//       setState(() {
//         _schemes.addAll(result);
//         _isLoading = false;
//       });
//     } catch (e) {
//       debugPrint('Error fetching schemes: $e');
//       setState(() {
//         _hasError = true;
//         _isLoading = false;
//       });
//     }
//   }

//   Widget _buildShimmerLoader() {
//     return SizedBox(
//       height: 120.h,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 4,
//         itemBuilder: (context, index) {
//           return Container(
//             margin: EdgeInsets.symmetric(horizontal: 5.w),
//             width: 100.w,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//               borderRadius: BorderRadius.circular(20.r),
//             ),
//             child: Shimmer.fromColors(
//               baseColor: Colors.grey.shade300,
//               highlightColor: Colors.grey.shade100,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(height: 10.h, width: 40.w, color: Colors.white),
//                   SizedBox(height: 5.h),
//                   Container(height: 10.h, width: 40.w, color: Colors.white),
//                   SizedBox(height: 5.h),
//                   Container(height: 10.h, width: 20.w, color: Colors.white),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return Center(child: _buildShimmerLoader());
//     }
//     if (_hasError) {
//       return const Center(child: Text('Failed to load schemes.'));
//     }
//     if (_schemes.isEmpty) {
//       return const Center(child: Text('No schemes available.'));
//     }
//     return SizedBox(
//       height: 140.h,
//       child: ListView.builder(
//         padding: EdgeInsets.symmetric(vertical: 10.h),
//         scrollDirection: Axis.horizontal,
//         itemCount: _schemes.length,
//         itemBuilder: (context, index) {
//           final scheme = _schemes[index];

//           // Calculate the percent for progress
//           double percent = 0.0;

//           if (scheme.rule == null) {
//             // If rule is null, directly 100% progress
//             percent = 1.0;
//           } else if (scheme.totalPoints == 0) {
//             // If totalPoints is 0 or null, show 0%
//             percent = 0.0;
//           } else if (scheme.type == "annual" && scheme.totalPoints == 1) {
//             // If type is annual and totalPoints is 1, directly 100%
//             percent = 1.0;
//           } else if (scheme.rule!.limit != "0") {
//             double limit = double.tryParse(scheme.rule!.limit) ?? 1;
//             percent = (scheme.totalPoints / limit);
//             if (percent > 1.0) percent = 1.0; // Cap at 100%
//           } else {
//             percent = 0.0; // If limit is zero, show 0%
//           }

//           // Calculate remaining points
//           String remainingPointsText =
//               scheme.rule != null
//                   ? '${((double.tryParse(scheme.rule!.limit) ?? 0) - scheme.totalPoints).clamp(0, double.infinity).toStringAsFixed(0)} P required'
//                   : 'No limit set';

//           // Calculate days left
//           int daysLeft = 0;
//           try {
//             final deadlineDate = DateTime.parse(scheme.deadline);
//             final now = DateTime.now();
//             daysLeft = deadlineDate.difference(now).inDays;
//           } catch (e) {
//             daysLeft = 0;
//           }

//           return GestureDetector(
//             onTap: () {},
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 5.w),
//               width: 175.w,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     containerColors[index % containerColors.length],
//                     containerColors2[index % containerColors2.length],
//                   ],
//                   begin: Alignment.topRight,
//                   end: Alignment.bottomLeft,
//                 ),
//                 borderRadius: BorderRadius.circular(20.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withAlpha(200),
//                     offset: const Offset(0, 4),
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: 40.h,
//                           width: 35.w,
//                           child: Image.asset('assets/images/coin.png'),
//                         ),
//                         SizedBox(width: 5.w),
//                         Mytext(
//                           text: scheme.totalPoints.toString(),
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           textAlign: TextAlign.center,
//                           color: const Color.fromARGB(255, 99, 46, 191),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 4.h),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10.w),
//                       child: LinearPercentIndicator(
//                         lineHeight: 14.0,
//                         animation: true,
//                         animationDuration: 20,
//                         percent: percent,
//                         center: Text(
//                           "${(percent * 100).toStringAsFixed(1)}%",
//                           style: TextStyle(fontSize: 12.sp),
//                         ),
//                         progressColor: Colors.greenAccent,
//                         backgroundColor: Colors.white,
//                         barRadius: Radius.circular(20.r),
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Mytext(
//                       text: '$remainingPointsText ($daysLeft days left)',
//                       fontSize: 10.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     SizedBox(height: 8.h),
//                     Mytext(
//                       text: scheme.name,
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.bold,
//                       textAlign: TextAlign.center,
//                       color: const Color.fromARGB(255, 29, 98, 32),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
