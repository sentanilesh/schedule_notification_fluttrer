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
              DateTime dob = DateTime(1990, 1, 25);                        // This is your Birthdate (Not used in Our Scenario)
              DateTime thisYearDOB = DateTime(DateTime.now().year, 1, 25); // Just change the Year as Current year
              for (int i=0; i<100; i++) {                                  // Schedule Notification till 100 Years
                DateTime diffDuration = DateTime(thisYearDOB.year+i, thisYearDOB.month, thisYearDOB.year);  // Add Year Diffrence and create new Time
                // Create Your desire Date Time and Schedule the Notification
                NotificationsMgr.getInstance.showNotification(i, "Happy Birthday...", "Awesome Notification", diffDuration);
                // If you want to Modify the Notification Like Delete in that case this Notification id Will help you.
              }
            }, child: Text("Schedule"))
          ],
        ),
      ),

    );
  }
}
