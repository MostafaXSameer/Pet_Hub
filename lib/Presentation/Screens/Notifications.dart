import 'Package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  static const routeName = 'AdaptionPost';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}



class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    Widget Notify() => Column(
      children:[
        SizedBox(height: 5,),
        Container(

        width: screenwidth-5,
        height: screenheight/9,


        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          color: Color(0xff23424A),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,


        child: Row(
          children: [
            SizedBox(width: 20,),
            Icon(Icons.account_circle_outlined, size: 40,
              color: Colors.white54,),

            SizedBox(width: 10,),

            Text(
              ' user name liked your post.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.white,

              ),
            ),
          ],
        ),

      ),
    ]
    );


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff23424A),
        title: Container(
            width: screenwidth-5,
            height: screenheight/20,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),

            clipBehavior: Clip.antiAliasWithSaveLayer,

            child: Text(
              'Notifications',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'Doggies Silhouette Font',
              ),
            ),


          ),

      ),


        body :
        Container(
          color: Colors.blueGrey,

          child: ListView.separated(
           itemBuilder: (context, index) => Notify(),
           separatorBuilder: (context, index) => SizedBox(
             height: 5,
           ),
           itemCount: 10,
         ),
       )


    );
  }
}
