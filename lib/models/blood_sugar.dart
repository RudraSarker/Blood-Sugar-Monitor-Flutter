import 'dart:convert';

import 'dart:ffi';

import 'package:blood_sugar_monitor/models/medicine_model.dart';

final String tableBloodSugar = 'bloodsugar';

class BloodSugarFields {
  static final List<String> values = [
    /// Add all fields
    id, beforeFood, afterFood, date, time
  ];

  static final String id = '_id';
  static final String beforeFood = 'beforeFood';
  static final String afterFood = 'afterFood';
  static final String date = 'date';
  static final String time = 'time';
}

class BloodSugar {
  int? id;
  double beforeFood;
  double afterFood;
  String date;
  String time;

  BloodSugar(
      {this.id,
      required this.beforeFood,
      required this.afterFood,
      required this.date,
      required this.time}) {
    // id = this.id;
    // title = this.title;
    // description = this.description;
    // status = this.status;
  }

  BloodSugar copy({
    int? id,
    double? beforeFood,
    double? afterFood,
    String? date,
    String? time,
  }) =>
      BloodSugar(
        id: id ?? this.id,
        beforeFood: beforeFood ?? this.beforeFood,
        afterFood: afterFood ?? this.afterFood,
        date: date ?? this.date,
        time: time ?? this.time,
      );

  static BloodSugar fromJson(Map<String, Object?> json) => BloodSugar(
        id: json[BloodSugarFields.id] as int?,
        beforeFood: json[BloodSugarFields.beforeFood] as double,
        afterFood: json[BloodSugarFields.afterFood] as double,
        date: json[BloodSugarFields.date] as String,
        time: json[BloodSugarFields.time] as String,
      );

  Map<String, Object?> toJson() => {
        BloodSugarFields.id: id,
        BloodSugarFields.beforeFood: beforeFood.toDouble(),
        BloodSugarFields.afterFood: afterFood.toDouble(),
        BloodSugarFields.date: date.toString(),
        BloodSugarFields.time: time.toString(),
      };
}
