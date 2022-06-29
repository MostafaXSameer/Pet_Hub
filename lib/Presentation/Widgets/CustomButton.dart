import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String inputText;
  final double fontSize;
  final double padd;
  final Function Navigation;
  final double width;

   CustomButton({ required this.inputText, required this.fontSize, required this.Navigation, required this.padd, required this.width});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padd),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Color(0xff23424A),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,

        child: MaterialButton(

          onPressed: () {
           Navigation();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
                inputText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                  color: Colors.white,
                ),
              ),
          ),
          ),
        ),
    );
  }
}
