import 'dart:convert';

import 'package:flutter/foundation.dart';

class FoodModel {
  static List<Foods> foods = [];
}

class Foods {
  int id;
  String name;
  List<String> items;

  Foods({
    required this.id,
    required this.name,
    required this.items,
  });

  Foods copyWith({
    int? id,
    String? name,
    List<String>? items,
  }) {
    return Foods(
      id: id ?? this.id,
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'items': items,
    };
  }

  factory Foods.fromMap(Map<String, dynamic> map) {
    return Foods(
      id: map['id'],
      name: map['name'],
      items: List<String>.from(map['items']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Foods.fromJson(String source) => Foods.fromMap(json.decode(source));

  @override
  String toString() => 'Foods(id: $id, name: $name, items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Foods &&
        other.id == id &&
        other.name == name &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ items.hashCode;
}
