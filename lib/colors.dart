import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class colorText extends StatefulWidget {
  final double font;
  final String text;
  final List<Color> colors;
  colorText({Key? key,required this.font,required this.text,required this.colors}) : super(key: key);

  @override
  State<colorText> createState() => _colorTextState();
}

class _colorTextState extends State<colorText> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect)=>LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: widget.colors,
      ).createShader(rect),
      child: Text(widget.text,style:GoogleFonts.aBeeZee(fontSize:widget.font,color:Colors.white,) ),
    );
  }
}