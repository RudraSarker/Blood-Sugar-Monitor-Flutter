import 'dart:convert';

import 'dart:ffi';

final String tableMedicine = 'medicine';

class MedicineFields {
  static final List<String> values = [
    /// Add all fields
    id, name, morning, noon, night
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String morning = 'morning';
  static final String noon = 'noon';
  static final String night = 'night';
}

class Medicine {
  int? id;
  String name;
  int morning;
  int noon;
  int night;

  Medicine(
      {this.id,
      required this.name,
      required this.morning,
      required this.noon,
      required this.night}) {
    // id = this.id;
    // title = this.title;
    // description = this.description;
    // status = this.status;
  }

  Medicine copy({
    int? id,
    String? name,
    int? morning,
    int? noon,
    int? night,
  }) =>
      Medicine(
        id: id ?? this.id,
        name: name ?? this.name,
        morning: morning ?? this.morning,
        noon: noon ?? this.noon,
        night: night ?? this.night,
      );

  static Medicine fromJson(Map<String, Object?> json) => Medicine(
        id: json[MedicineFields.id] as int?,
        name: json[MedicineFields.name] as String,
        morning: json[MedicineFields.morning] as int,
        noon: json[MedicineFields.noon] as int,
        night: json[MedicineFields.night] as int,
      );

  Map<String, Object?> toJson() => {
        MedicineFields.id: id,
        MedicineFields.name: name.toString(),
        MedicineFields.morning: morning.toInt(),
        MedicineFields.noon: noon.toInt(),
        MedicineFields.night: night.toInt(),
      };
}
