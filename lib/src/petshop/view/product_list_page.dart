import 'package:pet_shop/src/allpackage.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => ProductListPageState();
}

class ProductListPageState extends State<ProductListPage> {
  var petController = Get.put(PetController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      petController.fetchPetList();
    });
    // petController.fetchPetList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 50),
            Expanded(
              child: GetBuilder<PetController>(
                id: 'petPage',
                builder: (_) {
                  var list = petController.productListResponse?.data ?? [];
                  if (list.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/nodata.png',
                            width: 316,
                            height: 316,
                          ),
                          const Text(
                            ProductStrings.oppsYourPetListIsEmpty,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20,
                      childAspectRatio: 3 / 3,
                    ),
                    itemCount:
                        petController.productListResponse?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final product =
                          petController.productListResponse?.data?[index];
                      return Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: CommonColors.borderColor,
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                  child: Image.network(
                                    product?.image ?? '',
                                    height: 110,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: Text(
                                    product?.petName ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.grey,
                                        size: 16,
                                      ),
                                      Text(
                                        product?.location ?? '',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 15,
                            right: 10,
                            child: CircleAvatar(
                              maxRadius: 18,
                              backgroundColor:
                                  const Color.fromARGB(255, 206, 206, 206),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 40,
                            right: 4,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                maxRadius: 18,
                                backgroundColor: product?.gender == 'male'
                                    ? const Color.fromARGB(255, 254, 224, 237)
                                    : const Color.fromARGB(255, 187, 217, 243),
                                child: Icon(
                                  product?.gender == 'male'
                                      ? Icons.male
                                      : Icons.female,
                                  color: product?.gender == 'male'
                                      ? Colors.pink
                                      : Colors.blue,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ComonButton(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
