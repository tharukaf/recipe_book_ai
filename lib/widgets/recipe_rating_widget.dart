import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:recipe_book_ai/models/recipe.dart';

class RecipeRatingWidget extends StatelessWidget {
  final Recipe recipe;
  final void Function(double)? handleRatingChange;

  const RecipeRatingWidget({
    super.key,
    required this.recipe,
    this.handleRatingChange,
  });

  @override
  Widget build(BuildContext context) {
    return PannableRatingBar(
        rate: recipe.rating?.toDouble() ?? 0,
        items: List.generate(
            5,
            (index) => RatingWidget(
                  selectedColor: Colors.pink[400]!,
                  unSelectedColor: Colors.grey[400]!,
                  child: const Icon(
                    Icons.star,
                    size: 20,
                  ),
                )),
        onChanged: handleRatingChange);
  }
}
