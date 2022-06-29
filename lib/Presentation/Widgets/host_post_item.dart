
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pet_hub/Business_Logic/cupit_app/cubit/app_cubit.dart';

import '../../Business_Logic/posts_cubit/hostposts_cubit.dart';
import '../../Constants/timeAgo.dart';
import '../../Data/Models/hostPostModel.dart';
import '../../pets_icons_icons.dart';
import '../Screens/HostPost.dart';
import '../Screens/StrangeUserProfile.dart';



class HostPostItem extends StatefulWidget {
  @override
  State<HostPostItem> createState() => _HostPostItemState();
}

class _HostPostItemState extends State<HostPostItem> {
  final bool adaptionHeart = true;

  final bool lostHeart = true;

  final bool hostHeart = true;

  final DateFormat myFormat = DateFormat('yyyy-MM-dd');

  Widget hostPost(HostPostData postData,context,int index) => SingleChildScrollView(
      child:BlocConsumer<HostpostsCubit, HostpostsState>(
        listener: (context,state){},
        builder: (context,state){
          String postid=HostpostsCubit.get(context).postsId[index];
          var contain = HostpostsCubit.get(context).likesState.where((element) => element.postId == postid && element.userId==AppCubit.get(context).loggedInUser.id) ;
          final difference = postData.endDate?.difference(postData.startDate!).inDays;
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
                          backgroundImage: postData.profileImage!=null?
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
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Icon(Icons.watch_later_outlined),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${difference} Days',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap:(){
                      String postid=HostpostsCubit.get(context).postsId[index];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  HostPost(postdetails: postData,index: index,postId:postid ),
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
                                Icon(
                                  Icons.male_rounded,
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

                      if(contain.isNotEmpty)
                        IconButton(
                          icon: Icon(
                              PetsIcons.heart__2_,

                              color: Colors.red),
                          onPressed: () {
                            HostpostsCubit.get(context).dislikeHostPosts(HostpostsCubit.get(context).postsId[index],context);
                            setState(() {
                              HostpostsCubit.get(context).getHostLikes(context);
                            });
                          },
                        ),

                      if(contain.isEmpty)
                        IconButton(
                          icon: Icon(

                              PetsIcons.heart ,

                              color: Colors.red),

                          onPressed: () {
                            HostpostsCubit.get(context).likeHostPosts(HostpostsCubit.get(context).postsId[index],context);
                            setState(() {

                              HostpostsCubit.get(context).getHostLikes(context);


                            });
                          },
                        ),
                      if(HostpostsCubit.get(context).map_name[postid]!=null)
                        Text(
                            '${HostpostsCubit.get(context).map_name[postid]}'
                        ),
                      IconButton(
                          onPressed: () {
                            String postid=HostpostsCubit.get(context).postsId[index];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HostPost(postdetails: postData,index: index,postId:postid ),
                                ));
                          },
                          icon: Icon(PetsIcons.comment)),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(PetsIcons.pawprint),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${myFormat.format(postData.startDate!).toString()}",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {
                            print('Map Clicked');
                          },
                          icon: Icon(PetsIcons.location)),
                      Expanded(child: Text('${postData.state}', style: TextStyle(fontWeight: FontWeight.w500)))
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
      create: (BuildContext context) => HostpostsCubit()..gethostPosts(context)..getHostLikes(context),
      child: BlocConsumer<HostpostsCubit, HostpostsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return HostpostsCubit.get(context).hostPosts.length > 0
              ? Container(
            color: Colors.grey,
            child: ListView.separated(
              itemBuilder: (context, index) => hostPost(
                  HostpostsCubit.get(context).hostPosts[index], context,index),
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemCount: HostpostsCubit.get(context).hostPosts.length,
            ),
          )
              : Transform.scale(scale: 0.1, child: CircularProgressIndicator(strokeWidth: 30,));
        },
      ),
    );
  }
}