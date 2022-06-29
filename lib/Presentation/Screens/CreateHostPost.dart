import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:intl/intl.dart';
import 'package:pet_hub/Business_Logic/posts_cubit/hostposts_cubit.dart';

List gender = ["Male", "Female"];

class CreateHostPost extends StatefulWidget {
  static const routeName = 'create_host_post';

  @override
  State<CreateHostPost> createState() => _CreateHostPostState();
}

class _CreateHostPostState extends State<CreateHostPost> {
  var _formKeyH = GlobalKey<FormState>();
  var hostAgeValue;
  var hostTypeValue;
  var hostFamilyValue;
  var hostImageFile;
  String hostCountryValue = "";
  String? hostStateValue;
  String? hostCityValue;
  String hostGenderSelected = "";
  var fromHostSelectedDateText = TextEditingController();
  var toHostSelectedDateText = TextEditingController();
  var petNameController = TextEditingController();
  var petAgeController = TextEditingController();
  var postDescriptionController = TextEditingController();
  var rewardController = TextEditingController();
  var moreDetailsController = TextEditingController();
  DateTime? fromHostSelectedDate;
  DateTime? toHostSelectedDate;
  DateTime hostIntialDate = DateTime.now();
  var myFormat = DateFormat('yyyy-MM-dd');

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      hostImageFile = pickedFile!;
    });
    Navigator.pop(context);
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      hostImageFile = pickedFile!;
    });

    Navigator.pop(context);
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose Option",
              style: TextStyle(color: Color(0xff23424A)),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Color(0xff23424A),
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Color(0xff23424A),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(0xff23424A),
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Color(0xff23424A),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          activeColor: Color(0xff23424A),
          value: gender[btnValue],
          groupValue: hostGenderSelected,
          onChanged: (value) {
            setState(() {
              hostGenderSelected = value as String;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  Future<void> _fromSelectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: hostIntialDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2060,1));
    if (picked != null)
      setState(() {
        hostIntialDate = picked;
        fromHostSelectedDate = picked;
      });
  }

  Future<void> _toSelectDate(BuildContext context) async {
    var now2=hostIntialDate.add(Duration(days: 1));
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now2,
        firstDate: now2,
        lastDate: DateTime(2060,1));
    if (picked != null)
      setState(() {
        hostIntialDate = picked;
        toHostSelectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return BlocProvider(
  create: (context) => HostpostsCubit(),
  child: BlocConsumer<HostpostsCubit, HostpostsState>(
  listener: (context, state) {
    // TODO: implement listener

  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff23424A),
        elevation: 0,
        //back button
        leading: SizedBox(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color.fromARGB(250, 243, 243, 243),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        //post button
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
                onPressed: ()  {
                  if (_formKeyH.currentState!.validate()) {
                    if(HostpostsCubit.get(context).hostPosteImage==null){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: new Text("Please Chose A Photo")));
                    }
                   else if(hostStateValue==""){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: new Text("Please Chose Your State")));
                    }
                   else if(hostCityValue==""){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: new Text("Please Chose Your City")));
                    }
                  else if(hostGenderSelected==""){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: new Text("Please Chose Your Pet,s Gander")));
                    }
                    else{
                      var now = DateTime.now();
                      HostpostsCubit.get(context)
                          .uploadhostpostWithImage(
                          petNameController.text,
                          petAgeController.text,
                          hostAgeValue,
                          hostTypeValue,
                          hostFamilyValue,
                          rewardController.text,
                          hostStateValue!,
                          hostCityValue!,
                          moreDetailsController.text,
                          fromHostSelectedDate,
                          toHostSelectedDate,
                          hostGenderSelected,
                          postDescriptionController.text,
                          now.toLocal(),
                           context);}

                  }
                },
                child: Text(
                  "Post",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(250, 243, 243, 243),
                      fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                    return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10));
                  }),
                )),
          ),
        ],
      ),
      body: Container(
        height: screenheight,
        width: screenwidth,
        color: Color.fromARGB(250, 243, 243, 243),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKeyH,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  if (state is CreateHostPostLoadingState)
                    LinearProgressIndicator(),
                  //pic
                  if (HostpostsCubit.get(context).hostPosteImage == null)
                  InkWell(
                    child: Container(
                      width: 150,
                      height: 150,
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
                      child: Icon(
                        Icons.add_a_photo_rounded,
                        size: 50.0,
                      ),
                    ),
                    onTap: () => {HostpostsCubit.get(context).getHostPosteImage()},
                  ),
                  if (HostpostsCubit.get(context).hostPosteImage != null)
                    Stack(children: [
                      Container(
                        width: 130,
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                    HostpostsCubit.get(context)
                                        .hostPosteImage!))),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 80,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Theme.of(context)
                                    .scaffoldBackgroundColor,
                              ),
                              color: Colors.green,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                HostpostsCubit.get(context)
                                    .getHostPosteImage();
                              },
                            ),
                          )),
                    ]),
                  const SizedBox(
                    height: 10,
                  ),
                  //pet name
                  Row(
                    children: <Widget>[
                      Text(
                        "Pet Name: ",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff23424A)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller:petNameController ,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Pet Name is Required';
                              }
                              return null;
                            },
                            cursorColor: Color(0xff23424A),
                            decoration: InputDecoration(
                              hintText: 'Pet Name',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Color(0xff23424A),
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Color(0xff23424A),
                                  width: 3.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //pet age
                  Row(
                    children: <Widget>[
                      Text(
                        "Pet Age: ",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff23424A)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: SizedBox(
                          width: 100,
                          height: 50,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: petAgeController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Pet Age is Required';
                              }
                              return null;
                            },
                            cursorColor: Color(0xff23424A),
                            decoration: InputDecoration(
                              hintText: 'Pet Age',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Color(0xff23424A),
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Color(0xff23424A),
                                  width: 3.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 120,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                                color: Color(0xff23424A),
                                style: BorderStyle.solid,
                                width: 3.0),
                          ),
                          child: DropdownButtonFormField(
                              value: hostAgeValue,
                              items: [
                                DropdownMenuItem(
                                  child: Text("Days"),
                                  value: "Days",
                                ),
                                DropdownMenuItem(
                                  child: Text("Months"),
                                  value: "Months",
                                ),
                                DropdownMenuItem(
                                  child: Text("Years"),
                                  value: "Years",
                                )
                              ],
                              onChanged: (value) {
                                setState(() {
                                  hostAgeValue = value;
                                });
                              },
                              hint: Text(
                                "Days",
                                style: TextStyle(fontSize: 15),
                              ),
                              style: TextStyle(
                                  color: Color(0xff23424A), fontSize: 15),
                              icon: Icon(Icons.arrow_drop_down_circle),
                              iconEnabledColor: Color(0xff23424A),
                              iconSize: 20,
                              isExpanded: true),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //pet type
                  Row(
                    children: <Widget>[
                      Text(
                        "Pet Type: ",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff23424A)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 200,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                                color: Color(0xff23424A),
                                style: BorderStyle.solid,
                                width: 3.0),
                          ),
                          child: DropdownButtonFormField(
                              value: hostTypeValue,
                              items: [
                                DropdownMenuItem(
                                  child: Text("Dog"),
                                  value: "Dog",
                                ),
                                DropdownMenuItem(
                                  child: Text("Cat"),
                                  value: "Cat",
                                ),
                                DropdownMenuItem(
                                  child: Text("Bird"),
                                  value: "Bird",
                                ),
                                DropdownMenuItem(
                                  child: Text("Fish"),
                                  value: "Fish",
                                ),
                                DropdownMenuItem(
                                  child: Text("Other"),
                                  value: "Other",
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  hostTypeValue = value;
                                });
                              },
                              hint: Text("Dog"),
                              style: TextStyle(
                                  color: Color(0xff23424A), fontSize: 15),
                              icon: Icon(Icons.arrow_drop_down_circle),
                              iconEnabledColor: Color(0xff23424A),
                              iconSize: 20,
                              isExpanded: true),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //pet family
                  Row(
                    children: <Widget>[
                      Text(
                        "Pet Family: ",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff23424A)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 200,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                                color: Color(0xff23424A),
                                style: BorderStyle.solid,
                                width: 3.0),
                          ),
                          child: DropdownButtonFormField(
                              value: hostFamilyValue,
                              items: [
                                DropdownMenuItem(
                                  child: Text("A"),
                                  value: "A",
                                ),
                                DropdownMenuItem(
                                  child: Text("B"),
                                  value: "B",
                                ),
                                DropdownMenuItem(
                                  child: Text("C"),
                                  value: "C",
                                ),
                                DropdownMenuItem(
                                  child: Text("D"),
                                  value: "D",
                                ),
                                DropdownMenuItem(
                                  child: Text("E"),
                                  value: "E",
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  hostFamilyValue = value;
                                });
                              },
                              hint: Text("A"),
                              style: TextStyle(
                                  color: Color(0xff23424A), fontSize: 15),
                              icon: Icon(Icons.arrow_drop_down_circle),
                              iconEnabledColor: Color(0xff23424A),
                              iconSize: 20,
                              isExpanded: true),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //wage (reward)
                  Row(
                    children: <Widget>[
                      Text(
                        "Reward: ",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff23424A)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: rewardController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Reward is Required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            cursorColor: Color(0xff23424A),
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.monetization_on_outlined),
                              hintText: 'Reward',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Color(0xff23424A),
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Color(0xff23424A),
                                  width: 3.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Address
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Address: ",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff23424A))),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  //City and state field
                  CSCPicker(
                    showStates: true,
                    showCities: true,
                    flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                    dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color.fromARGB(250, 243, 243, 243),
                        border: Border.all(color: Color(0xff23424A), width: 3)),

                    ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                    disabledDropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color.fromARGB(250, 243, 243, 243),
                        border: Border.all(color: Color(0xff23424A), width: 3)),

                    ///placeholders for dropdown search field
                    countrySearchPlaceholder: "Country",
                    stateSearchPlaceholder: "State",
                    citySearchPlaceholder: "City",

                    ///labels for dropdown
                    countryDropdownLabel: "*Country",
                    stateDropdownLabel: "*State",
                    cityDropdownLabel: "*City",

                    ///Default Country
                    defaultCountry: DefaultCountry.Egypt,

                    ///Disable country dropdown (Note: use it with default country)
                    disableCountry: true,

                    ///selected item style [OPTIONAL PARAMETER]
                    selectedItemStyle: TextStyle(
                      color: Color(0xff23424A),
                      fontSize: 15,
                    ),

                    ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                    dropdownHeadingStyle: TextStyle(
                        color: Color(0xff23424A),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),

                    ///DropdownDialog Item style [OPTIONAL PARAMETER]
                    dropdownItemStyle: TextStyle(
                      color: Color(0xff23424A),
                      fontSize: 15,
                    ),

                    ///Dialog box radius [OPTIONAL PARAMETER]
                    dropdownDialogRadius: 10.0,

                    ///Search bar radius [OPTIONAL PARAMETER]
                    searchBarRadius: 10.0,
                    onCountryChanged: (value) {
                      setState(() {
                        ///store value in country variable
                        hostCountryValue = value;
                      });
                    },

                    ///triggers once state selected in dropdown
                    onStateChanged: (value) {
                      setState(() {
                        ///store value in state variable
                        hostStateValue = value;
                      });
                    },

                    ///triggers once city selected in dropdown
                    onCityChanged: (value) {
                      setState(() {
                        ///store value in city variable
                        hostCityValue = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Address more details
                  SizedBox(
                    child: TextFormField(
                      controller: moreDetailsController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Detailed Address is Required';
                        }
                        return null;
                      },

                      maxLines: null,
                      cursorColor: Color(0xff23424A),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.not_listed_location_sharp),
                        hintText: 'More Details....',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Color(0xff23424A),
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: Color(0xff23424A),
                            width: 3.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Hosting duration
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Hosting Duration: ",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff23424A))),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  //from to
                  Row(
                    children: <Widget>[
                      //from
                      Text("From: ",
                          style: TextStyle(
                              fontSize: 18, color: Color(0xff23424A))),
                      SizedBox(
                        width: 105,
                        height: 50,
                        child: Flexible(
                          child: TextFormField(
                            keyboardType: TextInputType.datetime,
                            controller: fromHostSelectedDateText,
                            decoration: InputDecoration(
                              enabled: false,
                              labelText: fromHostSelectedDate == null
                                  ? "Start Date"
                                  : myFormat.format(fromHostSelectedDate!),
                              labelStyle: TextStyle(
                                color: Color(0xff23424A),
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: Color(0xff23424A), width: 2.0)),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        iconSize: 25.0,
                        icon: const Icon(Icons.calendar_today_outlined),
                        onPressed: () {
                          setState(() {
                            _fromSelectDate(context);
                          });
                        },
                      ),
                      //to
                      Text("To: ",
                          style: TextStyle(
                              fontSize: 18, color: Color(0xff23424A))),
                      SizedBox(
                        width: 105,
                        height: 50,
                        child: Flexible(
                          child: TextFormField(
                            keyboardType: TextInputType.datetime,
                            controller: toHostSelectedDateText,
                            decoration: InputDecoration(
                              enabled: false,
                              labelText: toHostSelectedDate == null
                                  ? "End Date"
                                  : myFormat.format(toHostSelectedDate!),
                              labelStyle: TextStyle(
                                color: Color(0xff23424A),
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: Color(0xff23424A), width: 2.0)),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        iconSize: 25.0,
                        icon: const Icon(Icons.calendar_today_outlined),
                        onPressed: () {
                          setState(() {
                            _toSelectDate(context);
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //gender
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      addRadioButton(0, "Male"),
                      addRadioButton(1, "Female"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //description
                  SizedBox(
                    height: 100,
                    child: TextFormField(
                      controller: postDescriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Description is Required';
                        }
                        return null;
                      },
                      maxLines: null,
                      cursorColor: Color(0xff23424A),
                      decoration: InputDecoration(
                        hintText: 'Description....',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Color(0xff23424A),
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: Color(0xff23424A),
                            width: 3.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
),
);
  }
}
