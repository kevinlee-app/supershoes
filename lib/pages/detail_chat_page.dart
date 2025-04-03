import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supershoes/models/message_model.dart';
import 'package:supershoes/models/product_model.dart';
import 'package:supershoes/providers/auth_provider.dart';
import 'package:supershoes/services/message_service.dart';
import 'package:supershoes/utils/extensions.dart';
import 'package:supershoes/utils/theme.dart';
import 'package:supershoes/widgets/chat_bubble.dart';

class DetailChatPage extends StatefulWidget {
  const DetailChatPage({super.key});

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  bool isProductPreviewVisible = true;
  bool isFirstLoad = true;

  TextEditingController messageController = TextEditingController(text: '');
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: isFirstLoad ? 1200 : 400),
        curve: Curves.ease,
      );
      isFirstLoad = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    ProductModel product = args['product'] as ProductModel;

    void sendMessage() async {
      if (messageController.text.isEmpty) {
        return;
      }

      bool shouldAddProduct =
          isProductPreviewVisible && product is! UnitinializedProductModel;
      await MessageService().addMessage(
          user,
          shouldAddProduct ? product : UnitinializedProductModel(),
          messageController.text);

      setState(() {
        isProductPreviewVisible = false;
        messageController.clear();
      });
    }

    PreferredSizeWidget header() {
      return PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          iconTheme: IconThemeData(
            color: primaryTextColor,
          ),
          backgroundColor: backgroundColor1,
          centerTitle: false,
          title: Row(
            children: [
              Image.asset(
                'assets/image_shop_logo_online.png',
                width: 50,
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shoe Store',
                    style: primaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    'Online',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: light,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget productPreview() {
      return Container(
        width: 225,
        height: 74,
        margin: EdgeInsets.only(
          bottom: 20,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor5,
          border: Border.all(
            color: primaryColor,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: product.hasGallery()
                  ? Image.network(
                      product.gallery[0].imageUrl,
                      width: 54,
                    )
                  : Image.asset(
                      'assets/image_shoes.png',
                      width: 54,
                    ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: primaryTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    product.price.toIDR(),
                    style: priceTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => {
                setState(() {
                  isProductPreviewVisible = false;
                })
              },
              child: Image.asset(
                'assets/button_close.png',
                width: 22,
              ),
            ),
          ],
        ),
      );
    }

    Widget chatInput() {
      return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !isProductPreviewVisible || product is UnitinializedProductModel
                ? SizedBox()
                : productPreview(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: backgroundColor4,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      controller: messageController,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Type message',
                        hintStyle: subtitleTextStyle,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: sendMessage,
                  child: Image.asset(
                    'assets/button_send.png',
                    width: 45,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget content() {
      return StreamBuilder<List<MessageModel>>(
          stream: MessageService().getMessageByUserId(user.id),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.delayed(Duration(milliseconds: isFirstLoad ? 500 : 0), _scrollToBottom);
              });
              return ListView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                  ),
                  children: snapshot.data!
                      .map((message) => ChatBubble(message: message))
                      .toList());
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      bottomNavigationBar: chatInput(),
      body: content(),
    );
  }
}
