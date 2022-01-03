import 'dart:convert';

class Car {
  const Car({
    required this.name,
    required this.id,
  });
  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      name: map['name'],
      id: map['id'],
    );
  }
  factory Car.fromJson(String source) => Car.fromMap(json.decode(source));
final String name;
final String id;




  Car copyWith({
    String? name,
    String? id,
  }) {
    return Car(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }


  String toJson() => json.encode(toMap());


  @override
  String toString() => 'Car(name: $name, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Car &&
      other.name == name &&
      other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
