import 'package:dementia/game/main.dart';
import 'package:dementia/pages/home.dart';
import 'package:dementia/pill_reminder/main.dart';
import 'package:dementia/ui/cust_drop.dart';
import 'package:dementia/ui/custom_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Disease extends StatefulWidget {
  @override
  _DiseaseState createState() => _DiseaseState();
}

class _DiseaseState extends State<Disease> {
  String _country = 'USA';
  List<Map<String, String>> prevention = [
    {
      'images/wash_hands.png': 'Wash Hands',
    },
    {
      'images/wear_mask.png': 'Wear Mask',
    },
    {
      'images/social_distance.png': 'Social Distance',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          // _buildHeader(screenHeight),
          _buildPreventionTips(screenHeight),
          _buildYourOwnTest(screenHeight),
          _buildAdditionalSection(screenHeight),
        ],
      ),
    );
  }

  // SliverToBoxAdapter _buildHeader(double screenHeight) {
  //   return SliverToBoxAdapter(
  //     child: Container(
  //       padding: const EdgeInsets.all(20.0),
  //       decoration: BoxDecoration(
  //         color: Colors.blue,
  //         borderRadius: BorderRadius.only(
  //           bottomLeft: Radius.circular(40.0),
  //           bottomRight: Radius.circular(40.0),
  //         ),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Text(
  //                 'Welcome Name!',
  //                 style: const TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 25.0,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               // CountryDropdown(
  //               //   countries: ['CN', 'FR', 'IN', 'IT', 'UK', 'USA'],
  //               //   country: _country,
  //               //   onChanged: (val) => setState(() => _country = val),
  //               // ),
  //             ],
  //           ),
  //           SizedBox(height: screenHeight * 0.03),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Text(
  //                 '!!!!!!!!!!',
  //                 style: const TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 22.0,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //               SizedBox(height: screenHeight * 0.01),
  //               Text(
  //                 '!!!!!!!!!!!!!!!!',
  //                 style: const TextStyle(
  //                   color: Colors.white70,
  //                   fontSize: 15.0,
  //                 ),
  //               ),
  //               SizedBox(height: screenHeight * 0.03),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   TextButton.icon(
  //                     style: TextButton.styleFrom(
  //                       backgroundColor: Colors.red,
  //                       padding: const EdgeInsets.symmetric(
  //                         vertical: 10.0,
  //                         horizontal: 20.0,
  //                       ),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(30.0),
  //                       ),
  //                     ),
  //                     onPressed: () {},
  //                     icon: const Icon(
  //                       Icons.phone,
  //                       color: Colors.white,
  //                     ),
  //                     label: Text(
  //                       'Call Now',
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 16.0,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(width: 10.0),
  //                   ClipRRect(
  //                     borderRadius: BorderRadius.circular(100.0),
  //                     child: Container(
  //                       width: 120,
  //                       height: 95,
  //                       decoration: BoxDecoration(color: Colors.red),
  //                       child: Center(
  //                         child: Text(
  //                           "SOS",
  //                           style: TextStyle(
  //                               fontSize: 25,
  //                               color: Colors.white,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                     ),
  //                   )
  //                   // TextButton.icon(
  //                   //   style: TextButton.styleFrom(
  //                   //     backgroundColor: Colors.blue,
  //                   //     padding: const EdgeInsets.symmetric(
  //                   //       vertical: 10.0,
  //                   //       horizontal: 20.0,
  //                   //     ),
  //                   //     shape: RoundedRectangleBorder(
  //                   //       borderRadius: BorderRadius.circular(30.0),
  //                   //     ),
  //                   //   ),
  //                   //   onPressed: () {},
  //                   //   icon: const Icon(
  //                   //     Icons.chat_bubble,
  //                   //     color: Colors.white,
  //                   //   ),
  //                   //   label: Text(
  //                   //     'Send SMS',
  //                   //     style: TextStyle(
  //                   //       color: Colors.white,
  //                   //       fontSize: 16.0,
  //                   //       fontWeight: FontWeight.bold,
  //                   //     ),
  //                   //   ),
  //                   // ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  

  SliverToBoxAdapter _buildPreventionTips(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildYourOwnTest(double screenHeight) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Game()),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          padding: const EdgeInsets.all(10.0),
          height: screenHeight * 0.15,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFAD9FE4), Color(0xFFAD9FE4)],
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset('images/jm.jpg'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Memory Games',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Follow the instructions\nto do your own test.',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildAdditionalSection(double screenHeight) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          padding: const EdgeInsets.all(10.0),
          height: screenHeight * 0.15,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF76c7c0), Color(0xFF76c7c0)],
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset('images/jk.jpg',
              width: 100,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Dementia Training',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Get the latest updates\nand information.',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
