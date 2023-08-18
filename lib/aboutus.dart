import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(AboutUsPage());
}

class AboutUsPage extends StatefulWidget {
// Constructor
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool _isDarkMode = true; // Track the current mode
  

  @override
  Widget build(BuildContext context) {
    // Define colors based on dark mode status
    Color textColor = _isDarkMode ? Colors.white : Colors.black;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        backgroundColor: Colors.black, // Keep the background color consistent
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 1.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                CompanyLogo(),
                SizedBox(height: 20),
                Text(
                  '3WayTechnologies',
                  style: TextStyle(
                    fontSize: 24,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'A team of Creative Minds designing best Apps and Website for the World.',
                    style: TextStyle(fontSize: 16, color: textColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                HorizontalCardView(),
                Padding(
                  padding: EdgeInsets.all(50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => launch('https://3waytech.co/'),
                        child: Image.asset(
                            'assets/image/website.png', height: 20,
                            width: 20,
                            color: textColor),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () =>
                            launch('https://www.instagram.com/3waytech/'),
                        child: Image.asset('assets/image/insta.png', height: 20,
                            width: 20,
                            color: textColor),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () =>
                            launch('https://www.facebook.com/3waytech'),
                        child: Image.asset('assets/image/fb.png', height: 20,
                            width: 20,
                            color: textColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class CompanyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Image.asset('assets/image/Companylogo.png', height: 35, width: 35),
    );
  }
}

class HorizontalCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Card(
                  margin: EdgeInsets.all(10),
                  child: Container(
                    color: Colors.white,
                    width: 150,
                    child: Center(
                      child: Text(
                        'OUR PROCESS',
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: Container(
                    color: Colors.white,
                    width: 150,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 4),
                          Text(
                            "Step One",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.black,
                          ),
                          SizedBox(height: 4),
                          Image.asset('assets/image/process-1.png'),
                          Text(
                            'Planning and Requirements Gathering',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: Container(
                    color: Colors.white,
                    width: 150,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 4),
                          Text(
                            "Step Two",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.black,
                          ),
                          SizedBox(height: 4),
                          Image.asset('assets/image/process-2.png'),
                          Text(
                            'Design and Prototyping',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: Container(
                    color: Colors.white,
                    width: 150,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 4),
                          Text(
                            "Step Three",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.black,
                          ),
                          SizedBox(height: 4),
                          Image.asset('assets/image/process-3.png'),
                          Text(
                            'Development',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: Container(
                    color: Colors.white,
                    width: 150,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 4),
                          Text(
                            "Step Four",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.black,
                          ),
                          SizedBox(height: 4),
                          Image.asset('assets/image/process-4.png'),
                          Text(
                            'Testing and Quality Assurance',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: Container(
                    color: Colors.white,
                    width: 150,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 4),
                          Text(
                            "Step Five",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.black,
                          ),
                          SizedBox(height: 4),
                          Image.asset('assets/image/process-5.png'),
                          Text(
                            'Deployment',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
