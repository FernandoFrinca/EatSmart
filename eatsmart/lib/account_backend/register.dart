import 'package:postgres/postgres.dart';
void db_start(){
  
}
void register_function(String lastname, String firstname, String email, String password, String image, String sex, double height, double weight, String objective, int pantry_id) async {
  final conn = PostgreSQLConnection(
    '10.0.2.2',
    5432,
    'smart',
    username: 'postgres',
    password: 'postgres',
  );
  await conn.open();

  print('Connected to Postgres database...');

  await conn.query('''
    INSERT INTO users (lastname, firstname, email, password, image, sex, height, weight, objective, pantry_id)
    VALUES ('$lastname', '$firstname', '$email', '$password', '$image', '$sex', $height, $weight, '$objective', $pantry_id)
  ''');


}