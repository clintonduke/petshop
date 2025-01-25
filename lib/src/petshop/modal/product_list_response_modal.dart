class ProductListResponse {
  int? status;
  List<ProductListData>? data;
  String? message;

  ProductListResponse({this.status, this.data, this.message});

  ProductListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ProductListData>[];
      json['data'].forEach((v) {
        data!.add(ProductListData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class ProductListData {
  int? id;
  String? userName;
  String? petName;
  String? petType;
  String? gender;
  String? location;
  String? image;
  String? createdAt;
  String? updatedAt;

  ProductListData(
      {this.id,
      this.userName,
      this.petName,
      this.petType,
      this.gender,
      this.location,
      this.image,
      this.createdAt,
      this.updatedAt});

  ProductListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    petName = json['pet_name'];
    petType = json['pet_type'];
    gender = json['gender'];
    location = json['location'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['pet_name'] = petName;
    data['pet_type'] = petType;
    data['gender'] = gender;
    data['location'] = location;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
