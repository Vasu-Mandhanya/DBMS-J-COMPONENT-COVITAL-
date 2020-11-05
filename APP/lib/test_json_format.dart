import 'dart:convert';

import 'package:flutter/cupertino.dart';

TestTable testTableFromJson(String str) => TestTable.fromJson(json.decode(str));

String testTableToJson(TestTable data) => json.encode(data.toJson());

class TestTable {
  TestTable({
    this.id,
    this.name,
    this.city,
    this.contact,
  });

  int id;
  String name;
  String city;
  String contact;

  factory TestTable.fromJson(Map<String, dynamic> json) => TestTable(
        id: json["id"],
        name: json["Name"],
        city: json["City"],
        contact: json["Contact"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "City": city,
        "Contact": contact,
      };
}
