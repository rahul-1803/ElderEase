import "package:dementia/pages/leader_board.dart";
import "package:dementia/pages/name.dart";
import "package:dementia/service/database.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:random_string/random_string.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class Result extends StatefulWidget {
  final int correctAnswers;
  final int wrongAnswers;
  final String name;

  const Result(
      {Key? key,
      required this.correctAnswers,
      required this.wrongAnswers,
      required this.name})
      : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          width: 500,
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 4, 228, 224),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Correct Answers: ${widget.correctAnswers}"),
              Text("Wrong Answers: ${widget.wrongAnswers}"),
              ElevatedButton(
                  onPressed: () async {
                    String Id = randomAlphaNumeric(10);
                    Map<String, dynamic> employeeInfoMap = {
                      "Name": widget.name,
                      "Id": Id,
                      "correct answer": widget.correctAnswers,
                      "wrong answer": widget.wrongAnswers,
                    };

                    await DataBaseMethods_reward()
                        .addOrUpdateEmployeeDetails(employeeInfoMap, Id)
                        .then((value) {
                      Fluttertoast.showToast(
                          msg: "Details Added/Updated Successfully!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    });
                  },
                  child: Text("UPLOAD SCORE")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => leader_board()));
                  },
                  child: Text("VIEW LEADERBOARD"))
            ],
          ),
        ),
      ),
    );
  }
}
