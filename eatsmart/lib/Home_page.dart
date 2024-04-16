import 'package:eatsmart/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
int _selectedIndex = 1;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    //const SearchScreen(),
   //const ScanScreen(),
    //const RecipeScreen(),
    // ProfileScreen(),
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        backgroundColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 227, 232, 227),
        selectedItemColor: const Color.fromRGBO(165, 221, 155, 1.0),
        iconSize: 30,
        selectedFontSize: 15,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_scanner,
            ),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.admin_panel_settings,
            ),
            label: 'Admin',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),    
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: screenHeight*0.08,),
            Text(
              'Eat Smart',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: const Color.fromRGBO(165, 221, 155, 1.0),
                fontSize: 62.0, 
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}