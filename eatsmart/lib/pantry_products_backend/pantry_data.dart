import 'package:eatsmart/pantry_products_backend/type.dart';
import 'package:postgres/postgres.dart';

Future<List<Pantry>> getPantryData(int id_user) async {
  List<Pantry> pantries = [];
  PostgreSQLConnection conn;

  try {
    conn = PostgreSQLConnection(
      '10.0.2.2',
      5432,
      'smart',
      username: 'postgres',
      password: 'postgres',
    );
    await conn.open();
    print('Connected to Postgres database pantry...');

    final results = await conn.query(
      'SELECT id, name FROM pantries WHERE user_id = @id_user',
      substitutionValues: {'id_user': id_user}
    );

    for (final row in results) {
      int pantryId = row[0] as int;
      String pantryName = row[1] as String;
      List<PantryItem> items = []; 

      final results_pantry = await conn.query(
        'SELECT id, name, count, quantity, pantry_id FROM products WHERE pantry_id = @id_pantry',
        substitutionValues: {'id_pantry': pantryId}
      );

      for (final row_pantry in results_pantry) {
        PantryItem item = PantryItem(
          row_pantry[0] as int,
          row_pantry[2] as int,
          row_pantry[4] as int,
          name: row_pantry[1] as String,
          quantity: row_pantry[3] as String
        );
        items.add(item);
      }

      pantries.add(Pantry(
        id: pantryId,
        name: pantryName,
        items: items
      ));
    }
  } catch (e) {
    print('Error connecting to the database: $e');
  }

  return pantries;
}


Future<void> deletePantryData(int id_item) async {
  PostgreSQLConnection conn;
  try {
    conn = PostgreSQLConnection(
      '10.0.2.2',
      5432,
      'smart',
      username: 'postgres',
      password: 'postgres',
    );
    await conn.open();
    print('Connected to Postgres database pantry delete...');

    await conn.query(
      'DELETE FROM products WHERE id = @id_item',
      substitutionValues: {'id_item': id_item}
    );

    print('Deleted item with id $id_item successfully.');

  } catch (e) {
    print('Error deleting the item: $e');
  } 
}

Future<void> updatePantryItem (int id_item, String name, int count, String quantity) async {
  PostgreSQLConnection conn;
  try {
    conn = PostgreSQLConnection(
      '10.0.2.2',
      5432,
      'smart',
      username: 'postgres',
      password: 'postgres',
    );
    await conn.open();
    print('Connected to Postgres database pantry delete...');

    await conn.query(
      'UPDATE products SET name = @new_name, count = @new_count, quantity = @new_quantity WHERE id = @id_item',
      substitutionValues: {
        'new_name': name,
        'new_count': count,
        'new_quantity':quantity,
        'id_item': id_item
      }
    );

    print('Updated item with id $id_item successfully.');

  } catch (e) {
    print('Error editing the item: $e');
  } 
}

Future<void> updatePantry (int id_pantry, String name) async {
  PostgreSQLConnection conn;
  try {
    conn = PostgreSQLConnection(
      '10.0.2.2',
      5432,
      'smart',
      username: 'postgres',
      password: 'postgres',
    );
    await conn.open();
    print('Connected to Postgres database pantry delete...');

    await conn.query(
      'UPDATE pantries SET name = @new_name WHERE id = @id_pantry',
      substitutionValues: {
        'new_name': name,
        'id_pantry': id_pantry,
      }
    );

    print('Updated pantry with id $id_pantry successfully.');

  } catch (e) {
    print('Error editing the pantry: $e');
  } 
}

Future<void> deletePantry(int id_pantry) async {
  PostgreSQLConnection conn;
  try {
    conn = PostgreSQLConnection(
      '10.0.2.2',
      5432,
      'smart',
      username: 'postgres',
      password: 'postgres',
    );
    await conn.open();
    print('Connected to Postgres database for pantry delete...');

    await conn.transaction((ctx) async {
      await ctx.query(
        'DELETE FROM products WHERE pantry_id = @id_deleted',
        substitutionValues: {'id_deleted': id_pantry}
      );

      await ctx.query(
        'DELETE FROM pantries WHERE id = @id_deleted',
        substitutionValues: {'id_deleted': id_pantry}
      );
    });

    print('Deleted pantry and all associated products with pantry id $id_pantry successfully.');

  } catch (e) {
    print('Error deleting the item: $e');
  }
}

Future<void> addPantry(String name, int id_user) async {
  PostgreSQLConnection conn;
  try {
    conn = PostgreSQLConnection(
      '10.0.2.2',
      5432,
      'smart',
      username: 'postgres',
      password: 'postgres',
    );
    await conn.open();
    print('Connected to Postgres database for adding a pantry...');

    await conn.query(
      'INSERT INTO pantries (name, user_id) VALUES (@name, @user_id)',
      substitutionValues: {
        'name': name,
        'user_id': id_user
      }
    );

    print('Pantry added successfully.');
  } catch (e) {
    print('Error adding the pantry: $e');
  } 

}

Future<void> addProduct(String name, int pantry_id, int count, String quantity) async {
  PostgreSQLConnection conn;
  try {
    conn = PostgreSQLConnection(
      '10.0.2.2',
      5432,
      'smart',
      username: 'postgres',
      password: 'postgres',
    );
    await conn.open();
    print('Connected to Postgres database for adding a protuct...');

    await conn.query(
      'INSERT INTO products (name, count, quantity, pantry_id) VALUES (@name, @count, @quantity, @pantry_id)',
      substitutionValues: {
        'name': name,
        'count': count,
        'quantity': quantity,
        'pantry_id': pantry_id
      }
    );

    print('product added successfully.');
  } catch (e) {
    print('Error adding the product: $e');
  } 

}
