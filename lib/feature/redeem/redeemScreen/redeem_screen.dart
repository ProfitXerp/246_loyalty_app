import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redeem/feature/redeem/redeemModel/redeem_model.dart';
import 'package:redeem/feature/redeem/redeemScreen/redeem_detail_screen.dart';
import 'package:redeem/feature/redeem/redeemService/redeem_service.dart';

class RedeemScreen extends StatefulWidget {
  const RedeemScreen({super.key});

  @override
  State<RedeemScreen> createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  final RedeemService _redeemService = RedeemService();
  bool isLoading = true;
  List<RedeemModel> redemptionData = [];
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchRedemptionData();
  }

  Future<void> fetchRedemptionData() async {
    try {
      final data = await _redeemService.fetchRedemptionData();
      setState(() {
        redemptionData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : redemptionData.isEmpty
              ? const Center(child: Text('No redeem available'))
              : RefreshIndicator(
                onRefresh: fetchRedemptionData,
                child: SingleChildScrollView(
                  child: Column(
                    children:
                        redemptionData.map((RedeemModel rewardGroup) {
                          final int points =
                              int.tryParse(rewardGroup.points) ?? 0;
                          final List<Item> rewards = rewardGroup.items;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5.h),
                              Container(
                                height: screenHeight * 0.05,
                                width: screenWidth,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.shade50,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.deepPurple.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  "Redeem $points points worth of rewards",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              CarouselSlider(
                                options: CarouselOptions(
                                  autoPlay: false,
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.7,
                                  aspectRatio: 1.6,
                                  initialPage: 0,
                                ),
                                items:
                                    rewards.map<Widget>((Item reward) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      RedeemDetailScreen(
                                                        definedPoints: points,
                                                        redemptionData:
                                                            redemptionData,
                                                      ),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Expanded(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.vertical(
                                                          top: Radius.circular(
                                                            16,
                                                          ),
                                                        ),
                                                    child: Image.network(
                                                      reward.image,
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                          ) => Container(
                                                            color:
                                                                Colors
                                                                    .grey[200],
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons
                                                                    .image_not_supported,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Text(
                                                    reward.item,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                ),
              ),
    );
  }
}
