import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redeem/widgets/mytext.dart';

class SegmentedButtonScreen extends StatefulWidget {
  const SegmentedButtonScreen({super.key});

  @override
  State<SegmentedButtonScreen> createState() => _SegmentedButtonScreenState();
}

class _SegmentedButtonScreenState extends State<SegmentedButtonScreen> {
  int selectedIndex = 0;
  final List<String> segmentButton = ['All', 'Annual', 'scheme'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          height: 50,
          width: 370,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[200],
          ),
          child: Row(
            children: List.generate(segmentButton.length, (index) {
              bool isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    // border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(20),
                    color:
                        isSelected
                            ? Color.fromARGB(247, 3, 198, 9)
                            : Colors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 34.5.w),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 3.5,
                        ),
                        child: Mytext(
                          text: segmentButton[index],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: IndexedStack(
            index: selectedIndex,
            children: [AllPage(), AnnualPage(), SchemePage()],
          ),
        ),
      ],
    );
  }
}

class AllPage extends StatelessWidget {
  const AllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('All Page'));
  }
}

class AnnualPage extends StatelessWidget {
  const AnnualPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Annual Page'));
  }
}

class SchemePage extends StatelessWidget {
  const SchemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
