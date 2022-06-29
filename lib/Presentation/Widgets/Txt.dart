

import 'package:flutter/cupertino.dart';

class Txt extends StatelessWidget {
  final String txt;
  final double? size;
  final FontWeight? weight;
  final String? family;
  final FontStyle? style;
  final TextAlign? alignn;
  final Color? color;


  const Txt({Key? key,
    required this.txt,
     this.size,
     this.weight,
    this.family,
    this.style,
    this.alignn,
     this.color,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      textAlign: alignn ,
      style: TextStyle(fontFamily: family , fontSize: size , fontStyle: style , fontWeight: weight, color: color) ,



    );
  }
}
