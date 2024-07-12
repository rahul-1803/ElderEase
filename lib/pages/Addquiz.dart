import "dart:io";

import "package:dementia/service/database.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:image_picker/image_picker.dart";
import "package:random_string/random_string.dart";

class Add_quiz extends StatefulWidget {
  const Add_quiz({super.key});

  @override
  State<Add_quiz> createState() => _Add_quizState();
}

class _Add_quizState extends State<Add_quiz> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  //when ever user click on the image icon it will open the gallery and user can select the image
  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  TextEditingController option1controller = new TextEditingController();
  TextEditingController option2controller = new TextEditingController();
  TextEditingController option3controller = new TextEditingController();
  TextEditingController option4controller = new TextEditingController();
  TextEditingController correctcontroller = new TextEditingController();
  String? value;

  uploadItem() async {
    if (selectedImage != null &&
        option1controller.text.isNotEmpty &&
        option2controller.text.isNotEmpty &&
        option3controller.text.isNotEmpty &&
        option4controller.text.isNotEmpty &&
        correctcontroller.text.isNotEmpty &&
        value != null) {
      //upload the data to the firebase
      String addid = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("quiz").child(addid);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();
      print(downloadUrl.toString());
      Map<String, dynamic> addQuiz = {
        "Image": downloadUrl,
        "option1": option1controller.text,
        "option2": option2controller.text,
        "option3": option3controller.text,
        "option4": option4controller.text,
        "correct": correctcontroller.text,
      };

      await DatabaseMethods().addQuizCategory(addQuiz, value!).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Detailes added successfully")));
      });
    }
  }

  final List<String> quizitems = [
    "Animal",
    "Sports",
    "Random",
    "Fruits",
    "Objects",
    "Family"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 180, 232, 237),
        title: const Center(
          child: Text(
            "Add Quiz",
            style: TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Upload the image Quiz",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              //selectedImage == null ? doSomethingIfNull() : doSomethingIfNotNull();
              //In this example, if selectedImage is null, the doSomethingIfNull() function will be called. If selectedImage is not null, the doSomethingIfNotNull() function will be called.
              selectedImage == null
                  ? GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Center(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 10,
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(Icons.camera_alt_rounded),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 10,
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                              //The ! symbol in Dart is called the "null assertion operator". It's used when you have a variable that can be null, but you are confident that at this point in the code, it will not be null.

                              // In your code, selectedImage! is asserting that selectedImage is not null. If selectedImage is indeed null at this point, a runtime error will occur.
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              const Text(
                "Option1",
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: option1controller,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter option1 ",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Option2",
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: option2controller,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter option 2 ",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Option3",
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: option3controller,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter option3 ",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Option4",
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: option4controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter option4 ",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Correct answer",
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: correctcontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter correct answer ",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                  items: quizitems
                      .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          )))
                      .toList(),
                  onChanged: ((value) => setState(() {
                        this.value = value;
                      })),
                  hint: const Text(
                    "Select the catagory",
                    style: TextStyle(color: Colors.black),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  value: value,
                )),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    uploadItem();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "ADD",
                      style: TextStyle(fontSize: 20),
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
