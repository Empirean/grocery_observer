import 'package:flutter/material.dart';
import 'package:grocery_observer/pages/dashboard/items/items.dart';
import 'package:grocery_observer/pages/dashboard/lowitems/lowitems.dart';
import 'package:grocery_observer/pages/dashboard/maintenance/maintenance.dart';
import 'package:grocery_observer/pages/dashboard/movement/movement.dart';
import 'package:grocery_observer/services/authentication.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _currentIndex = 0;

  final List<Widget> _widgetList = <Widget>[
    const LowItems(),
    const Items(),
    const Maintenance(),
    const Movement()
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                  await AuthenticationService().signOut();
              },
              icon: const Icon(Icons.logout_sharp )
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                child: Text("Observer")
            ),
            ListTile(
              title: const Text("Low"),
              onTap: () {
                updatePage(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Items"),
              onTap: () {
                updatePage(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Maintenance"),
              onTap: () {
                updatePage(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Movement"),
              onTap: () {
                updatePage(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _widgetList[_currentIndex],
    );
  }

  void updatePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
