import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:e2517/models/superheroe_models.dart';
import 'package:e2517/preferences/shared_preferences.dart';

class SuperheroesProvider {
  final String _firebaseUrlUsers = 'your url database realtime';
  final _prefs = new UserPreferences();

  Future<bool> createSuperheroe(HeroeModel heroe) async {
    final url = '$_firebaseUrlUsers/superheroes.json?auth=${_prefs.token}';

    final resp = await http.post(url, body: heroeModelToJson(heroe));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> updateSuperheroe(HeroeModel heroe) async {
    final url =
        '$_firebaseUrlUsers/superheroes/${heroe.id}.json?auth=${_prefs.token}';

    final resp = await http.put(url, body: heroeModelToJson(heroe));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<HeroeModel>> loadHeroes() async {
    final url = '$_firebaseUrlUsers/superheroes.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<HeroeModel> heroes = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, superheroe) {
      final heroesTemp = HeroeModel.fromJson(superheroe);

      heroesTemp.id = id;

      heroes.add(heroesTemp);
    });

    return heroes;
  }

  Future<int> deleteHeroe(String id) async {
    final url = '$_firebaseUrlUsers/superheroes/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }
}
