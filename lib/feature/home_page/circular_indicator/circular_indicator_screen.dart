import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:redeem/constant/constant.dart' show userPoints;
import 'package:redeem/feature/Login/service/auth_service.dart';

class CircularIndicatorScreen extends StatefulWidget {
  const CircularIndicatorScreen({super.key});

  @override
  State<CircularIndicatorScreen> createState() =>
      _CircularIndicatorScreenState();
}

class _CircularIndicatorScreenState extends State<CircularIndicatorScreen> {
  final AuthService _authService = AuthService();
  // int userPoints = 5;
  final int currentPoints = 500;
  final int finalPoints = 1200;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadUserData();
  // }

  // Future<void> _loadUserData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     userName =
  //         prefs.getString('user_name') ??
  //         'User'; // Fetch user_name or use default

  //     userAddress = prefs.getString('user_address') ?? 'Address';
  //     userPoints = prefs.getString('user_total_points') ?? "error user points";
  //     userPhone = prefs.getString('user_phone') ?? "error user phone number";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 20.0,
              animation: true,
              // percent: (userPoints / finalPoints).clamp(0.0, 1.0),
              percent: currentPoints / finalPoints,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$userPoints",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: const Color.fromARGB(255, 184, 48, 148),
                    ),
                  ),
                  Text('points', style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 4, 0),
                    height: 20,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 225, 198, 248),
                        ),
                      ],
                    ),
                    child: Text('Target: 1200'),
                  ),
                ],
              ),
              footer: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Sales this week",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
