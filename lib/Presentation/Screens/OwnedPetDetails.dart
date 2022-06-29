import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:pet_hub/Data/Models/pets_data.dart';

class OwnedPetDetails extends StatefulWidget {
  static const routeName = 'owned_pet_details';
  PetsOwned petsOwned = new PetsOwned();
  String link = "";
  OwnedPetDetails(PetsOwned petsOwned, String link) {
    this.link = link;
    this.petsOwned = petsOwned;
  }
  @override
  State<OwnedPetDetails> createState() => _OwnedPetDetailsState();
}

class _OwnedPetDetailsState extends State<OwnedPetDetails> {
  var _formkeyOD = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff23424A),
          elevation: 0,
        ),
        body: Container(
          height: screenheight,
          width: screenwidth,
          alignment: Alignment.center,
          color: Color(0xff23424A),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formkeyOD,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Image(
                      image: widget.petsOwned.petImage != null
                          ? NetworkImage('${widget.petsOwned.petImage}')
                          : AssetImage('Images/Group 2.png') as ImageProvider,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      "Owner Name: ${widget.petsOwned.ownerName}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(250, 243, 243, 243)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Owner Address: ${widget.petsOwned.country}   ${widget.petsOwned.state}   ${widget.petsOwned.city}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(250, 243, 243, 243)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Pet Name:  ${widget.petsOwned.petName}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(250, 243, 243, 243)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Pet Age:  ${widget.petsOwned.petAge}  ${widget.petsOwned.petAgeType}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(250, 243, 243, 243)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Pet Type:  ${widget.petsOwned.petType}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(250, 243, 243, 243)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Pet Family:  ${widget.petsOwned.petFamily}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(250, 243, 243, 243)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Pet Gender:  ${widget.petsOwned.petGander}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(250, 243, 243, 243)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Contact:  ${widget.petsOwned.ownerContact}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(250, 243, 243, 243)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //qr code
                    Container(
                      height: screenwidth - 100,
                      width: screenwidth - 100,
                      decoration: BoxDecoration(
                        //DecorationImage
                        border: Border.all(
                          color: Color(0xff23424A).withOpacity(0.5),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: const Offset(
                              0.5,
                              0.5,
                            ), //Offset
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                          ),
                          BoxShadow(
                            color: Color.fromARGB(250, 243, 243, 243),
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(20),
                          child: BarcodeWidget(
                            data: widget.link,
                            barcode: Barcode.qrCode(),
                            color: Color(0xff23424A),
                            height: double.infinity,
                            width: double.infinity,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
