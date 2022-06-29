import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_hub/Data/Models/comments.dart';

import '../../Business_Logic/cupit_app/cubit/app_cubit.dart';
import '../../Business_Logic/posts_cubit/adaption_postes_cubit.dart';
import '../../Constants/timeAgo.dart';
import '../../Data/Models/adaptionPostModel.dart';
import '../../pets_icons_icons.dart';
import 'StrangeUserProfile.dart';

class AdaptionPost extends StatefulWidget {
  static const routeName = 'AdaptionPost';
 final AdaptionPostData postdetails;
 final int index;
  final String postId;

  const AdaptionPost({Key? key, required this.postdetails, required this.index, required this.postId}) : super(key: key);
  @override
  State<AdaptionPost> createState() => _AdaptionPostState();
}

class _AdaptionPostState extends State<AdaptionPost> {
  bool isReadMore = false;
  var userComment = TextEditingController();
  //var formKey=GlobalKey<FormState>();
  Widget buildText(String text) {
    final lines = isReadMore ? null : 6;
    return Text(
      text,
      maxLines: lines,
      overflow: isReadMore ? TextOverflow.visible : TextOverflow.ellipsis,
      style: TextStyle(
        color: Color(0xff23424a),
        fontSize: 15,
      ),
    );
  }
  Widget comment(Comments comment, BuildContext context) => BlocConsumer<AdaptionPostesCubit, AdaptionPostesState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    Timestamp myTimeStamp = Timestamp.fromDate(comment.commentDate!);

    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
          //color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>UserProfile(userId: widget.postdetails.id)
                        ,
                      ));
                },
                child: CircleAvatar(
                  backgroundImage: comment.ProfileImage!=null?
                  NetworkImage('${comment.ProfileImage}'):AssetImage('Images/Group 2.png') as ImageProvider,
                  backgroundColor: Colors.white,
                  radius: 20,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>UserProfile(userId: widget.postdetails.id)
                                  ,
                                ));
                          },
                          child: Text(
                            '${comment.fullName}',
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 130,
                        ),
                        Text(
                          '${TimeAgo.timeago(myTimeStamp.millisecondsSinceEpoch)}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontStyle: FontStyle.italic
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 5),
                    Column(
                      children: [
                        Text(
                          '${comment.commentDescription}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
  },
);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AdaptionPostesCubit()..getAdaptionPosts(context)..getComments(widget.postId)..getAdaptionLikes(context),
  child: BlocConsumer<AdaptionPostesCubit, AdaptionPostesState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    String postid=widget.postId;
    var contain = AdaptionPostesCubit.get(context).likesState.where((element) => element.postId == postid && element.userId==AppCubit.get(context).loggedInUser.id) ;
    Timestamp myTimeStamp = Timestamp.fromDate(widget.postdetails.postDate!);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Adoption',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.white,
              fontFamily: 'Doggies Silhouette Font',
            ),
          ),
          backgroundColor: Color(0xff23424A),
          elevation: 5,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>UserProfile(userId: widget.postdetails.id)
                              ,
                            ));
                      },
                      child: CircleAvatar(
                        backgroundImage:  widget.postdetails.profileImage!=null?
                        NetworkImage('${widget.postdetails.profileImage}'):AssetImage('Images/Group 2.png') as ImageProvider,
                        backgroundColor: Colors.white,
                        radius: 25,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>UserProfile(userId: widget.postdetails.id)
                                  ,
                                ));
                          },
                          child: Text(
                            '${widget.postdetails.fullName }',
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                            '${TimeAgo.timeago(myTimeStamp.millisecondsSinceEpoch)}',
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 10,
                            fontStyle: FontStyle.italic
                          ),
                           
                        )
                      ],
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    if(contain.isNotEmpty)
                      IconButton(
                        icon: Icon(
                            PetsIcons.heart__2_,

                            color: Colors.red),

                        onPressed: () {
                          AdaptionPostesCubit.get(context).dislikeAdaptionPosts(widget.postId,context);
                          setState(() {

                            AdaptionPostesCubit.get(context).getAdaptionLikes(context);
                            // AdaptionPostesCubit.get(context).map_name2[postid]=true;

                          });
                        },
                      ),

                    if(contain.isEmpty)
                      IconButton(
                        icon: Icon(

                            PetsIcons.heart ,

                            color: Colors.red),

                        onPressed: () {
                          AdaptionPostesCubit.get(context).likeAdaptionPosts(widget.postId,context);
                          setState(() {

                            AdaptionPostesCubit.get(context).getAdaptionLikes(context);


                          });
                        },
                      ),
                    if(AdaptionPostesCubit.get(context).map_name[postid]!=null)
                      Text(
                          '${AdaptionPostesCubit.get(context).map_name[postid]}'
                      ),
                  ],
                ),
              ),
              Container(
                child: Image(
                  image: NetworkImage('${widget.postdetails.postImage }'),
                  //fit: BoxFit.fill,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  color: Color(0xff65a9a6),
                ),
                height: 50,
                alignment: AlignmentDirectional.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.postdetails.petName }',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Table(
                columnWidths: {0: FixedColumnWidth(120), 1: FlexColumnWidth(1)},
                border: TableBorder(
                    horizontalInside: BorderSide(width: 1, color: Colors.grey)),
                children: [
                  TableRow(children: [
                    Column(children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        width: double.infinity,
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          '${widget.postdetails.petType }',
                          style: TextStyle(
                            color: Color(0xff23424A),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                    Container(
                      height: 50,
                      width: double.infinity,
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        '${widget.postdetails.petFamily }',
                        style: TextStyle(
                            color: Color(0xff23424A),
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        width: double.infinity,
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          'Gender',
                          style: TextStyle(
                            color: Color(0xff23424A),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                    Container(
                      height: 50,
                      width: double.infinity,
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        '${widget.postdetails.petGander }',
                        style: TextStyle(
                            color: Color(0xff23424A),
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        width: double.infinity,
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          'Age',
                          style: TextStyle(
                            color: Color(0xff23424A),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                    Container(
                      height: 50,
                      width: double.infinity,
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        '${widget.postdetails.petAge }'+'  ${widget.postdetails.petAgeType}',
                        style: TextStyle(
                            color: Color(0xff23424A),
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        width: double.infinity,
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          'Location',
                          style: TextStyle(
                            color: Color(0xff23424A),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                    Container(
                      height: 50,
                      width: double.infinity,
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        '${widget.postdetails.city }'+'   ${widget.postdetails.state }',
                        style: TextStyle(
                            color: Color(0xff23424A),
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  ]),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    buildText(
                      '${widget.postdetails.postDescription }',
                    ),
                    !isReadMore && (widget.postdetails.postDescription!.length > 100)
                        ? Container(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isReadMore = !isReadMore;
                          });
                        },
                        child: Text(
                          (isReadMore ? 'Read Less' : 'Read More'),
                          style: TextStyle(
                              color: Color(0xff23424a),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: isReadMore
                              ? Colors.grey.withOpacity(0.1)
                              : Colors.grey.withOpacity(0.1),
                          padding: isReadMore
                              ? const EdgeInsets.symmetric(vertical: 50)
                              : const EdgeInsets.symmetric(vertical: -20),
                        ),
                      ),
                    )
                        : SizedBox(
                      width: 0,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 300,
                ),
                child: ListView.separated(
                    itemBuilder: (context, index) => comment(
                        AdaptionPostesCubit.get(context).comments[index],context
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 1,
                    ),
                    itemCount:  AdaptionPostesCubit.get(context).comments.length),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: userComment,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Type Comment ......',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          /*border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey,width: 1)
                        )*/
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          var now = DateTime.now();
                          AdaptionPostesCubit.get(context).addComment(
                              widget.postId,
                              userComment.text,
                              now.toLocal(),
                              context);
                          userComment.clear();
                        },
                        child: Icon(Icons.arrow_forward_ios_rounded),
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  },
),
);
  }
}
