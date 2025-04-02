import 'package:flutter/material.dart';
import 'package:supershoes/models/product_model.dart';
import 'package:supershoes/utils/extensions.dart';
import 'package:supershoes/utils/theme.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: {'product': product});
      },
      child: Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: !product.hasGallery()
                  ? Image.asset(
                      'assets/image_shoes.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      product.gallery[0].imageUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.name,
                    style: secondaryTextStyle.copyWith(fontSize: 12),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    product.name,
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    product.price.toIDR(),
                    style: priceTextStyle.copyWith(fontWeight: medium),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
