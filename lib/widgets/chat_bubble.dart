import 'package:flutter/material.dart';
import 'package:supershoes/models/message_model.dart';
import 'package:supershoes/models/product_model.dart';
import 'package:supershoes/utils/extensions.dart';
import 'package:supershoes/utils/theme.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    Widget productPreview() {
      return Container(
        width: 230,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(
          bottom: 12,
        ),
        decoration: BoxDecoration(
          color: !message.user.isStaff ? backgroundColor5 : backgroundColor4,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(!message.user.isStaff ? 0 : 12),
            topLeft: Radius.circular(!message.user.isStaff ? 12 : 0),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: message.product.hasGallery()
                      ? Image.network(
                          message.product.gallery[0].imageUrl,
                          width: 70,
                        )
                      : Image.asset(
                          'assets/image_shoes.png',
                          width: 70,
                        ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.product.name,
                      style: primaryTextStyle,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      message.product.price.toIDR(),
                      style: priceTextStyle.copyWith(fontWeight: medium),
                    ),
                  ],
                ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    side: BorderSide(color: primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: purpleTextStyle,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Buy Now',
                    style: highlightTextStyle,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    return Flexible(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
        ),
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: !message.user.isStaff
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            message.product is! UnitinializedProductModel
                ? productPreview()
                : SizedBox(),
            Row(
              mainAxisAlignment: !message.user.isStaff
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: !message.user.isStaff
                        ? backgroundColor5
                        : backgroundColor4,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(!message.user.isStaff ? 0 : 12),
                      topLeft: Radius.circular(!message.user.isStaff ? 12 : 0),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    message.message,
                    style: primaryTextStyle,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
