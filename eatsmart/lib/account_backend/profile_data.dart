// ignore_for_file: non_constant_identifier_names, avoid_print
import 'package:postgres/postgres.dart';

Future<String> get_firstName(int ID) async {
  final conn = PostgreSQLConnection(
    '10.0.2.2', 
    5432,
    'smart',
    username: 'postgres',
    password: 'postgres',
  );

  String extractedName = "";

  try {
    await conn.open();
    print('Connected to the Postgres database...');

    var result = await conn.query(
      'SELECT firstname FROM users WHERE id = @id',
      substitutionValues: {'id': ID}
    );

    if (result.isNotEmpty) {
      extractedName = result.first[0] as String;
      print("User's first name: $extractedName");
    } else {
      print("No user found with ID: $ID");
      extractedName = "No user found";
    }
  } catch (e) {
    print('Failed to connect or execute query: $e');
  } finally {
    await conn.close();
    print('Database connection closed.');
  }

  return extractedName;
}

Future<String> get_lastName(int ID) async {
  final conn = PostgreSQLConnection(
    '10.0.2.2', 
    5432,
    'smart',
    username: 'postgres',
    password: 'postgres',
  );

  String extractedName = "";

  try {
    await conn.open();
    print('Connected to the Postgres database...');

    var result = await conn.query(
      'SELECT lastname FROM users WHERE id = @id',
      substitutionValues: {'id': ID}
    );

    if (result.isNotEmpty) {
      extractedName = result.first[0] as String;
      print("User's first name: $extractedName");
    } else {
      print("No user found with ID: $ID");
      extractedName = "No user found";
    }
  } catch (e) {
    print('Failed to connect or execute query: $e');
  } finally {
    await conn.close();
    print('Database connection closed.');
  }

  return extractedName;
}


Future<String> get_email(int ID) async {
  final conn = PostgreSQLConnection(
    '10.0.2.2', 
    5432,
    'smart',
    username: 'postgres',
    password: 'postgres',
  );

  String extractedEmail = "";

  try {
    await conn.open();
    print('Connected to the Postgres database email...');

    var result = await conn.query(
      'SELECT email FROM users WHERE id = @id',
      substitutionValues: {'id': ID}
    );

    if (result.isNotEmpty) {
      extractedEmail = result.first[0] as String;
      print("User's email: $extractedEmail");
    } else {
      print("No user found with ID: $ID");
      extractedEmail = "No email found";
    }
  } catch (e) {
    print('Failed to connect or execute query: $e');
  } finally {
    await conn.close();
    print('Database connection closed.');
  }

  return extractedEmail;
}

Future<String> get_sex(int ID) async {
  final conn = PostgreSQLConnection(
    '10.0.2.2', 
    5432,
    'smart',
    username: 'postgres',
    password: 'postgres',
  );

  String extractedSex = "";

  try {
    await conn.open();
    print('Connected to the Postgres database sex...');

    var result = await conn.query(
      'SELECT sex FROM users WHERE id = @id',
      substitutionValues: {'id': ID}
    );

    if (result.isNotEmpty) {
      extractedSex = result.first[0] as String;
      print("User's sex: $extractedSex");
    } else {
      print("No user found with ID: $ID");
      extractedSex = "No sex found";
    }
  } catch (e) {
    print('Failed to connect or execute query: $e');
  } finally {
    await conn.close();
    print('Database connection closed.');
  }

  return extractedSex;
}

Future<double> get_height(int ID) async {
  final conn = PostgreSQLConnection(
    '10.0.2.2', 
    5432,
    'smart',
    username: 'postgres',
    password: 'postgres',
  );

  double extractedHeight = 0;

  try {
    await conn.open();
    print('Connected to the Postgres database...');

    var result = await conn.query(
      'SELECT height FROM users WHERE id = @id',
      substitutionValues: {'id': ID}
    );

    if (result.isNotEmpty) {
      var height = result.first[0] as num;
      extractedHeight = double.parse(height.toStringAsFixed(2));
      print("User's extractedHeight: $extractedHeight");
    } else {
      print("No user found with ID: $ID");
      extractedHeight = 0.00;
    }
  } catch (e) {
    print('Failed to connect or execute query: $e');
  } finally {
    await conn.close();
    print('Database connection closed.');
  }

  return extractedHeight;
}

Future<double> get_weight(int ID) async {
  final conn = PostgreSQLConnection(
    '10.0.2.2', 
    5432,
    'smart',
    username: 'postgres',
    password: 'postgres',
  );

  double extractedWeight = 0;

  try {
    await conn.open();
    print('Connected to the Postgres database...');

    var result = await conn.query(
      'SELECT weight FROM users WHERE id = @id',
      substitutionValues: {'id': ID}
    );

    if (result.isNotEmpty) {
      var weight = result.first[0] as num;
      extractedWeight = double.parse(weight.toStringAsFixed(2));
      print("User's extractedWeight: $extractedWeight");
    } else {
      print("No user found with ID: $ID");
      extractedWeight = 0.00;
    }
  } catch (e) {
    print('Failed to connect or execute query: $e');
  } finally {
    await conn.close();
    print('Database connection closed.');
  }

  return extractedWeight;
}

Future<String> get_objective(int ID) async {
  final conn = PostgreSQLConnection(
    '10.0.2.2', 
    5432,
    'smart',
    username: 'postgres',
    password: 'postgres',
  );

  String extractedObjective = "";

  try {
    await conn.open();
    print('Connected to the Postgres database objective...');

    var result = await conn.query(
      'SELECT objective FROM users WHERE id = @id',
      substitutionValues: {'id': ID}
    );

    if (result.isNotEmpty) {
      extractedObjective = result.first[0] as String;
      print("User's objective: $extractedObjective");
    } else {
      print("No user found with ID: $ID");
      extractedObjective = "No objective found";
    }
  } catch (e) {
    print('Failed to connect or execute query: $e');
  } finally {
    await conn.close();
    print('Database connection closed.');
  }

  return extractedObjective;
}

Future<bool> updateUserData(
    int userId,
    String? lastname,
    String? firstname,
    String? email,
    String? password,
    String? confirmPassword,
    String? image,
    String? sex,
    double? height,
    double? weight,
    String? objective,
    int? pantryId
) async {
    bool updateFlag = true;
    String hashedPassword = "";

    final conn = PostgreSQLConnection(
        '10.0.2.2',
        5432,
        'smart',
        username: 'postgres',
        password: 'postgres',
    );
    await conn.open();
    print('Connected to Postgres database...');

    try {
        final userExists = await conn.query(
            'SELECT COUNT(*) FROM users WHERE id = @userId',
            substitutionValues: {
                'userId': userId
            }
        );

        if (userExists[0][0] == 0) {
            print("User not found.");
            updateFlag = false;
        } else {
            
            List<String> updates = [];
            Map<String, dynamic> substitutionValues = {'userId': userId};

            if (password != null && confirmPassword != null) {
                if (password == confirmPassword) {
                    hashedPassword = password.hashCode.toString();
                    updates.add('password = @hashedPassword');
                    substitutionValues['hashedPassword'] = hashedPassword;
                } else {
                    print("Password and confirm password do not match.");
                    updateFlag = false;
                }
            }

            if (lastname != null) { updates.add('lastname = @lastname'); substitutionValues['lastname'] = lastname; }
            if (firstname != null) { updates.add('firstname = @firstname'); substitutionValues['firstname'] = firstname; }
            if (email != null) { updates.add('email = @email'); substitutionValues['email'] = email; }
            if (image != null) { updates.add('image = @image'); substitutionValues['image'] = image; }
            if (sex != null) { updates.add('sex = @sex'); substitutionValues['sex'] = sex; }
            if (height != null) { updates.add('height = @height'); substitutionValues['height'] = height; }
            if (weight != null) { updates.add('weight = @weight'); substitutionValues['weight'] = weight; }
            if (objective != null) { updates.add('objective = @objective'); substitutionValues['objective'] = objective; }
            if (pantryId != null) { updates.add('pantry_id = @pantryId'); substitutionValues['pantryId'] = pantryId; }

            if (updates.isNotEmpty && updateFlag) {
                String query = 'UPDATE users SET ' + updates.join(', ') + ' WHERE id = @userId';
                await conn.query(query, substitutionValues: substitutionValues);
            }
        }

        await conn.close();
        return updateFlag;
    } catch (e) {
        await conn.close();
        print("Update failed: ${e.toString()}");
        return false;
    }
}

