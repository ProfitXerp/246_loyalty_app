import 'package:flutter/material.dart';
import 'package:redeem/feature/redeem/redeemModel/redeem_model.dart';

class RedeemScreen extends StatefulWidget {
  final int definedPoints;
  final List<Redeem> redemptionData;

  const RedeemScreen({
    super.key,
    required this.definedPoints,
    required this.redemptionData,
  });

  @override
  State<RedeemScreen> createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  List<Item> matchedRewards = [];

  @override
  void initState() {
    super.initState();
    loadRewards();
  }

  void loadRewards() {
    final rewardGroup = widget.redemptionData.firstWhere(
      (group) => int.tryParse(group.points) == widget.definedPoints,
      orElse:
          () => Redeem(
            id: 0,
            points: '0',
            scheme: Scheme(id: 0, name: '', start: '', status: ''),
            items: [],
          ),
    );

    setState(() {
      matchedRewards = rewardGroup.items;
    });
  }

  void bottomSheet(String imageUrl, String name, String description) {
    final screenWidth = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: 450,
          width: screenWidth,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(imageUrl, fit: BoxFit.fill),
                ),
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Redeem Rewards",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body:
            matchedRewards.isEmpty
                ? const Center(child: Text("No rewards available"))
                : ListView.builder(
                  itemCount: matchedRewards.length,
                  itemBuilder: (context, index) {
                    final reward = matchedRewards[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        height: screenHeight * 0.15,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 8,
                            ),
                          ],
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                reward.image,
                                width: screenWidth * 0.34,
                                height: screenHeight * 0.25,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.019),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    reward.item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // TODO: Add redeem logic
                                        },
                                        child: const Text(
                                          'Redeem',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      OutlinedButton(
                                        onPressed:
                                            () => bottomSheet(
                                              reward.image,
                                              reward.item,
                                              reward.description,
                                            ),
                                        child: const Text('More'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
