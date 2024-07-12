import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:dementia/ui/hme_screen.dart';

// void main() {
//   runApp(MyApp());
//   initializeNotifications();
// }

// void initializeNotifications() {
//   tz.initializeTimeZones();
//   final localLocation = tz.getLocation('Asia/Kolkata');
//   tz.setLocalLocation(localLocation);
// }

class MyApp extends StatefulWidget {
  final String medicineName;
  MyApp({Key? key, required this.medicineName}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _createNotificationChannel();
  }

  void _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'your_channel_id', // id
      'your_channel_name', // name
      description: 'your_channel_description', // description
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  void scheduleNotification(
      String title, String body, tz.TZDateTime scheduledDate) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    print('Scheduling notification at $scheduledDate'); // Debugging statement

    flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      scheduledDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }
    return scheduledDate;
  }

  void setReminder(String input) {
    var parts = input.split(':');
    var medicineName = parts[0];
    var times = parts[1].split('-');

    for (var time in times) {
      if (time.contains(':')) {
        var timeParts = time.split(':');
        var hour = int.parse(timeParts[0]);
        var minute = int.parse(timeParts[1]);
        scheduleNotification(medicineName, 'Time to take your medicine',
            _nextInstanceOfTime(hour, minute));
      } else {
        switch (time.toLowerCase()) {
          case 'day':
            scheduleNotification(medicineName, 'Time to take your medicine',
                _nextInstanceOfTime(02, 42));
            break;
          case 'afternoon':
            scheduleNotification(medicineName, 'Time to take your medicine',
                _nextInstanceOfTime(02, 42));
            break;
          case 'night':
            scheduleNotification(medicineName, 'Time to take your medicine',
                _nextInstanceOfTime(02,42));
            break;
          default:
            print('Invalid time of day: $time'); // Debugging statement
            break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pill Reminder'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back), 
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TextField(
                //   // controller: textController,
                //   // decoration: InputDecoration(
                //   //   border: OutlineInputBorder(),
                //   //   labelText: 'Enter Medicine Reminder',
                //   //   hintText: 'Aspirine:Day-afternoon-night or Aspirine:11:30',
                //   // ),
                // ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setReminder(widget.medicineName);
                  },
                  child: Text('Click here to set remainder '),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
