import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foddapi/models/category_model.dart';
import 'package:foddapi/widgets/app_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dio = Dio();
  late Category category;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  Future<void> getCategories() async {
    try {
      final response = await dio
          .get('https://www.themealdb.com/api/json/v1/1/categories.php');
      setState(() {
        category = Category.fromJson(response.data);
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Food Menu",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Center(
                      child: Text(
                        "Choose your best food have a great day",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: height * 0.75,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: category.categories?.length ?? 0,
                        itemBuilder: (context, index) {
                          return categoriesItem(
                              context: context,
                              image: category
                                      .categories![index].strCategoryThumb ??
                                  "https://img.freepik.com/free-photo/side-view-shawarma-with-fried-potatoes-board-cookware_176474-3215.jpg?ga=GA1.1.1077507535.1671579631&semt=ais_hybrid",
                              title: category.categories![index].strCategory ??
                                  'No Name');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
