import 'package:dio/dio.dart';

class AddProductReq {
  String? petName;
  String? userName;
  String? petType;
  String? gender;
  String? location;
  MultipartFile? image;

  AddProductReq({
    this.petName,
    this.userName,
    this.petType,
    this.gender,
    this.location,
    this.image,
  });

  AddProductReq.fromJson(Map<String, dynamic> json) {
    petName = json['pet_name'];
    userName = json['user_name'];
    petType = json['pet_type'];
    gender = json['gender'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pet_name'] = petName;
    data['user_name'] = userName;
    data['pet_type'] = petType;
    data['gender'] = gender;
    data['location'] = location;
    return data;
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'pet_name': petName,
      'user_name': userName,
      'pet_type': petType,
      'gender': gender,
      'location': location,
      if (image != null)
        'image': image, // Include the image only if it's provided
    });
  }
}
