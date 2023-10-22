import 'package:flutter/material.dart';

class Feature_box extends StatelessWidget {
  final String Title, description;
  final Color color;
  const Feature_box(
      {super.key,
      required this.Title,
      required this.color,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 5, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Title,
                style: const TextStyle(
                    fontFamily: 'Cera Pro',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 20),
                child: Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'Cera Pro',
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
