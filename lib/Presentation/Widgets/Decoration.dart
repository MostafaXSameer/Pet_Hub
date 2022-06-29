import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Decoration extends StatelessWidget {

  final double? border_width;
  final Color? border_color;
  final double? spread_Radius;
  final double? blur_Radius;
  final Offset? offset;
  final BoxShape? shape;
  final Color? Boxshadow_color;
  final Color main_color;

  const Decoration({Key? key,
     this.border_width,
     this.border_color,
     this.spread_Radius,
     this.blur_Radius,
     this.offset,
     this.shape,
     this.Boxshadow_color,
     required this.main_color,



  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: main_color,
        border: Border.all(
            width: border_width!,
            color: border_color!),
        boxShadow: [
          BoxShadow(
              spreadRadius: spread_Radius!,
              blurRadius: blur_Radius!,
              color: Boxshadow_color!,
              offset: offset!)
        ],
        shape: shape!,
      ),

      //   decoration: BoxDecoration(
      //     labelText: 'ConfirmPassword',
      //     labelStyle: TextStyle(
      //       color: Color(0xff23424A),
      //     ),
      //     focusedBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(25.0),
      //       borderSide: BorderSide(
      //         color: Color(0xff23424A),
      //         width: 2.0,
      //       ),
      //     ),
      //     enabledBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(25.0),
      //       borderSide: BorderSide(
      //         color: Color(0xff23424A),
      //         width: 3.0,
      //       ),
      //     ),
      //     prefixIcon: Icon(Icons.lock, color: Color(0xff23424A)),
      //     suffixIcon: IconButton(
      //         onPressed: (){
      //           setState(() {
      //             passwordVisible2=!passwordVisible2;
      //           });
      //         },
      //         icon: Icon(passwordVisible2?Icons.visibility:Icons.visibility_off,color: Color(0xff23424A),))
      // ));
    );
  }
}
