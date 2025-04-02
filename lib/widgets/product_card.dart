import 'package:flutter/material.dart';
import 'package:supershoes/models/product_model.dart';
import 'package:supershoes/utils/extensions.dart';
import 'package:supershoes/utils/theme.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: {'product': product});
      },
      child: Container(
        width: 215,
        height: 278,
        margin: EdgeInsets.only(right: defaultMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: shoesBackground,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            !product.hasGallery()
                ? Image.asset(
                    'assets/image_shoes.png',
                    width: 215,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    product.gallery[0].imageUrl,
                    width: 215,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
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
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      product.price.toIDR(),
                      style: priceTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
