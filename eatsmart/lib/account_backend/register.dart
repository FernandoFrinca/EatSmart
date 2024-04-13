import 'package:postgres/postgres.dart';
void db_start(){
  
}
void register_function(String lastname, String firstname, String email, String password, String image, String sex, double height, double weight, String objective, int pantry_id) async {
  
  bool add_flag_lastname = true;
  bool add_flag_firstname = true;
  bool add_flag_email = true;
  bool add_flag_password = true;
  bool add_flag_image = true;
  bool add_flag_sex = true;
  bool add_flag_height = true;
  bool add_flag_weight = true;
  bool add_flag_objective = true;
  bool add_flag_pantry = true;
  String hashedPassword="";
  //conect to database
  final conn = PostgreSQLConnection(
    '10.0.2.2',
    5432,
    'smart',
    username: 'postgres',
    password: 'postgres',
  );
  await conn.open();
  print('Connected to Postgres database...');

try{
  //password hash
    if(password != "") {
      hashedPassword = password.hashCode.toString();
    } else{
      add_flag_password = false;
    }

  //email unic
    final List<List<dynamic>> emails_lists = await conn.query('SELECT email FROM users');
    final List<String> emails = [];

    for (final row in emails_lists) {
      final email = row[0].toString();
      emails.add(email);
    }

    int i;
    for(i = 0; i < emails.length; i++){
      if(emails[i] == email){
        add_flag_email = false;
      }
    }
    if(email == ""){
      add_flag_email = false;
    }
    if(add_flag_email){
      print("\n email ok\n");
    }

    //add element to the database
    if(add_flag_lastname && add_flag_firstname && add_flag_email && add_flag_password && add_flag_image && add_flag_sex && add_flag_height && add_flag_weight && add_flag_objective && add_flag_pantry){
      await conn.query('''
        INSERT INTO users (lastname, firstname, email, password, image, sex, height, weight, objective, pantry_id)
        VALUES ('$lastname', '$firstname', '$email', '$hashedPassword', '$image', '$sex', $height, $weight, '$objective', $pantry_id)
      ''');
    }
    else{
      print("register fail");
    }
  }
catch(e){
  print("register fail");
}

  await conn.close();
}