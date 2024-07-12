// ignore_for_file: unused_import, duplicate_import

import 'package:dementia/appointements/widgets/navbar_roots.dart';
import 'package:dementia/communiy/home_page_comu.dart';
import 'package:dementia/pill_reminder/main.dart';
import 'package:dementia/ui/cust_drop.dart';
import 'package:dementia/ui/custom_app.dart';
import 'package:dementia/ui/disease/dimentia_disease.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

      import 'package:url_launcher/url_launcher.dart';

import '../pages/home.dart';
import '../pill_reminder/noti/main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          _buildHeader(screenHeight),
          _buildPreventionTips(screenHeight),
          _buildYourOwnTest(screenHeight),
          _buildAdditionalSection(screenHeight),
          _buildAnotherSection(screenHeight), // New section 1
          _buildYetAnotherSection(screenHeight), // New section 2
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Welcome ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // CountryDropdown(
                //   countries: ['CN', 'FR', 'IN', 'IT', 'UK', 'USA'],
                //   country: _country,
                //   onChanged: (val) => setState(() => _country = val),
                // ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'How are you feeling today?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'our app just made for you..',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        //backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 0.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.monitor_heart_sharp,
                        color: Colors.white,
                      ),
                      label: Text(
                       'Emergency Contact:',
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 16.0,
                         fontWeight: FontWeight.bold,
                       ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    
                    
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: GestureDetector(
                        onTap: () async {
                          const url = 'tel:<7892499055>';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(color: Colors.red),
                          child: Center(
                            child: Text(
                              "SOS",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                    // TextButton.icon(
                    //   style: TextButton.styleFrom(
                    //     backgroundColor: Colors.blue,
                    //     padding: const EdgeInsets.symmetric(
                    //       vertical: 10.0,
                    //       horizontal: 20.0,
                    //     ),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(30.0),
                    //     ),
                    //   ),
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     Icons.chat_bubble,
                    //     color: Colors.white,
                    //   ),
                    //   label: Text(
                    //     'Send SMS',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 16.0,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
            MaterialPageRoute(builder: (context) => Disease()),
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
              colors: [Color(0xFF51B8EF), Color(0xFF51B8EF)],
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset('images/own_test.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Puzzles',
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
            MaterialPageRoute(builder: (context) => App()),
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
              colors: [Color(0xFF51B8EF), Color(0xFF51B8EF)],
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset('images/pngegg.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Pill Reminder!',
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

  SliverToBoxAdapter _buildAnotherSection(double screenHeight) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: (){ Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );},
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          padding: const EdgeInsets.all(10.0),
          height: screenHeight * 0.15,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF51B8EF), Color(0xFF51B8EF)],
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset('images/com.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ElderEase Community!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Find vaccination centers\nnear you.',
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

  SliverToBoxAdapter _buildYetAnotherSection(double screenHeight) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavBarRoots()),
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
              colors: [Color(0xFF51B8EF), Color(0xFF51B8EF)],
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset('images/mask.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ' Appointement!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Learn how to keep your\ncommunity safe.',
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
