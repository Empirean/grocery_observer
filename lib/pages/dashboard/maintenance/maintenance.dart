import 'package:flutter/material.dart';
import 'package:grocery_observer/pages/dashboard/maintenance/registeritem.dart';
import 'package:grocery_observer/pages/dashboard/maintenance/removeitem.dart';

class Maintenance extends StatefulWidget {
  const Maintenance({Key? key}) : super(key: key);

  @override
  _MaintenanceState createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {

  int _selectedIndex = 0;

  static const List _pageList = [
    RegisterItem(),
    RemoveItem()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: "New Item",
              icon: Icon(Icons.add_shopping_cart)
          ),
          BottomNavigationBarItem(
              label: "Edit/Delete Item",
              icon: Icon(Icons.delete)
          )
        ],
      ),
    );
  }
}
