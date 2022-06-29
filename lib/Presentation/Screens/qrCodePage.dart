import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_hub/Presentation/Screens/CreateOwnedPet.dart';
import 'package:pet_hub/pets_icons_icons.dart';

import 'ScanScreen.dart';

class QrCode extends StatefulWidget {
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Qr Code',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.white,
            fontFamily: 'Doggies Silhouette Font',
          ),
        ),
        backgroundColor: Color(0xff23424A),
        actions: [
          Icon(PetsIcons.notify_),
          SizedBox(width: 10,),
        ],
        elevation: 5,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: false,
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height:200 ,
              width: 200,
              child: ElevatedButton(
                style:ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Color(0xff23424A)),
                ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scanner(),
                      ));
                },
                child: Image(image:AssetImage('Images/scan.png')),
              ),
            ),
            SizedBox(height: 40,),
            Container(
              height: 200,
              width: 200,
              child: ElevatedButton(
                style:ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Color(0xff23424A)),
                ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateOwnedPet(),
                      ));
                },
                child: Image(image:AssetImage('Images/add new pet.png')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
