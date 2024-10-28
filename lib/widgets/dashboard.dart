import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_ai/models/recipe.dart';
import 'package:recipe_book_ai/models/recipes.dart';
import 'package:recipe_book_ai/widgets/recipe_list_tile.dart';
import 'package:recipe_book_ai/widgets/responsive_layout.dart';
import 'package:searchable_listview/searchable_listview.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Column(
        children: [
          Expanded(
            child: Consumer<Recipes>(
              builder: (context, recipes, child) => Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: SearchableList<Recipe>(
                  spaceBetweenSearchAndList: 12,
                  style: GoogleFonts.deliusSwashCaps(
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  displaySearchIcon: false,
                  initialList: Provider.of<Recipes>(context).recipes,
                  itemBuilder: (Recipe recipe) =>
                      RecipleListTile(recipe: recipe),
                  filter: (value) => recipes.recipes
                      .where(
                        (element) =>
                            element.title.toLowerCase().contains(value),
                      )
                      .toList(),
                  emptyWidget: const EmptyView(),
                  inputDecoration: InputDecoration(
                    labelText: 'Search for recipes',
                    hintStyle: GoogleFonts.deliusSwashCaps(
                      color: const Color.fromARGB(122, 255, 255, 255),
                    ),
                    labelStyle: GoogleFonts.deliusSwashCaps(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      // fontSize: 20,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No recipes found',
          style:
              GoogleFonts.deliusSwashCaps(fontSize: 20, color: Colors.white)),
    );
  }
}
