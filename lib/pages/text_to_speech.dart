import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var textSpeech = "CLICK ON MIC TO RECORD";
  SpeechToText speechToText = SpeechToText();
  var isListening = false;

  void checkMic() async {
    bool micAvailable = await speechToText.initialize();

    if (micAvailable) {
      print("MicroPhone Available");
    } else {
      print("User Denied th use of speech micro");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkMic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(textSpeech),
              GestureDetector(
                onTap: () async {
                  if (!isListening) {
                    bool micAvailable = await speechToText.initialize();

                    if (micAvailable) {
                      setState(() {
                        isListening = true;
                      });

                      speechToText.listen(
                          listenFor: Duration(seconds: 20),
                          onResult: (result) {
                            setState(() {
                              textSpeech = result.recognizedWords;
                              isListening = false;
                            });
                          });
                    }
                  } else {
                    setState(() {
                      isListening = false;

                      speechToText.stop();
                    });
                  }
                },
                child: CircleAvatar(
                  child: isListening
                      ? Icon(Icons.record_voice_over)
                      : Icon(Icons.mic),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
