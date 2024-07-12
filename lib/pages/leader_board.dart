import "package:cloud_firestore/cloud_firestore.dart";
import "package:dementia/service/database.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class leader_board extends StatefulWidget {
  const leader_board({super.key});

  @override
  State<leader_board> createState() => _leader_boardState();
}

class _leader_boardState extends State<leader_board> {
  Stream<QuerySnapshot>? LeaderStream;
  getontheload() async {
    LeaderStream = DataBaseMethods_reward().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allEmployeeDetailes() {
    return StreamBuilder(
        stream: LeaderStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Container(
              child: Text("No data"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              List<DocumentSnapshot> sortedDocs = snapshot.data!.docs;
              sortedDocs.sort((a, b) {
                int aCorrect = a['correct answer'];
                int bCorrect = b['correct answer'];
                return bCorrect.compareTo(aCorrect); // sort in descending order
              });
              DocumentSnapshot ds = sortedDocs[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Color.fromARGB(206, 226, 224, 224)),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.only(bottom: 20),
                child: Material(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: Color.fromARGB(255, 223, 222, 222)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name: " + ds["Name"].toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Correct Answer : " + ds["correct answer"].toString(),
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Wrong Answer : " + ds["wrong answer"].toString(),
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                "Leader Board",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Expanded(child: allEmployeeDetailes()),
      ),
    );
  }
}
