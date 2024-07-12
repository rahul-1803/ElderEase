import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:share/share.dart';


class PreviewPage extends StatelessWidget {
  final String doctorname;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String age;
  final String sex;
  final String ailment;
  final String appointmentDate;
  final String time;

  PreviewPage({
    required this.doctorname,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.age,
    required this.sex,
    required this.ailment,
    required this.appointmentDate,
    required this.time,
  });

  Future<void> downloadPdf(BuildContext context) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Storage permission is required to download the PDF')),
        );
        return;
      }
    }

    // final pdf = pw.Document();

    // pdf.addPage(
    //   pw.Page(
    //     build: (pw.Context context) => pw.Center(
    //       child: pw.ListView(
    //         children: [
    //           pw.Text('First Name: $firstName'),
    //           pw.Text('Last Name: $lastName'),
    //           pw.Text('Phone Number: $phoneNumber'),
    //           pw.Text('Age: $age'),
    //           pw.Text('Sex: $sex'),
    //           pw.Text('Ailment: $ailment'),
    //           pw.Text('Appointment Date: $appointmentDate'),
    //           pw.Text('Time: $time'),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/appointment_details.pdf");
    // await file.writeAsBytes(await pdf.save());

    Share.shareFiles([file.path], text: 'Your PDF!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
        backgroundColor: const Color.fromARGB(255, 235, 238, 240),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Patient Details', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF7165D6)), textAlign: TextAlign.justify),
              ),
              SizedBox(height: 20),
              _buildInfoRow('Doctor name', doctorname),
              _buildInfoRow('First Name:', firstName),
              _buildInfoRow('Last Name:', lastName),
              _buildInfoRow('Phone Number:', phoneNumber),
              _buildInfoRow('Age:', age),
              _buildInfoRow('Sex:', sex),
              _buildInfoRow('Ailment:', ailment),
              _buildInfoRow('Appointment Date:', appointmentDate),
              _buildInfoRow('Time:', time),
              SizedBox(height: 20),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () => downloadPdf(context),
              //     child: Text('Download PDF'),
              //     style: ElevatedButton.styleFrom(
              //       foregroundColor: Colors.white, backgroundColor: Color(0xFF7165D6), // foreground
              //     ),
              //   ),
              // ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  child: Text('Confirm Appointment'),
                  onPressed: () async {
                   Map<String, dynamic> newapointment= new Map<String,dynamic>();

                            newapointment["doctorname"] = doctorname;
                            newapointment["First Name"] = firstName;
                            newapointment["lastName"] = lastName;
                            newapointment["phoneNumber"] = phoneNumber;
                            newapointment["age"] = age;
                            newapointment["sex"]=sex;
                            newapointment["ailment"]=ailment;
                            newapointment["appointmentDate"]=appointmentDate;
                            newapointment["time"]=time;

                            await FirebaseFirestore.instance.collection("appointments").add(newapointment);

                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Color(0xFF7165D6), // foreground
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF7165D6)), textAlign: TextAlign.justify),
          ),
          Expanded(
            child: Text(value, style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
          ),
        ],
      ),
    );
  }
}