import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name, price, image;
  const ProductCard({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: image,
            child: Container(
              height: 175,
              width: 160,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              name,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            "\$$price",
            style: const TextStyle(
                color: Colors.black87, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
