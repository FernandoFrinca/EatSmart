import 'package:flutter/material.dart';

class CatalogPage extends StatelessWidget {
  final List<Category> categories = [
    Category('Grocery', Icons.local_grocery_store),
    Category('American', Icons.local_pizza),
    Category('Specialty', Icons.emoji_food_beverage),
    Category('Asian', Icons.ramen_dining),
    Category('Sweet', Icons.icecream),
    Category('Halal', Icons.restaurant_menu),
    Category('Caribbean', Icons.deck),
    Category('Indian', Icons.rice_bowl),
    Category('French', Icons.cake),
    Category('Fast Foods', Icons.fastfood),
    Category('Burger', Icons.lunch_dining),
    Category('Chinese', Icons.soup_kitchen),
    Category('Dessert', Icons.cookie),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Categories'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(category: categories[index]);
        },
      ),
    );
  }
}

class Category {
  final String name;
  final IconData icon;

  Category(this.name, this.icon);
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Directare catre categorie
      },
      child: Card(
        elevation: 2.0,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(category.icon, size: 48.0),
              SizedBox(height: 10),
              Text(
                category.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
