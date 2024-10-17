import 'package:flutter/material.dart';
import 'package:recipe_book_ai/utils/titles.dart';

class RecipeDetailScreen extends StatefulWidget {
  final int index;

  const RecipeDetailScreen({
    super.key,
    required this.index,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  var list = <String>[];

  void changeCheckboxValue(int index, bool? value) {
    setState(() {
      if (value!) {
        list.add('${titles[0]} $index');
      } else {
        list.remove('${titles[0]} $index');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const int tabsCount = 2;
    return DefaultTabController(
      initialIndex: 0,
      length: tabsCount,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Color(0xFFFFFFFF),
          shape: const CircleBorder(),
          onPressed: () async {
            final TextEditingController textController =
                TextEditingController();

            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Add Ingredient'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                          labelText: 'Enter the ingredient',
                        ),
                      ),
                      Row(
                        children: [
                          Text('Quantity '),
                          DropdownButton(
                              value: 'Item 1',
                              items: const <DropdownMenuItem>[
                                DropdownMenuItem(
                                    value: 'Item 1', child: Text('lbs')),
                                DropdownMenuItem(
                                    value: 'Item 2', child: Text('kg')),
                                DropdownMenuItem(
                                    value: 'Item 3', child: Text('ml')),
                              ],
                              onChanged: (value) {
                                print(value);
                              })
                        ],
                      )
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          list.add(textController.text);
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Recipe Title ${widget.index}'),
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: const Icon(Icons.shopping_cart),
                text: titles[0],
              ),
              Tab(
                icon: const Icon(Icons.soup_kitchen),
                text: titles[1],
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          RecipePrepItems(
            list: list,
            changeCheckboxValue: changeCheckboxValue,
          ),
          const Icon(Icons.soup_kitchen),
        ]),
      ),
    );
  }
}

class RecipePrepItems extends StatelessWidget {
  final List<String> list;
  final void Function(int, bool?) changeCheckboxValue;

  const RecipePrepItems({
    super.key,
    required this.list,
    required this.changeCheckboxValue,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.10);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    return ListView.builder(
      itemCount: 25,
      itemBuilder: (BuildContext context, int index) {
        return PrepItem(
            oddItemColor: oddItemColor,
            evenItemColor: evenItemColor,
            list: list,
            index: index,
            changeCheckboxValue: changeCheckboxValue);
      },
    );
  }
}

class PrepItem extends StatelessWidget {
  const PrepItem({
    super.key,
    required this.oddItemColor,
    required this.evenItemColor,
    required this.list,
    required this.index,
    required this.changeCheckboxValue,
  });

  final Color oddItemColor;
  final Color evenItemColor;
  final List<String> list;
  final int index;
  final void Function(int, bool?) changeCheckboxValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: index.isOdd ? oddItemColor : evenItemColor,
          border: Border.all(
            color: index.isOdd ? oddItemColor : evenItemColor,
            width: 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            Checkbox(
              value: list.contains('${titles[0]} $index'),
              onChanged: (bool? value) {
                changeCheckboxValue(index, value);
              },
            ),
            Text(
              list.contains('${titles[0]} $index')
                  ? '${titles[0]} $index'
                  : '${titles[0]} $index',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                decoration: list.contains('${titles[0]} $index')
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
