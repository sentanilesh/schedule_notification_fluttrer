import 'package:flutter/material.dart';

import 'notifications.dart';

// 1. Add Dependency awesome_notifications in pubspec.yml
// 2. Create Notification manager class with Show Notification Function
// 3. Initialize the notification
// 4. Create Notification icon in android > drawable folder
// 5. Schedule Notification


void main(){
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

  MyApp(){
    initLocalNotification(nav);
  }

  Future<void> initLocalNotification(GlobalKey<NavigatorState> nav) async {
    bool isInit = await NotificationsMgr.getInstance.initNotification();
    if (isInit) NotificationsMgr.getInstance.askNotificationPermission();
    NotificationsMgr.getInstance.listenNotificationStream(nav.currentState!.context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(key: nav,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tap to Schedule notification after 10 Seconds',
            ),
            TextButton(onPressed: (){
              DateTime now = DateTime.now().add(Duration(seconds: 10));
              // Create Your desire Date Time and Schedule the Notification
              NotificationsMgr.getInstance.showNotification(1, "This is scheduled notification", "Awesome Notificetion", now);
            }, child: Text("Schedule"))
          ],
        ),
      ),

    );
  }
}
