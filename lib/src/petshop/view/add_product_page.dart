import 'package:pet_shop/src/allpackage.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => AddProductPageState();
}

class AddProductPageState extends State<AddProductPage> {
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String? _petType;
  String? _gender;
  File? _selectedImage;

  final List<String> petTypes = ['Dog', 'Cat', 'Bird', 'Other'];
  final List<String> genders = ['Male', 'Female'];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_petNameController.text.isEmpty ||
        _ownerNameController.text.isEmpty ||
        _petType == null ||
        _gender == null ||
        _locationController.text.isEmpty ||
        _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields.')),
      );
      return;
    }
    final addProductReq = AddProductReq(
      petName: _petNameController.text,
      userName: _ownerNameController.text,
      petType: _petType,
      gender: _gender,
      location: _locationController.text,
      image: await MultipartFile.fromFile(
        _selectedImage!.path,
        filename: _selectedImage!.path.split('/').last,
      ),
    );

    try {
      final dio = Dio();
      final formData = await addProductReq.toFormData();
      final response = await dio.post(
        'http://valamcars.rankuhigher.in/api/register/form',
        data: formData,
      );
      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Product added successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.to(ProductListPage());
      }
    } catch (e) {
      debugPrint('Error adding product: $e');
    }
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    String hint = '',
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            fillColor: CommonColors.inputColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: CommonColors.borderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: CommonColors.borderColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: CommonColors.borderColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdown({
    required String label,
    required List<String> items,
    String? value,
    required Function(String?) onChanged,
    String hint = '',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            fillColor: CommonColors.inputColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: CommonColors.borderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: CommonColors.borderColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: CommonColors.borderColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          ProductStrings.addYourPetDetails,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField(
              label: ProductStrings.yourPetName,
              controller: _petNameController,
              hint: 'Enter your pet name',
            ),
            const SizedBox(height: 16),
            buildTextField(
              label: ProductStrings.petOwnerName,
              controller: _ownerNameController,
              hint: 'Enter owner name',
            ),
            const SizedBox(height: 16),
            buildDropdown(
              label: ProductStrings.petType,
              hint: 'Select pet type',
              items: petTypes,
              value: _petType,
              onChanged: (value) => setState(() => _petType = value),
            ),
            const SizedBox(height: 16),
            buildDropdown(
              label: ProductStrings.gender,
              hint: 'Select Gender',
              items: genders,
              value: _gender,
              onChanged: (value) => setState(() => _gender = value),
            ),
            const SizedBox(height: 16),
            buildTextField(
              label: ProductStrings.petLocation,
              controller: _locationController,
              hint: 'Enter location',
            ),
            const SizedBox(height: 16),
            Text(
              ProductStrings.additionalNotes,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter Additional notes',
                fillColor: CommonColors.inputColor,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: CommonColors.borderColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: CommonColors.borderColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: CommonColors.borderColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              ProductStrings.addYourPetProfile,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      ProductStrings.uploadPhotoes,
                      style: TextStyle(color: Colors.purple),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      Icons.upload_file,
                      color: Colors.purple,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_selectedImage != null)
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: _selectedImage != null
                      ? DecorationImage(
                          image: FileImage(_selectedImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedImage = null;
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CommonColors.appColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
                child: Text(
                  ProductStrings.submit,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
