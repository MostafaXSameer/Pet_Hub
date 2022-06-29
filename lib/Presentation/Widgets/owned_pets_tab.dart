import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_hub/Business_Logic/cupit_Owned_pets/owned_pets_cubit.dart';
import 'package:pet_hub/Business_Logic/cupit_Owned_pets/owned_pets_state.dart';
import 'package:pet_hub/Business_Logic/cupit_app/cubit/app_cubit.dart';
import 'package:pet_hub/Data/Models/pets_data.dart';
import 'package:pet_hub/Data/Models/userModel.dart';
import 'package:pet_hub/Presentation/Screens/CreateOwnedPet.dart';
import 'package:pet_hub/Presentation/Screens/OwnedPetDetails.dart';

class OwnedPetsTab extends StatelessWidget {
  final UserData? user;
  OwnedPetsTab({required this.user});
  Widget petsOwnedWidgets(BuildContext context,PetsOwned petsOwned,int index) {
    return Stack(
      alignment:
      AlignmentDirectional.bottomCenter,
      children: [
        InkWell(
          child: Container(
            decoration: BoxDecoration(
              //DecorationImage
              border: Border.all(
                color: Color(0xff23424A)
                    .withOpacity(0.5),
                width: 2,
              ),
              borderRadius:
              BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey
                      .withOpacity(0.5),
                  offset: const Offset(
                    0.5,
                    0.5,
                  ), //Offset
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ),
                BoxShadow(
                  color: Color.fromARGB(
                      250, 243, 243, 243),
                  offset:
                  const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(
                    14.0),
                child: Image(
                  image:petsOwned.petImage!=null?
                  NetworkImage('${petsOwned.petImage}'):AssetImage('Images/Group 2.png') as ImageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          onTap: () async {
            String generatedDeepLink=await AppCubit.get(context).createDynamicLink(petsOwned,OwnedPetsCubit.get(context).petsOwnedIds[index]);
            print(generatedDeepLink);
            Navigator.push(context, MaterialPageRoute(builder: (context) => OwnedPetDetails(petsOwned,generatedDeepLink),));

          }
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(14.0),
            color:
            Colors.black.withOpacity(0.4),
          ),
          height: 40,
          alignment:
          AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Text(
                petsOwned.petName!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return   BlocProvider(create: (BuildContext context) => OwnedPetsCubit()..getOwnedPets(context,user!.id!),
    child: BlocConsumer<OwnedPetsCubit, OwnedPetsState>(
    listener:(context,state){} ,
    builder:(context,state){
      return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color.fromARGB(250, 243, 243, 243),
            borderRadius: BorderRadius.all(
                Radius.circular(15))),
        child:GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          padding: EdgeInsets.all(10),
          physics: ClampingScrollPhysics(),
          itemCount: OwnedPetsCubit.get(context).petsOwned.length+1,
          itemBuilder: (context, index) {
            if(index==OwnedPetsCubit.get(context).petsOwned.length && user!.id==AppCubit.get(context).loggedInUser.id)
              return Stack(
                alignment:
                AlignmentDirectional.bottomCenter,
                children: [
                  InkWell(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        //DecorationImage
                        border: Border.all(
                          color: Color(0xff23424A)
                              .withOpacity(0.5),
                          width: 2,
                        ),
                        borderRadius:
                        BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey
                                .withOpacity(0.5),
                            offset: const Offset(
                              0.5,
                              0.5,
                            ), //Offset
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                          ),
                          BoxShadow(
                            color: Color.fromARGB(
                                250, 243, 243, 243),
                            offset:
                            const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.add,
                        size: 50.0,
                      ),
                    ),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateOwnedPet(),
                        )
                    ),
                  ),
                ],
              );
            if(index!=OwnedPetsCubit.get(context).petsOwned.length)
            return petsOwnedWidgets(context,
                OwnedPetsCubit.get(context).petsOwned[index],index);
            return SizedBox(height: 0,width: 0,);
          },


        ),

      );
    } ,
    ));


  }
}
