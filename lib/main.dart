import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'aboutus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AadirudraFinserv',
      theme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/bull.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool _isDarkMode = true;


  final List<Widget> _widgetOptions = [
    FirestoreListView(),
    AboutUsPage(), // Use your own widget for the About tab
  ];

  @override
  Widget build(BuildContext context) {
    // Define colors based on dark mode status
    Color appBarTextColor = _isDarkMode ? Colors.white : Colors.black;
    Color cardColor = _isDarkMode ? Colors.white : Colors.white;
    Color cardItemColor = _isDarkMode ? Colors.black : Colors.white;
    Color darkModeButtonColor = _isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
        backgroundColor: _isDarkMode ? Colors.black : Colors.white, // Set background color based on mode
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Aadirudra",
                style: TextStyle(fontSize: 22, color: appBarTextColor), // Set text color based on mode
              ),
              Text(
                " Finance",
                style: TextStyle(fontSize: 22, color: Colors.blue),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode ),
              color: darkModeButtonColor,
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          ],
        ),
        body: Stack(children: [
          _widgetOptions.elementAt(_selectedIndex),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                child: BottomNavigationBar(
                  showUnselectedLabels: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  currentIndex: _selectedIndex,
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/image/home.png',
                          height: 20, width: 20),
                      activeIcon: Image.asset('assets/image/home.png',
                          height: 20, width: 20,color: Colors.blue),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/image/id-card.png',
                          height: 20, width: 20),
                      activeIcon: Image.asset('assets/image/id-card.png',
                          height: 20, width: 20, color: Colors.blue),
                      label: 'About',
                    ),
                  ],
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                ),
              ))
        ]));
  }
}



class FirestoreListView extends StatefulWidget {
  @override
  _FirestoreListViewState createState() => _FirestoreListViewState();
}

class _FirestoreListViewState extends State<FirestoreListView> {
  late Stream<QuerySnapshot> _dataStream;

  @override
  void initState() {
    super.initState();
    _dataStream = FirebaseFirestore.instance.collection('data').snapshots();
  }

  Future<void> _refreshData() async {
    setState(() {
      _dataStream = FirebaseFirestore.instance.collection('data').snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: StreamBuilder<QuerySnapshot>(
        stream: _dataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Firestore Error: ${snapshot.error}'));
          }

          final documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final data = documents[index].data() as Map<String, dynamic>;
              final title = data['title'];
              final description = data['description'];
              final timestamp = data['timestamp'] != null
                  ? (data['timestamp'] as Timestamp).toDate()
                  : null;
              final formattedDate = timestamp != null
                  ? DateFormat('yyyy-MM-dd').format(timestamp)
                  : 'N/A';
              final formattedTime = timestamp != null
                  ? DateFormat('HH:mm:ss').format(timestamp)
                  : 'N/A';
              final Price = data['Price'];

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2),
                      Text(description,
                          style: TextStyle(
                              color: description == 'PE'
                                  ? Colors.red
                                  : Colors.green)),
                      SizedBox(height: 2),
                      Text("₹"+Price),
                      SizedBox(height: 2),
                      Row(children: [
                        Text('Date: $formattedDate'),
                        Text('Time: $formattedTime'),
                      ]),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
