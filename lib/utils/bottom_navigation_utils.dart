import 'package:flutter/material.dart';
import 'package:e2517/providers/superheroes-cloud-functions-provider.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  CloudFunctionsFirebase heroe = new CloudFunctionsFirebase();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(87, 35, 100, 0.5),
      fixedColor: Colors.white,
      currentIndex: 1,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Login',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cloud),
          label: 'Heroe',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_add),
          label: 'Register',
        ),
      ],
      onTap: (index) {
        setState(() {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, 'login');
          } else if (index == 1) {
            heroe.addHeroeCloudFunctions(
                name: "Deadpool", points: 500.5, available: true);
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, 'registration');
          }
        });
      },
    );
  }
}
