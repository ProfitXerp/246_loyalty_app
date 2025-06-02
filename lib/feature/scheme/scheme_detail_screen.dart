import 'package:flutter/material.dart';

class SchemeDetailScreen extends StatelessWidget {
  final String schemeName;
  final String schemeNum;

  const SchemeDetailScreen({
    super.key,
    required this.schemeName,
    required this.schemeNum,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(schemeName)),
      body: Center(child: Text('Scheme Number: $schemeNum')),
    );
  }
}
