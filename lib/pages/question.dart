import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dementia/pages/result_page.dart';
import 'package:dementia/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Questions extends StatefulWidget {
  bool show = false;
  String Category;
  String name;

  Questions({
    required this.Category,
    required this.name,
  });

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int correctAnswers = 0;
  int wrongAnswers = 0;

  getontheload() async {
    QuizStream = await DatabaseMethods().getCategoryQuiz(widget.Category);
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Stream? QuizStream;
  PageController controller = PageController();

  Widget allQuiz() {
    return StreamBuilder(
      stream: QuizStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? PageView.builder(
                controller: controller,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return SingleChildScrollView(
                    child: Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 40, right: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  ds["Image"],
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      heightFactor: 7,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 10,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            buildOptionContainer(ds, "option1"),
                            SizedBox(
                              height: 20,
                            ),
                            buildOptionContainer(ds, "option2"),
                            SizedBox(
                              height: 20,
                            ),
                            buildOptionContainer(ds, "option3"),
                            SizedBox(
                              height: 20,
                            ),
                            buildOptionContainer(ds, "option4"),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.show = false;
                                });
                                if (controller.page!.toInt() ==
                                    snapshot.data.docs.length - 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Result(
                                        name: widget.name,
                                        correctAnswers: correctAnswers,
                                        wrongAnswers: wrongAnswers,
                                      ),
                                    ),
                                  );
                                } else {
                                  controller.nextPage(
                                      duration: Duration(milliseconds: 220),
                                      curve: Curves.easeIn);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Icon(
                                  Icons.arrow_forward_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : Container();
      },
    );
  }

  Widget buildOptionContainer(DocumentSnapshot ds, String option) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.show = true;
        });
        if (ds["correct"] == ds[option]) {
          correctAnswers++;
        } else {
          wrongAnswers++;
        }
      },
      child: widget.show
          ? Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: ds["correct"] == ds[option]
                          ? Colors.green
                          : Colors.red,
                      width: 1.5),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                ds[option],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.5),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                ds[option],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff004840),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Color(0xFFf35b32),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Text(
                    widget.Category.toString(),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: allQuiz()),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Correct: $correctAnswers, Wrong: $wrongAnswers',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
