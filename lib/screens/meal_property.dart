// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:foddapi/models/category_detail_model.dart';
// import 'package:foddapi/models/category_meals.dart';
// import 'package:foddapi/screens/category_details_screen.dart';

// class CategoryMealsScreen extends StatefulWidget {
//   const CategoryMealsScreen({
//     super.key,
//     required this.name,
//     required this.category,
//     required this.image,
//   });

//   final String name;
//   final String image;
//   final String category;

//   @override
//   State<StatefulWidget> createState() => _CategoryMealsScreenState();
// }

// class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
//   final dio = Dio();
//   late CategoryMeals categoryMeals;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     getCategoriesMeal();
//   }

//   Future<void> getCategoriesMeal() async {
//     try {
//       final response = await dio.get(
//         'https://themealdb.com/api/json/v1/1/filter.php?c=${widget.name}',
//       );
//       setState(() {
//         categoryMeals = CategoryMeals.fromJson(response.data);
//         isLoading = false;
//       });
//     } catch (e) {
//       print('Error fetching categories: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : Column(
//               children: [
//                 Container(
//                   width: width,
//                   height: height * 0.4,
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(20),
//                       bottomRight: Radius.circular(20),
//                     ),
//                     color: Colors.grey,
//                     image: DecorationImage(
//                       image: NetworkImage(widget.image),
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   child: Align(
//                     alignment: Alignment.topCenter,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: const Icon(Icons.arrow_back),
//                         ),
//                         IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.menu),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     height: height * 0.57,
//                     child: ListView.builder(
//                       padding: EdgeInsets.all(0),
//                       itemCount: categoryMeals.meals!.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) => CategoryDetailsScreen(
//                                   name:
//                                       categoryMeals.meals![index].strMeal ?? '',
//                                   image: categoryMeals
//                                           .meals![index].strMealThumb ??
//                                       '',
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   width: width * 0.2,
//                                   height: width * 0.2,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     image: DecorationImage(
//                                       image: NetworkImage(
//                                         categoryMeals
//                                                 .meals![index].strMealThumb ??
//                                             'https://img.freepik.com/free-photo/side-view-shawarma-with-fried-potatoes-board-cookware_176474-3215.jpg?ga=GA1.1.1077507535.1671579631&semt=ais_hybrid',
//                                       ),
//                                       fit: BoxFit.contain,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: width * 0.02),
//                                 SizedBox(
//                                   width: width * 0.7,
//                                   child: Text(
//                                     categoryMeals.meals![index].strMeal ?? '',
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foddapi/models/category_meals.dart';

class CategoryMealsScreen extends StatefulWidget {
  final String name;
  final String image;
  final String category;

  const CategoryMealsScreen({
    super.key,
    required this.name,
    required this.image,
    required this.category,
  });

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  final dio = Dio();
  CategoryMeals categoryMeals = CategoryMeals();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCategoriesMeals();
  }

  Future<void> getCategoriesMeals() async {
    try {
      final response = await dio.get(
        'https://www.themealdb.com/api/json/v1/1/search.php?s=${widget.name}',
      );
      print(response);
      setState(() {
        categoryMeals = CategoryMeals.fromJson(response.data);
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
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.7,
                              child: Text(
                                widget.name,
                                maxLines: 4,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "\$50",
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 30),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Area: ${categoryMeals.meals![0].strArea}',
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Instruction",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        '${categoryMeals.meals![0].strInstructions}',
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 20,
                        ),
                      ),
                      Center(
                          child: Container(
                        width: width * 0.4,
                        height: height * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Add To Cart",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
