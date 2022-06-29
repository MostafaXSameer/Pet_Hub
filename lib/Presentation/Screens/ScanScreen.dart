
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
class Scanner extends StatefulWidget {
  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
var qrstr="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan"),backgroundColor: Color(0xff23424A),),
      body:Center(
        child: Column(
          children: [
            TextButton(child:Text(qrstr,style: TextStyle(color: Colors.black,fontSize: 20)),onPressed:(){
              launch(qrstr);
            } ),
            SizedBox(height: 20,width: 20,),
            ElevatedButton(onPressed: (){
              scanQr();
            },
                child: Text("Scanner")),
            SizedBox(height: 20,width: 20,),

          ],
        ),
      ),

    ) ;
  }
Future <void>scanQr()async{
  try{
    FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR).then((value){
      setState(() {
        qrstr=value;
      });
    });
  }catch(e){
    setState(() {
      qrstr='unable to read this';
    });
  }
}

}
