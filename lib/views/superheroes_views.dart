import 'package:flutter/material.dart';
import 'package:e2517/utils/background_image_utils.dart' as background;
import 'package:e2517/utils/bottom_navigation_utils.dart' as bottomNav;
import 'package:e2517/utils/is_number_utils.dart' as number;
import 'package:e2517/models/superheroe_models.dart';
import 'package:e2517/providers/superheroes_provider.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  HeroeModel heroe = new HeroeModel();
  SuperheroesProvider heroeProvider = new SuperheroesProvider();
  final _formKey = GlobalKey<FormState>();
  final _snackbarKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    final HeroeModel heroeUpdate = ModalRoute.of(context).settings.arguments;

    if (heroeUpdate != null) {
      heroe = heroeUpdate;
    }

    Future<Null> _refreshSuperheroes() async {
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        _loadHeroes();
      });
    }

    return Scaffold(
      key: _snackbarKey,
      body: RefreshIndicator(
        onRefresh: _refreshSuperheroes,
        backgroundColor: Colors.white,
        color: Colors.purple,
        child: Stack(
          children: <Widget>[
            background.backgroundImage(context),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 25),
                  _imageProfile(),
                  SizedBox(height: 20),
                  _form(),
                  _loadHeroes(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNav.BottomNavigationPage(),
    );
  }

  Widget _imageProfile() {
    return SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/profile.jpg')))),
            SizedBox(height: 5),
            Text("Wonder Woman",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textScaleFactor: 1.5)
          ],
        ),
      ),
    );
  }

  Widget _barDescription() {
    return Container(
      color: Color.fromRGBO(87, 35, 100, 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text('Create superheroe ❤️',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Column(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.send,
                    size: 30,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    _submit();
                    _snackBarMessage('Superheroe created en Firebase');
                  }),
            ],
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    print(
        'User name ${heroe.name} points: ${heroe.points} available: ${heroe.available}');

    if (heroe.id == null) {
      heroeProvider.createSuperheroe(heroe);
    } else {
      heroeProvider.updateSuperheroe(heroe);
    }
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _barDescription(),
          SizedBox(height: 10.0),
          _textFieldName(),
          _textFieldPoints(),
          _available(),
        ],
      ),
    );
  }

  Widget _textFieldName() {
    return TextFormField(
      initialValue: heroe.name,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10.0),
          labelText: 'Name',
          labelStyle: TextStyle(fontSize: 18.0)),
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(fontSize: 18),
      textAlign: TextAlign.center,
      validator: (value) {
        if (value.length == 0) {
          return 'Enter a name';
        } else {
          return null;
        }
      },
      onSaved: (value) => heroe.name = value.trim(),
    );
  }

  Widget _textFieldPoints() {
    return TextFormField(
      initialValue: heroe.points.toString(),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10.0),
          labelText: 'Points',
          labelStyle: TextStyle(fontSize: 18.0)),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 18),
      textAlign: TextAlign.center,
      validator: (value) =>
          number.isNumeric(value) == true ? null : 'Enter a number',
      onSaved: (value) => heroe.points = double.tryParse(value),
    );
  }

  Widget _available() {
    return SwitchListTile(
        activeColor: Colors.red,
        title: Text(
          'Superheroe',
          style: TextStyle(fontSize: 18.0),
        ),
        value: heroe.available,
        onChanged: (value) {
          setState(() {
            heroe.available = value;
          });
        });
  }

  Widget _loadHeroes() {
    return FutureBuilder(
        future: heroeProvider.loadHeroes(),
        builder:
            (BuildContext context, AsyncSnapshot<List<HeroeModel>> snapshot) {
          if (snapshot.hasData) {
            snapshot.data.sort((a, b) => b.points.compareTo(a.points));
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(87, 35, 100, 0.8),
                          borderRadius: BorderRadius.circular(20.0)),
                      margin: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        background: Container(
                            alignment: Alignment(1.0, 0.0),
                            padding: EdgeInsets.only(right: 20.0),
                            color: Colors.white,
                            child: Icon(Icons.delete, color: Colors.red)),
                        onDismissed: (direction) {
                          heroeProvider.deleteHeroe(snapshot.data[i].id);
                          _snackBarMessage('Superheroe delete from Firebase');
                        },
                        child: ListTile(
                          title: Text('${snapshot.data[i].name}'),
                          trailing: Text('${snapshot.data[i].points}'),
                          onTap: () {
                            Navigator.pushNamed(context, 'user',
                                arguments: snapshot.data[i]);
                          },
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  void _snackBarMessage(String message) {
    final snackBar = SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        duration: Duration(milliseconds: 2500));

    _snackbarKey.currentState.showSnackBar(snackBar);
  }
}
