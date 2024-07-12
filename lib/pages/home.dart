import "package:dementia/pages/Addquiz.dart";
import "package:dementia/pages/name.dart";
import "package:dementia/pages/question.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController namecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 220,
                    padding: const EdgeInsets.only(left: 10, top: 50),
                    decoration: const BoxDecoration(
                        color: Color(0xFF2a2b31),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "images/brain.jpg",
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "Dementia Quiz App",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    margin:
                        const EdgeInsets.only(top: 130, left: 30, right: 20),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "images/quiz.jpg",
                            height: 200,
                            width: 280,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              TextField(
                onSubmitted: (value) {
                  namecontroller.text = value;
                  Name(name: namecontroller.text);
                },
                controller: namecontroller,
                decoration: const InputDecoration(
                    hintText: "Enter your name",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Top Quiz Categories",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Questions(
                                    Category: "Family",
                                    name: namecontroller.text)));
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 10,
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          height: 150,
                          width: 130,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 53, 51, 51),
                              borderRadius: BorderRadius.circular(20)),
                              //padding: const EdgeInsets.only(left: 60),
                          child: const Center(
                            child: Text("Family",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Questions(
                                    Category: "Animal",
                                    name: namecontroller.text)));
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 10,
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          height: 150,
                          width: 130,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 53, 51, 51),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text("Animal",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Questions(
                                    Category: "Fruit",
                                    name: namecontroller.text)));
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 10,
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          height: 150,
                          width: 130,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 53, 51, 51),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text("Fruit",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Questions(
                                    Category: "Objects",
                                    name: namecontroller.text)));
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 10,
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          height: 150,
                          width: 130,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 53, 51, 51),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text("Objects",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Questions(
                                    Category: "Sports",
                                    name: namecontroller.text)));
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 10,
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          height: 150,
                          width: 130,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 53, 51, 51),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text("Sports",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Questions(
                                    Category: "Random",
                                    name: namecontroller.text)));
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 10,
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          height: 150,
                          width: 130,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 53, 51, 51),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text("Random",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Add_quiz()));
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        height: 150,
                        width: 130,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 53, 51, 51),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                          child: Text("Upload Quiz",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
