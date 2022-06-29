import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pet_hub/Business_Logic/cubit_sign_up/sign_up_cubit.dart';
import 'package:pet_hub/Business_Logic/cupit_app/cubit/app_cubit.dart';
import 'package:pet_hub/Constants/strings.dart';
import 'package:pet_hub/Presentation/Screens/verficationPage.dart';
import 'package:pet_hub/Presentation/Widgets/CustomButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Sign_in.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  static const routeName = 'sign_up';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  List gender = ["Male", "Female"];
  var myFormat = DateFormat('yyyy-MM-dd');
  var formKey2 = GlobalKey<FormState>();
  var nameUser = TextEditingController();
  var phoneUser = TextEditingController();
  var emUser = TextEditingController();
  var passWordController = TextEditingController();
  var passWordController2 = TextEditingController();
  var selectedDateText = TextEditingController();
  DateTime? selectedDate;
  DateTime intialDate = DateTime(1950, 1, 1);
  bool isPressed = false;
  String genderSelected = "";
  String countryValue = "";
  String? stateValue;
  String? cityValue;
  String address = "";
  static const pattern = r'^01[0125][0-9]{8}$';

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          activeColor: Color(0xff23424A),
          value: gender[btnValue],
          groupValue: genderSelected,
          onChanged: (value) {
            setState(() {
              genderSelected = value as String;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: intialDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime.now());
    if (picked != null)
      setState(() {
        intialDate = picked;
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) async {
          if(state is CreateUserSuccess)
            {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('uId',state.uId);
              uId = prefs.getString('uId');
              await AppCubit.get(context).getUserData();
              Navigator.of(context).pushNamedAndRemoveUntil(Verification.routeName, (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("Account created Successfully")));
            }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: screenwidth,
              height: screenheight,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Image(
                          image: AssetImage('Images/Group 2.png'),
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'PetHub',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: Color(0xff23424A),
                            fontFamily: 'Doggies Silhouette Font',
                          ),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        //name field
                        TextFormField(
                          controller: nameUser,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Full Name is Required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Full Name',
                              labelStyle: TextStyle(
                                color: Color(0xff23424A),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Color(0xff23424A),
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Color(0xff23424A),
                                  width: 3.0,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.border_color,
                                color: Color(0xff23424A),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //email address field
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emUser,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is Required';
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please Enter a valid email");
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Email Address',
                              labelStyle: TextStyle(
                                color: Color(0xff23424A),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Color(0xff23424A),
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Color(0xff23424A),
                                  width: 3.0,
                                ),
                              ),
                              prefixIcon:
                                  Icon(Icons.email, color: Color(0xff23424A))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //phone  number field
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneUser,
                          onSaved: (value) {
                            phoneUser.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone Number is Required';
                            }
                            if (!RegExp(pattern).hasMatch(value)) {
                              return ("Please Enter a valid Phone number starts "
                                  "with 01");
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(
                                color: Color(0xff23424A),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Color(0xff23424A),
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Color(0xff23424A),
                                  width: 3.0,
                                ),
                              ),
                              prefixIcon:
                                  Icon(Icons.call, color: Color(0xff23424A))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //password field
                        TextFormField(
                          obscureText: true,
                          controller: passWordController,
                          onSaved: (value) {
                            passWordController.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is Required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Color(0xff23424A),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Color(0xff23424A),
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Color(0xff23424A),
                                width: 3.0,
                              ),
                            ),
                            prefixIcon:
                                Icon(Icons.lock, color: Color(0xff23424A)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //Confirm password field
                        TextFormField(
                          obscureText: true,
                          controller: passWordController2,
                          onSaved: (value) {
                            passWordController2.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Confirm password is Required';
                            }
                            if (value != passWordController.text) {
                              return 'Password dosn,t Match';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'ConfirmPassword',
                            labelStyle: TextStyle(
                              color: Color(0xff23424A),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Color(0xff23424A),
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Color(0xff23424A),
                                width: 3.0,
                              ),
                            ),
                            prefixIcon:
                                Icon(Icons.lock, color: Color(0xff23424A)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //datefield
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
                                keyboardType: TextInputType.datetime,
                                controller: selectedDateText,
                                decoration: InputDecoration(
                                  enabled: false,
                                  labelText: selectedDate == null
                                      ? "Birth Date"
                                      : myFormat.format(selectedDate!),
                                  labelStyle: TextStyle(
                                    color: Color(0xff23424A),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Color(0xff23424A),
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Color(0xff23424A),
                                      width: 3.0,
                                    ),
                                  ),
                                  prefixIcon: Icon(Icons.cake,
                                      color: Color(0xff23424A)),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.calendar_today_outlined),
                              onPressed: () {
                                setState(() {
                                  _selectDate(context);
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //City and state field
                        CSCPicker(
                          showStates: true,
                          showCities: true,
                          flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                          dropdownDecoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(0xff23424A), width: 2)),

                          ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                          disabledDropdownDecoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(0xff23424A), width: 2)),

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
                            color: Colors.black,
                            fontSize: 14,
                          ),

                          ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                          dropdownHeadingStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),

                          ///DropdownDialog Item style [OPTIONAL PARAMETER]
                          dropdownItemStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),

                          ///Dialog box radius [OPTIONAL PARAMETER]
                          dropdownDialogRadius: 10.0,

                          ///Search bar radius [OPTIONAL PARAMETER]
                          searchBarRadius: 10.0,
                          onCountryChanged: (value) {
                            setState(() {
                              ///store value in country variable
                              countryValue = value;
                            });
                          },

                          ///triggers once state selected in dropdown
                          onStateChanged: (value) {
                            setState(() {
                              ///store value in state variable
                              stateValue = value;
                            });
                          },

                          ///triggers once city selected in dropdown
                          onCityChanged: (value) {
                            setState(() {
                              ///store value in city variable
                              cityValue = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //gender pick radios
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            addRadioButton(0, "Male"),
                            addRadioButton(1, "Female"),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //sign up buttons
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0xff23424A),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: state is SignUpLoading || state is SignUpSuccess
                                ? loadingButton()
                                : buildMaterialButton(context),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'already have account ?',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(SignIn.routeName);
                              },
                              child: Text(
                                'SignIn',
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xff23424A)),
                              ),
                            ),
                          ],
                        )
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

  CustomButton buildMaterialButton(BuildContext ctx) {
    return CustomButton(inputText: 'Done', fontSize: 30, Navigation: () {
      SignUpCubit.get(ctx).loading();
      if (infoFilled(genderSelected, stateValue, cityValue)) {
        SignUpCubit.get(ctx).signUp(
            emUser.text,
            passWordController.text,
            context,
            nameUser.text,
            phoneUser.text,
            selectedDate!,
            cityValue!,
            stateValue!,
            genderSelected);
      } else
        SignUpCubit.get(ctx).error();
    }, padd: 0, width: double.infinity,);
  }

  SpinKitWave loadingButton() {
    return SpinKitWave(
      color: Colors.white,
      size: 30.0,
    );
  }

  bool infoFilled(String gender, String? state, String? city) {
    DateTime avaliableDate = DateTime(
        DateTime.now().year - 10, DateTime.now().month, DateTime.now().day);

    if (!formKey2.currentState!.validate()) {
      return false;
    }

    if (selectedDate == null) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("Please Pick your Birth Date"),backgroundColor: Colors.red,));
      return false;
    }
    if (selectedDate!.compareTo(avaliableDate) > 0) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("You must be +10 years "),backgroundColor: Colors.red,));
      return false;
    }
    if (state == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("Please Pick the State"),backgroundColor: Colors.red,));
      return false;
    }
    if (city == null) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("Please Pick the City"),backgroundColor: Colors.red,));

      return false;
    }
    if (gender == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("Please Pick your Gender"),backgroundColor: Colors.red,));

      return false;
    }

    return true;
  }
}
