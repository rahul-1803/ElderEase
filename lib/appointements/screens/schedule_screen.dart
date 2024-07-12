import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dementia/appointements/widgets/upcoming_schedule.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting


class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final int _buttonIndex = 0;

  final _scheduleWidgets = [
    UpcomingSchedule(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Appointments'),
        backgroundColor: const Color.fromARGB(255, 188, 192, 212),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(30),
        //   ),
        // ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('appointments').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No appointments found'));
              }

              // Sort the documents based on date and time
              List<DocumentSnapshot> sortedDocs = snapshot.data!.docs;
              sortedDocs.sort((a, b) {
                Map<String, dynamic> dataA = a.data() as Map<String, dynamic>;
                Map<String, dynamic> dataB = b.data() as Map<String, dynamic>;

                DateTime dateA = DateTime.parse(dataA['appointmentDate']);
                DateTime dateB = DateTime.parse(dataB['appointmentDate']);

                if (dateA.compareTo(dateB) != 0) {
                  return dateA.compareTo(dateB);
                } else {
                  TimeOfDay timeA = TimeOfDay(
                    hour: int.parse(dataA['time'].split(':')[0]),
                    minute: int.parse(dataA['time'].split(':')[1]),
                  );
                  TimeOfDay timeB = TimeOfDay(
                    hour: int.parse(dataB['time'].split(':')[0]),
                    minute: int.parse(dataB['time'].split(':')[1]),
                  );
                  return timeA.hour.compareTo(timeB.hour) != 0
                      ? timeA.hour.compareTo(timeB.hour)
                      : timeA.minute.compareTo(timeB.minute);
                }
              });

              return Container(
                color: Colors.white,
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  itemCount: sortedDocs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = sortedDocs[index];
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;

                    String doctorName = data['doctorname'] ?? 'No Doctor Name';
                    String firstName = data['First Name'] ?? 'No First Name';
                    String date = data['appointmentDate'] ?? 'No Date';
                    String time = data['time'] ?? 'No Time';

                    // Format time in 12-hour format with AM/PM
                    String formattedTime = DateFormat.jm()
                        .format(DateTime.parse('2022-01-01 $time'));

                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        leading: const Icon(Icons.calendar_today,
                            color: Colors.blue),
                        title: Text(
                          'Doctor name: Dr $doctorName',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text('Name: $firstName',
                                style: const TextStyle(fontSize: 16)),
                            Text('Date: $date',
                                style: const TextStyle(fontSize: 16)),
                            Text('Time: $formattedTime',
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        onTap: () {
                          // Handle onTap if needed
                        },
                      ),
                    );
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
