class StoreProductRequest {
  String? name;
  String? description;

  StoreProductRequest({
    this.name,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}