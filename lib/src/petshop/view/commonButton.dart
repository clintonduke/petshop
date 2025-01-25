import 'package:pet_shop/src/allpackage.dart';

class ComonButton extends StatelessWidget {
  const ComonButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.to(const AddProductPage());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.camera_alt, color: Colors.black),
            SizedBox(width: 10),
            Text(
              ProductStrings.addNewPet,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
