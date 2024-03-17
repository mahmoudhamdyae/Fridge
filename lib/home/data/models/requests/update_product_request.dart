class UpdateProductRequest {
  int? id;
  String? name;
  String? description;

  UpdateProductRequest({
    this.id,
    this.name,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}