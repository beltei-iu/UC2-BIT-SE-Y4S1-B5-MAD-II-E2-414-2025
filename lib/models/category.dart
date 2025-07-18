class Category {
  int? id;
  String? name;
  String? nameKh;

  Category({this.id, this.name, this.nameKh});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'nameKh': nameKh};
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(id: map['id'], name: map['name'], nameKh: map['nameKh']);
  }
}
