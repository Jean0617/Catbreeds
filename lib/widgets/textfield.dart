import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldP extends StatefulWidget {

  //PARAMTROS
  final String title;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onPressed;

  const TextFieldP({super.key,required this.title,required this.controller,required this.onChanged,required this.onPressed});

  @override
  State<TextFieldP> createState() => _TextFieldPState();
}

class _TextFieldPState extends State<TextFieldP> {
  
  final buscarC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.title,
        filled: true,
        fillColor: Colors.white,
        hintStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.bold
          )
        ),
        suffixIcon: IconButton(
          hoverColor: Colors.transparent,
          tooltip: widget.title,
          onPressed: widget.onPressed,
          icon: const Icon(Icons.search,color: Colors.orange)
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.black12,width: 2),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.black26,width: 2),
        ),
      ),
    );
  }
}