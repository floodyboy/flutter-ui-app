import 'package:flutter/material.dart';
import 'package:patients/menu_screen.dart';
import 'package:patients/restaurant_screen.dart';
import 'package:patients/zoom_scaffold.dart';
import 'package:patients/login.dart';
import 'package:patients/appointment.dart';
import 'package:patients/patients.dart';
import 'package:patients/patient.dart';
void main() => runApp(new DrawerMenu());

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Zoom Menu',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text("Hello"),),
      
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final menu = new Menu(
    items: [
      new MenuItem(
        id: 'restaurant',
        title: 'HOME',
      ),
      new MenuItem(
        id: 'patient',
        title: 'PATIENT',
      ),
      new MenuItem(
        id: 'patients',
        title: 'PATIENTS',
      ),
      new MenuItem(
        id: 'apoinmentscreen',
        title: "APPOINTMENT",
      ),
    ],
  );

  var selectedMenuItemId = 'restaurant';
  var activeScreen = restaurantScreen;

  @override
  Widget build(BuildContext context) {
    return new ZoomScaffold(
      menuScreen: new MenuScreen(
        menu: menu,
        selectedItemId: selectedMenuItemId,
        onMenuItemSelected: (String itemId) {
          selectedMenuItemId = itemId;
          if (itemId == 'restaurant') {
            setState(() => activeScreen = restaurantScreen);
          } else if(itemId == 'gridview') {
            setState(() => activeScreen = loginScreen);
          } else if(itemId == 'apoinmentscreen') {
            setState(() => activeScreen = appointmentScreen);
          } else if (itemId == 'patient') {
            setState(() => activeScreen = patientScreen);
          } else if (itemId == 'patients') {
            setState(() => activeScreen = patientsScreen);
          } else {
            setState(() => activeScreen = restaurantScreen);
          }
        },
      ),
      contentScreen: activeScreen,
    );
  }
}
