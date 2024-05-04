// ignore_for_file: prefer_final_fields
import 'package:eatsmart/account_backend/global.dart';
import 'package:eatsmart/account_backend/profile_data.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:image_picker/image_picker.dart';
import 'package:eatsmart/widgets/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  // ignore: use_super_parameters
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();
  String _selectedSex="";
  double _selectedHeight=0;
  double _selectedWeight=0;
  String _selectedObjective="";
  String _selectedImage="";

  Future<bool> _handleEdit() async {
    int userID = getID();
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String passwordConfirm = _passwordConfirmController.text;
    print("Registering with:$userID, $firstName, $lastName, $email, $password, $passwordConfirm, $_selectedSex, $_selectedHeight, $_selectedWeight, $_selectedObjective"); 
    await updateUserData(userID,lastName,firstName,email,password,passwordConfirm,_selectedImage,_selectedSex,_selectedHeight,_selectedWeight,_selectedObjective,1);
    return true;
  }

  @override
  void initState() {
    super.initState();
    showData();
  }

  void showData() async {
    int userID = getID();
    String? fetchedFirstName = await get_firstName(userID);
    String? fetchedLastName = await get_lastName(userID);
    String? fetchedEmail = await get_email(userID);
    String? fetchedSex = await get_sex(userID);
    double? fetchedHeight = await get_height(userID);
    double? fetchedWeight = await get_weight(userID);
    String? fetchedObjective = await get_objective(userID);

    if (mounted) {
      setState(() {
        _firstNameController.text =
            fetchedFirstName; 
        _lastNameController.text =
            fetchedLastName; 
        _emailController.text = fetchedEmail;
        _selectedSex = fetchedSex;
        _selectedHeight = fetchedHeight;
        _selectedWeight = fetchedWeight;
        _selectedObjective = fetchedObjective;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _handleEdit();
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          SizedBox(
            height: screenHeight * 0.015,
          ),
          CustomTextField(
            controller: _firstNameController,
            icon: Icons.person,
            label: "First Name",
            hidden: false,
            borderColor: Colors.green,
            fillColor: Colors.green[50]!,
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          CustomTextField(
            controller: _lastNameController,
            icon: Icons.person_outline,
            label: "Last Name",
            hidden: false,
            borderColor: Colors.green,
            fillColor: Colors.green[50]!,
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          CustomTextField(
            controller: _emailController,
            icon: Icons.email,
            label: "Email",
            hidden: false,
            borderColor: Colors.orange,
            fillColor: Colors.orange[50]!,
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          CustomTextField(
            controller: _passwordController,
            icon: Icons.lock,
            label: "New Password",
            hidden: true,
            borderColor: Colors.red,
            fillColor: Colors.red[50]!,
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          CustomTextField(
            controller: _passwordConfirmController,
            icon: Icons.lock,
            label: "Confirm Password",
            hidden: true,
            borderColor: Colors.red,
            fillColor: Colors.red[50]!,
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CustomTextField(
                  controller: TextEditingController(text: _selectedSex),
                  icon: Icons.circle_outlined,
                  label: "Sex",
                  hidden: false,
                  borderColor: Colors.green,
                  fillColor: Colors.green[50]!,
                  isEnabled: false,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.015,
              ),
              Expanded(
                flex: 1,
                child: CustomDropdownButton<String>(
                  items: const ['Male', 'Female'],
                  value: _selectedSex,
                  displayText: (String? value) => value ?? "Select Sex",
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSex = newValue!;
                    });
                  },
                  controller: TextEditingController(),
                  borderColor: Colors.green,
                  fillColor: Colors.green[50]!,
                  textColor: Colors.green,
                  popupTextColor: Colors.black,
                  popupBackgroundColor: Colors.white,
                  width: screenWidth * 0.021, 
                  height: screenHeight * 0.068, 
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: TextEditingController(
                      text: _selectedHeight.toString()),
                  icon: Icons.height,
                  label: "Height (m)",
                  hidden: false,
                  borderColor: Colors.green,
                  fillColor: Colors.green[50]!,
                  isEnabled: false,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.015,
              ),
              Expanded(
                child: CustomDropdownButton<double>(
                  items: List.generate(200, (index) => ((index + 100) / 100)),
                  value: _selectedHeight,
                  displayText: (double? value) =>
                      value?.toString() ?? "Select Height",
                  onChanged: (double? newValue) {
                    setState(() {
                      _selectedHeight = newValue!;
                    });
                  },
                  borderColor: Colors.green,
                  fillColor: Colors.green[50]!,
                  textColor: Colors.green,
                  popupTextColor: Colors.black,
                  popupBackgroundColor: Colors.white,
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.06,
                  controller: TextEditingController(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: TextEditingController(
                      text: _selectedWeight.toString()),
                  icon: Icons.scale_sharp,
                  label: "Weight (kg)",
                  hidden: false,
                  borderColor: Colors.green,
                  fillColor: Colors.green[50]!,
                  isEnabled: false,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.015,
              ),
              Expanded(
                child: CustomDropdownButton<double>(
                  items: List.generate(342, (index) => (30 + (index * 0.5))),
                  value: _selectedWeight,
                  displayText: (double? value) =>
                      value?.toString() ?? "Select Weight",
                  onChanged: (double? newValue) {
                    setState(() {
                      _selectedWeight = newValue!;
                    });
                  },
                  borderColor: Colors.green,
                  fillColor: Colors.green[50]!,
                  textColor: Colors.green,
                  popupTextColor: Colors.black,
                  popupBackgroundColor: Colors.white,
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.06,
                  controller: TextEditingController(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CustomTextField(
                  controller: TextEditingController(text: _selectedObjective),
                  icon: Icons.arrow_upward,
                  label: "Objective",
                  hidden: false,
                  borderColor: Colors.green,
                  fillColor: Colors.green[50]!,
                  isEnabled: false,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.015,
              ),
              Expanded(
                flex: 1,
                child: CustomDropdownButton<String>(
                  items: const ['BULK', 'CUT', 'MAINTAIN'],
                  value: _selectedObjective,
                  displayText: (String? value) => value ?? "Select Objective",
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedObjective = newValue!;
                    });
                  },
                  controller: TextEditingController(),
                  borderColor: Colors.green,
                  fillColor: Colors.green[50]!,
                  textColor: Colors.green,
                  popupTextColor: Colors.black,
                  popupBackgroundColor: Colors.white,
                  width: screenWidth * 0.021, 
                  height: screenHeight * 0.068, 
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          ElevatedButton(
            onPressed: () {
              
            },
            child: const Text('Update Profile Picture'),
          ),
        ],
      ),
    );
  }
}
