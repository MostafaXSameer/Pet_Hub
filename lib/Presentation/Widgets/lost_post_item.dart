import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_hub/Data/Models/lostPostsModel.dart';

import '../../Business_Logic/cupit_app/cubit/app_cubit.dart';
import '../../Business_Logic/posts_cubit/lost_postes_cubit.dart';
import '../../Constants/timeAgo.dart';
import '../../pets_icons_icons.dart';
import '../Screens/LostPost.dart';
import '../Screens/StrangeUserProfile.dart';

class LostPostItem extends StatefulWidget {
  @override
  State<LostPostItem> createState() => _LostPostItemState();
}

class _LostPostItemState extends State<LostPostItem> {
  final bool adaptionHeart = true;

  final bool lostHeart = true;

  final bool hostHeart = true;

  Widget adoptionPost(LostPostData postData, context,int index) => SingleChildScrollView(
    child: BlocConsumer<LostPostesCubit, LostPostesState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    String postid=LostPostesCubit.get(context).postsId[index];
    var contain2 = LostPostesCubit.get(context).likesState.where((element) => element.postId == postid && element.userId==AppCubit.get(context).loggedInUser.id) ;
    Timestamp myTimeStamp = Timestamp.fromDate(postData.postDate!);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 2.0, color: Colors.grey),
        color: Colors.white,
      ),
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
                          builder: (context) =>UserProfile(userId: postData.id)
                          ,
                        ));
                  },
                  child: CircleAvatar(
                    backgroundImage:  postData.profileImage!=null?
                    NetworkImage('${postData.profileImage}'):AssetImage('Images/Group 2.png') as ImageProvider,
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
                              builder: (context) =>UserProfile(userId: postData.id)
                              ,
                            ));
                      },
                      child: Text(
                        '${postData.fullName}',
                        style: TextStyle(
                          color: Colors.blue,
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
                        color: Colors.grey,
                        fontSize: 10,
                        fontStyle: FontStyle.italic
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap:(){
                String postid=LostPostesCubit.get(context).postsId[index];
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LostPost(postdetails: postData,index: index,postId:postid ),
                    ));
              } ,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(width: 2.0, color: Colors.white)),
                height: 300,
                //width: ,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image(
                            image: NetworkImage('${postData.postImage}'),
                            fit: BoxFit.fill,
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black.withOpacity(0.4),
                      ),
                      height: 40,
                      alignment: AlignmentDirectional.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        if(postData.petGander=='Male')
                          Icon(
                            Icons.male_rounded,
                            size: 40,
                            color: Colors.blue,
                          ),
                          if(postData.petGander=='Female')
                            Icon(
                              Icons.female_rounded,
                              size: 40,
                              color: Colors.blue,
                            ),
                          Text(
                            '${postData.petName}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                if(contain2.isNotEmpty)
                  IconButton(
                    icon: Icon(
                        PetsIcons.heart__2_,
                        color: Colors.red),
                    onPressed: () {
                      LostPostesCubit.get(context).dislikeLostPosts(LostPostesCubit.get(context).postsId[index],context);
                      setState(() {
                        LostPostesCubit.get(context).getLostLikes(context);
                      });
                    },
                  ),

                if(contain2.isEmpty)
                  IconButton(
                    icon: Icon(
                        PetsIcons.heart ,
                        color: Colors.red),
                    onPressed: () {
                      LostPostesCubit.get(context).likeLostPosts(LostPostesCubit.get(context).postsId[index],context);
                      setState(() {
                        LostPostesCubit.get(context).getLostLikes(context);
                      });
                    },
                  ),
                if(LostPostesCubit.get(context).map_name[postid]!=null)
                  Text(
                      '${LostPostesCubit.get(context).map_name[postid]}'
                  ),
                IconButton(
                    onPressed: () {
                      String postid=LostPostesCubit.get(context).postsId[index];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LostPost(postdetails: postData,index: index,postId:postid ),
                          ));
                    },
                    icon: Icon(PetsIcons.comment)),
                SizedBox(
                  width: 0,
                ),
                IconButton(
                    onPressed: () {}, icon: Icon(PetsIcons.first_prize)),
                Text('${postData.prize}'),
                SizedBox(
                  width: 0,
                ),
                IconButton(
                    onPressed: () {
                      print('Map Clicked');
                    },
                    icon: Icon(PetsIcons.location)),
                Text('${postData.state}')
              ],
            ),
          )
        ],
      ),
    );
  },
),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LostPostesCubit()..getlostPosts(context)..getLostLikes(context),
      child: BlocConsumer<LostPostesCubit, LostPostesState>(
        listener: (context, state) {},
        builder: (context, state) {
          return LostPostesCubit.get(context).lostPosts.length > 0
              ? Container(
            color: Colors.grey,
            child: ListView.separated(
              itemBuilder: (context, index) => adoptionPost(
                  LostPostesCubit.get(context).lostPosts[index], context,index),
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemCount: LostPostesCubit.get(context).lostPosts.length,
            ),
          )
              : Transform.scale(scale: 0.1, child: CircularProgressIndicator(strokeWidth: 30,));
        },
      ),
    );
  }
}