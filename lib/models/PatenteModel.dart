// To parse this JSON data, do
//
//     final patenteModel = patenteModelFromJson(jsonString);

import 'dart:convert';

PatenteModel patenteModelFromJson(String str) =>
    PatenteModel.fromJson(json.decode(str));

String patenteModelToJson(PatenteModel data) => json.encode(data.toJson());

class PatenteModel {
  PatenteModel({
    this.id,
    this.marca,
    this.patente,
    this.precio = 0.0,
  });
  String id;
  String marca;
  String patente;
  double precio = 0.0;

  factory PatenteModel.fromJson(Map<String, dynamic> json) => PatenteModel(
        id: json["id"],
        marca: json["marca"],
        patente: json["patente"],
        precio: json["precio"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "marca": marca,
        "patente": patente,
        "precio": precio,
      };
}
