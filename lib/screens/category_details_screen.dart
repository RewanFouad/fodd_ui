import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foddapi/models/category_detail_model.dart';
import 'package:foddapi/models/category_meals.dart';

import 'package:foddapi/screens/meal_property.dart';
import 'package:foddapi/widgets/widgets.dart';

class CategoryDetailsScreen extends StatefulWidget {
  const CategoryDetailsScreen({
    super.key,
    required this.name,
    required this.image,
  });

  final String name;
  final String image;

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  final dio = Dio();
  late CategoryDetail categoryDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCategoriesDetail();
  }

  Future<void> getCategoriesDetail() async {
    try {
      final response = await dio.get(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=${widget.name}',
      );
      setState(() {
        categoryDetail = CategoryDetail.fromJson(response.data);
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
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  width: width,
                  height: height * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.menu),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: categoryDetail.meals?.length ?? 0,
                      itemBuilder: (context, index) {
                        final meal = categoryDetail.meals![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryMealsScreen(
                                    name: meal.strMeal ?? 'Meal Name',
                                    image: meal.strMealThumb ??
                                        'https://img.freepik.com/free-photo/side-view-shawarma-with-fried-potatoes-board-cookware_176474-3215.jpg?ga=GA1.1.1077507535.1671579631&semt=ais_hybrid',
                                    category: widget.name,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: width * 0.19,
                                  height: width * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        meal.strMealThumb ??
                                            'https://img.freepik.com/free-photo/side-view-shawarma-with-fried-potatoes-board-cookware_176474-3215.jpg?ga=GA1.1.1077507535.1671579631&semt=ais_hybrid',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: width * 0.02),
                                SizedBox(
                                  width: width * 0.7,
                                  child: Text(
                                    meal.strMeal ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
