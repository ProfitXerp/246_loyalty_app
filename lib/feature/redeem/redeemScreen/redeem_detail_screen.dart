import 'package:flutter/material.dart';
import 'package:redeem/feature/redeem/redeemModel/redeem_model.dart';

class RedeemDetailScreen extends StatefulWidget {
  final int definedPoints;
  final List<RedeemModel> redemptionData;

  const RedeemDetailScreen({
    super.key,
    required this.definedPoints,
    required this.redemptionData,
  });

  @override
  State<RedeemDetailScreen> createState() => _RedeemDetailScreenState();
}

class _RedeemDetailScreenState extends State<RedeemDetailScreen> {
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
          () => RedeemModel(
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

  void showRewardDetailBottomSheet(
    String imageUrl,
    String name,
    String description,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: 450,
          width: screenWidth,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  height: 200,
                  width: screenWidth,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(description, style: const TextStyle(fontSize: 16)),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Redeem Rewards",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
        body:
            matchedRewards.isEmpty
                ? const Center(child: Text("No rewards available"))
                : ListView.builder(
                  itemCount: matchedRewards.length,
                  itemBuilder: (context, index) {
                    final reward = matchedRewards[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 8,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              child: Image.network(
                                reward.image,
                                width: screenWidth * 0.35,
                                height: screenHeight * 0.15,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      reward.item,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            // Add redeem logic here
                                          },
                                          child: const Text("Redeem"),
                                        ),
                                        const SizedBox(width: 8),
                                        OutlinedButton(
                                          onPressed:
                                              () => showRewardDetailBottomSheet(
                                                reward.image,
                                                reward.item,
                                                reward.description,
                                              ),
                                          child: const Text("More"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
