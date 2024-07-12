import 'package:dementia/appointements/screens/appointment_screen1.dart';
import 'package:dementia/appointements/screens/appointment_screen2.dart';
import 'package:dementia/appointements/screens/appointment_screen3.dart';
import 'package:dementia/appointements/screens/appointment_screen4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  List imgs = [
    "doctor1.jpg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
  ];
  final List<String> items = ['temprature rise', 'stomach ache', 'soar throat', 'chest pain'];

  final doctorNames = ['Dr Nagaraju', 'Dr Panda', 'Dr Rahul', 'Dr Satya'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Book your Appointment",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                         onTap: () {
                                final phoneNumber = "tel:+919449372003"; // replace with the actual phone number
                                launchUrl(Uri.parse(phoneNumber),
                                mode: LaunchMode.externalApplication);
                              },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFF0EEFA),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.home_filled,
                                color: Color(0xFF7165D6),
                                size: 35,
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Home Visit      ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Call the doctor    ",
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "What are your symptoms?",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      switch (items[index]) {
                        case 'temprature rise':
                          final link =
                              "https://www.mayoclinic.org/diseases-conditions/fever/symptoms-causes/syc-20352759"
                                  as String;
                          launchUrl(Uri.parse(link),
                              mode: LaunchMode.externalApplication);
                          break;
                        case 'stomach ache':
                          final link =
                              "https://www.mountsinai.org/health-library/symptoms/abdominal-pain#:~:text=Less%20serious%20causes%20of%20abdominal,%2C%20cancer%2C%20and%20gastroesophageal%20reflux."
                                  as String;
                          launchUrl(Uri.parse(link),
                              mode: LaunchMode.externalApplication);
                          break;
                        case 'soar throat':
                          final link =
                              "https://www.healthline.com/health/cold-flu/sore-throat-natural-remedies"
                                  as String;
                          launchUrl(Uri.parse(link),
                              mode: LaunchMode.externalApplication);
                          break;
                        case 'chest pain':
                          final link =
                              "https://www.mayoclinic.org/diseases-conditions/chest-pain/symptoms-causes/syc-20370838"
                                  as String;
                          launchUrl(Uri.parse(link),
                              mode: LaunchMode.externalApplication);
                          break;
                        default:
                          // Default function
                          break;
                      }
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Color(0xFFF4F6FA),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          items[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Top Docs",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: doctorNames.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppointmentScreen1(),
                          ),
                        );
                        break;
                      case 1:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppointmentScreen2(),
                          ),
                        );
                        break;
                      case 2:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppointmentScreen3(),
                          ),
                        );
                        break;
                      case 3:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppointmentScreen4(),
                          ),
                        );
                        break;
                      default:
                        break;
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage("images/${imgs[index]}"),
                        ),
                        Text(
                          doctorNames[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "Therapist",
                          style: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
