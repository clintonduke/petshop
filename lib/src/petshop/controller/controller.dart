import 'package:pet_shop/src/allpackage.dart';

class PetController extends GetxController {
  bool loading = false;
  ProductListResponse? productListResponse;

  void fetchPetList() async {
    try {
      loadingBar(true);
      final response =
          await Dio().get('http://valamcars.rankuhigher.in/api/get/form');
      if (response.statusCode == 200 && response.data != null) {
        productListResponse = ProductListResponse.fromJson(response.data);
      }
    } catch (e) {
      debugPrint("Error fetching data: $e");
    } finally {
      loadingBar(false);
    }
  }

  void loadingBar(bool status) {
    loading = status;
    update(['petPage']);
  }
}
