import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supershoes/models/product_model.dart';
import 'package:supershoes/providers/wishlist_provider.dart';
import 'package:supershoes/utils/string_extension.dart';
import 'package:supershoes/utils/theme.dart';

class WishlistCard extends StatelessWidget {
  final ProductModel product;
  const WishlistCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      padding: EdgeInsets.only(
        top: 10,
        left: 12,
        bottom: 14,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor4,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: product.hasGallery()
                ? Image.network(
                    product.gallery[0].imageUrl,
                    width: 60,
                  )
                : Image.asset(
                    'assets/image_shoes.png',
                    width: 60,
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
                  product.name,
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  product.price.toIDR(),
                  style: priceTextStyle,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => wishlistProvider.setProduct(product),
            child: Image.asset(
              'assets/image_wishlist_blue.png',
              width: 34,
            ),
          ),
        ],
      ),
    );
  }
}
