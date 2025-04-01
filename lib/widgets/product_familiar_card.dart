import 'package:flutter/material.dart';
import 'package:supershoes/models/product_model.dart';

class ProductFamiliarCard extends StatelessWidget {
  final ProductModel product;

  const ProductFamiliarCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      margin: EdgeInsets.only(
        right: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        image: DecorationImage(
          image: product.hasGallery()
              ? NetworkImage(
                  product.gallery[0].imageUrl,
                )
              : AssetImage('assets/image_shoes.png'),
        ),
      ),
    );
  }
}
