import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextP extends StatefulWidget {

  //PARAMETROS
  final String title;
  final double? size;
  final Color? color;
  final bool? bold;

  const TextP({super.key,required this.title,this.size,this.color,this.bold});

  @override
  State<TextP> createState() => _TextPState();
}

class _TextPState extends State<TextP> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: GoogleFonts.poppins(
        fontSize: widget.size,
        fontWeight: widget.bold != null && widget.bold! ? FontWeight.bold : FontWeight.normal,
        color: widget.color
      )
    );
  }
}