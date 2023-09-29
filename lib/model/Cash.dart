import 'package:flutter/material.dart';
import 'dart:convert';

class Cash {
  String? id;
  int? nominal;
  String? keterangan;
  String? date;
  bool? isAdd;
  Cash(
      {required this.id,
      required this.nominal,
      required this.keterangan,
      required this.date,
      required this.isAdd});
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nominal": nominal,
      "keterangan": keterangan,
      "date": date,
      "isAdd": isAdd
    };
  }

  Cash.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nominal = map['nominal'];
    keterangan = map['keterangan'];
    date = map['date'];
    isAdd = map['isAdd'] == 1;
  }
}
