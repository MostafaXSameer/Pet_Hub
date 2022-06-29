import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_hub/Business_Logic/cupit_app/cubit/app_cubit.dart';
import 'package:pet_hub/Data/Models/userModel.dart';

import '../../Data/Models/MessageModel.dart';

class ChatInside extends StatefulWidget {

  final UserData? strangeuser;

  ChatInside({
    required this.strangeuser,
});

  static const routeName = 'chatInside';
  @override
  State<ChatInside> createState() => _ChatInsideState();
}

class _ChatInsideState extends State<ChatInside> {
  @override
  var messagecontentcontroller =TextEditingController();
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getMessages(receiverId: widget.strangeuser!.id!);
        return BlocConsumer<AppCubit,AppState>(
          listener: (context, state) {},
          builder: (context,state){
            return Scaffold(
              appBar:AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: widget.strangeuser!.profileImage!=null?
                      NetworkImage('${widget.strangeuser!.profileImage!}'):AssetImage('Images/Group 2.png') as ImageProvider,
                      backgroundColor: Colors.white,
                      radius: 20,
                    ),
                    SizedBox(width: 20),
                    Text(
                      '${widget.strangeuser!.fullName!} ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                centerTitle: true,
                backgroundColor: Color(0xff23424A),
                systemOverlayStyle: SystemUiOverlayStyle.dark,
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index){
                            var message =AppCubit.get(context).messages[index];
                            if(AppCubit.get(context).loggedInUser.id==message.senderId)
                            {
                              return buildMyMessage(message);
                            }
                            else
                            {
                              return buildMessage(message);
                            }
                          },
                          separatorBuilder: (context, index) => SizedBox(height: 10,),
                          itemCount: AppCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        child: Container(
                          clipBehavior:Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xff23424A),
                                  width: 3.0
                              ),
                              borderRadius: BorderRadius.circular(16.0)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 10,),
                              Expanded(
                                child: TextFormField(
                                  controller: messagecontentcontroller,
                                  onChanged: (value) {
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Massage',
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  AppCubit.get(context).sendMessage(
                                      receiverId: widget.strangeuser!.id!,
                                      dateTime: DateTime.now().toString(),
                                      text: messagecontentcontroller.text);
                                  messagecontentcontroller.clear();
                                },
                                child: Text(
                                  'send',
                                  style: TextStyle(
                                    color: Color(0xff23424A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }

  Widget buildMessage (MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Column(
      children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(8.0),
                  topStart: Radius.circular(8.0),
                  topEnd: Radius.circular(8.0),
                )
            ),
            padding: EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            child: Text('${model.text}',style:TextStyle(fontWeight: FontWeight.w500,color: Colors.black),)),
      ],
    ),
  );

  Widget buildMyMessage (MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Column(
      children: [
        Container(
            decoration: BoxDecoration(
                color: Color(0xff23424A),
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(8.0),
                  topStart: Radius.circular(8.0),
                  topEnd: Radius.circular(8.0),
                )
            ),
            padding: EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            child: Text('${model.text}',style:TextStyle(fontWeight: FontWeight.w500,color: Colors.white),)),
      ],
    ),
  );
}
