import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supershoes/models/category_model.dart';
import 'package:supershoes/providers/home_provider.dart';
import 'package:supershoes/utils/theme.dart';

class CategoryButton extends StatelessWidget {
  final CategoryModel category;

  const CategoryButton({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return GestureDetector(
      onTap: () {
        homeProvider.currentCategoryId = category.id;
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: homeProvider.currentCategoryId == category.id
                  ? primaryColor
                  : subtitleColor),
          color: homeProvider.currentCategoryId == category.id
              ? primaryColor
              : transparentColor,
        ),
        child: Text(
          category.name,
          style: (homeProvider.currentCategoryId == category.id
                  ? primaryTextStyle
                  : subtitleTextStyle)
              .copyWith(
            fontSize: 13,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
