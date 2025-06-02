import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mytext extends StatelessWidget {
  final Color color;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final FontStyle fontStyle;
  final TextOverflow? overflow;
  final int? maxLines;
  const Mytext({
    super.key,
    required this.text,
    this.color = Colors.black,
    required this.fontSize,
    required this.fontWeight,
    this.fontStyle = FontStyle.normal,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontStyle: fontStyle,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
