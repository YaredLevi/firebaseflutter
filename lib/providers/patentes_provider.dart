import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:productos1/models/PatenteModel.dart';

class PatentesProvider {
  final String _url = "https://patente21-9f769-default-rtdb.firebaseio.com/";

  Future<bool> crearProducto(PatenteModel patente) async {
    final url = '$_url/patente.json';

    final resp =
        await http.post(Uri.parse(url), body: patenteModelToJson(patente));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<List<PatenteModel>> cargarPatentes() async {
    final url = '$_url/patente.json';
    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<PatenteModel> patentes = [];
    if (decodedData == null) return [];
    decodedData.forEach((id, prod) {
      final prodTemp = PatenteModel.fromJson(prod);
      prodTemp.id = id;
      patentes.add(prodTemp);
    });
    // print( patentes[0].id );
    return patentes;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/patente/$id.json';

    final resp = await http.delete(Uri.parse(url));

    return 1;
  }
}
