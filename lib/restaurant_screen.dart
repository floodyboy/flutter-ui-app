import 'package:flutter/material.dart';
import 'package:patients/zoom_scaffold.dart';

final Screen restaurantScreen = new Screen(
    title: 'THE PALEO PADDOCK',
    
    contentBuilder: (BuildContext context) {
      return new ListView(
          children: [
            new _RestaurantCard(
                headImageAssetPath: 'assets/appointment.png',
                icon: Icons.person_pin_circle,
                iconBackgroundColor: const Color(0xFFa7c045),
                title: 'Appointment',
                subtitle: "Appointment List",
                heartCount: 10,
                onTapped: () { },
            ),
            new _RestaurantCard(
                headImageAssetPath: 'assets/patients.jpg',
                icon: Icons.people_outline,
                iconBackgroundColor: const Color(0xFF810055),
                title: 'Patients',
                subtitle: "Patients List",
                heartCount: 15
            ),
            new _RestaurantCard(
                headImageAssetPath: 'assets/patient.png',
                icon: Icons.streetview,
                iconBackgroundColor: const Color(0xFFe6d72a),
                title: 'Patient',
                subtitle: "Patient Details",
                heartCount: 12
            ),
          ]
      );
    }
);


class _RestaurantCard extends StatelessWidget {

  

  final String headImageAssetPath;
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  final int heartCount;
  final VoidCallback onTapped;

  _RestaurantCard({
    this.headImageAssetPath,
    this.icon,
    this.iconBackgroundColor,
    this.title,
    this.subtitle,
    this.heartCount,
    this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: GestureDetector(
        onTap: onTapped,
        child: new Card(
          elevation: 10.0,
          child: new Column(
            children: [
              new Image.asset(
                headImageAssetPath,
                width: double.infinity,
                height: 150.0,
                fit: BoxFit.cover,
              ),
              new Row(
                children: [
                  new Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: new Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: new BoxDecoration(
                        color: iconBackgroundColor,
                        borderRadius: new BorderRadius.all(const Radius.circular(15.0)),
                      ),
                      child: new Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  new Expanded(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text(
                          title,
                          style: const TextStyle(
                            fontSize: 25.0,
                            fontFamily: 'mermaid',
                          ),
                        ),
                        new Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'bebas-neue',
                            letterSpacing: 1.0,
                            color: const Color(0xFFAAAAAA),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    width: 2.0,
                    height: 70.0,
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white,
                          const Color(0xFFAAAAAA),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: new Column(
                      children: [
                        new Icon(
                          Icons.list,
                          color: Colors.redAccent,
                        ),
                        new Text(
                          '$heartCount',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}