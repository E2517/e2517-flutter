import 'dart:convert';
import 'package:http/http.dart' as http;

class CloudFunctionsFirebase {
  
  Future addHeroeCloudFunctions(
      {String name, double points, bool available}) async {
    final data = {'name': name, 'points': points, 'available': available};

    await http.post(
        'your_cloud_function-addheroe?name=$name&points=$points&available=$available',
        body: json.encode(data));

    return true;
  }
}
