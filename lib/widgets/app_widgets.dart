import 'package:flutter/material.dart';
import 'package:foddapi/screens/category_details_screen.dart';

Widget categoriesItem(
    {required BuildContext context,
    required String image,
    required String title}) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return CategoryDetailsScreen(
          name: title,
          image: image,
        );
      }));
    },
    child: Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.orange,
        ),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(
            image,
          ),
          fit: BoxFit.contain,
        ),
      ),
      child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          )),
    ),
  );
}
