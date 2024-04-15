import 'package:postgres/postgres.dart';
void db_start(){
  
}
Future<bool> login_function(String email, String password) async {
  
  String hashedPassword = "";
  bool add_flag_password = true;
  bool add_flag_email = true;
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

 //email verification 
  if(email == ""){
    add_flag_email = false;
  }

 //password hash
  if(password != "") {
    hashedPassword = password.hashCode.toString();
  } else{
    print("parola lipsa");
    add_flag_password = false;
  }

 //log in logic
  if(add_flag_password && add_flag_email){
    final PostgreSQLResult results = await conn.query('SELECT email, password FROM users WHERE email = @email', substitutionValues: {'email': email});
    try{
      final String emailAddress = results[0][0] as String;
      final String password_extracted = results[0][1] as String;
      if(emailAddress == email && password_extracted == hashedPassword){
        print("Login succes");
        return true;
      }else{
        print("login faild");
        return false;
      }

    }catch (e) {
      print("login faild");
      return false;
    }
  }
  return false;
}