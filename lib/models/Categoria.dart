import 'dart:convert';

class Categories {
    int id;
    String name;
    String image;
    DateTime creationAt;
    DateTime updatedAt;

    Categories({
        required this.id,
        required this.name,
        required this.image,
        required this.creationAt,
        required this.updatedAt,
    });

    factory Categories.fromJson(String str) => Categories.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Categories.fromMap(Map<String, dynamic> json) => Categories(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        creationAt: DateTime.parse(json["creationAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "creationAt": creationAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
