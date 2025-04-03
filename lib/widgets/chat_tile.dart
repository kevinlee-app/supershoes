import 'package:flutter/material.dart';
import 'package:supershoes/models/message_model.dart';
import 'package:supershoes/models/product_model.dart';
import 'package:supershoes/utils/theme.dart';

class ChatTile extends StatelessWidget {
  final MessageModel message;
  const ChatTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail-chat',
            arguments: {'product': UnitinializedProductModel()});
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 33,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/image_shop_logo.png',
                  width: 54,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shoe Store',
                        style: primaryTextStyle.copyWith(fontSize: 15),
                      ),
                      Text(
                        message.message,
                        style: secondaryTextStyle.copyWith(fontWeight: light),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Now',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Divider(
              thickness: 1,
              color: dividerColor,
            ),
          ],
        ),
      ),
    );
  }
}
