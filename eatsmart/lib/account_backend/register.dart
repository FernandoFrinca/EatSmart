import 'package:postgres/postgres.dart';
void db_start(){
  
}
Future<bool> register_function(String lastname, String firstname, String email, String password, String image, String sex, double height, double weight, String objective, int pantryId) async {
  
  bool addFlagLastname = true;
  bool addFlagFirstname = true;
  bool addFlagEmail = true;
  bool addFlagPassword = true;
  bool addFlagImage = true;
  bool addFlagSex = true;
  bool addFlagHeight = true;
  bool addFlagWeight = true;
  bool addFlagObjective = true;
  bool addFlagPantry = true;
  String hashedPassword="";
  //Please fill in all fields
  if (lastname == '') {
    addFlagLastname=false;
  }
  if (firstname == '') {
    addFlagFirstname=false;
  }
  if (email == '') {
    addFlagEmail=false;
  }
  if (password == '') {
    addFlagPassword=false;
  }
  if (sex == '') {
    addFlagSex=false;
  }
  if (height == 0) {
    addFlagHeight=false;
  }
  if (weight == 0) {
    addFlagWeight=false;
  }
  if (objective == '') {
    addFlagObjective=false;
  }
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
      addFlagPassword = false;
    }

  //email unic
    final List<List<dynamic>> emailsLists = await conn.query('SELECT email FROM users');
    final List<String> emails = [];

    for (final row in emailsLists) {
      final email = row[0].toString();
      emails.add(email);
    }

    int i;
    for(i = 0; i < emails.length; i++){
      if(emails[i] == email){
        addFlagEmail = false;
      }
    }
    if(email == ""){
      addFlagEmail = false;
    }
    if(addFlagEmail){
      print("\n email ok\n");
    }

    //add element to the database
    if(addFlagLastname && addFlagFirstname && addFlagEmail && addFlagPassword && addFlagImage && addFlagSex && addFlagHeight && addFlagWeight && addFlagObjective && addFlagPantry){
      await conn.query('''
        INSERT INTO users (lastname, firstname, email, password, image, sex, height, weight, objective, pantry_id)
        VALUES ('$lastname', '$firstname', '$email', '$hashedPassword', '$image', '$sex', $height, $weight, '$objective', $pantryId)
      ''');
      return false;
    }
    else{
      await conn.close();
      print("register fail");
      return true;
    }
  }
  catch(e){
    await conn.close();
    print("register fail");
    return true;
  }
}