import 'package:flutter/material.dart';
import 'package:redeem/widgets/mytext.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Mytext(
          text: "Notification Screen",
          fontSize: 24,
          fontWeight: FontWeight.normal,
        ),
        centerTitle: true,
      ),
      body: Column(),
    );
  }
}
