import 'package:flutter/material.dart';
import 'package:supershoes/theme.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  final bool hasProduct;

  ChatBubble(
      {super.key,
      this.isSender = false,
      this.text = '',
      this.hasProduct = false});

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
          color: isSender ? backgroundColor5 : backgroundColor4,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(isSender ? 0 : 12),
            topLeft: Radius.circular(isSender ? 12 : 0),
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
                  child: Image.asset(
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
                      'COURT VISION 2.0 SHOES',
                      style: primaryTextStyle,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '\$57,15',
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
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            hasProduct ? productPreview() : SizedBox(),
            Row(
              mainAxisAlignment:
                  isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSender ? backgroundColor5 : backgroundColor4,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(isSender ? 0 : 12),
                      topLeft: Radius.circular(isSender ? 12 : 0),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    text,
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
