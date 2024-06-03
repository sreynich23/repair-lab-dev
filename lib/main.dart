import 'package:curved_navigation_bar/curved_navigation_bar.dart'
    show CurvedNavigationBar;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:repairing_lap_app/views/home.dart';
import 'package:repairing_lap_app/views/login.dart';
import 'package:repairing_lap_app/views/qrcode.dart';
import 'package:repairing_lap_app/views/register.dart';
import 'package:repairing_lap_app/views/setting.dart';
import 'package:repairing_lap_app/views/welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class checkedLogin extends StatefulWidget {
  const checkedLogin({Key? key}) : super(key: key);

  @override
  State<checkedLogin> createState() => _checkedLoginState();
}

class _checkedLoginState extends State<checkedLogin> {
  var auth = FirebaseAuth.instance;
  late User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return user != null ? const HomeView() : const WelcomeView();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome', // Set the initial route to '/home'
      routes: {
        '/register/': (context) => const RegisterView(),
        '/login/': (context) => const LoginView(),
        '/home': (context) => const HomePage(), // Use HomePage as the route
        '/welcome': (context) => const WelcomeView(),
      },
    );
  }
}

// Bottom navigation
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = const [
    HomeView(),
    ScanQRCodeView(),
    SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey[100]!,
        buttonBackgroundColor: Colors.blue[100],
        animationDuration: const Duration(milliseconds: 300),
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home,
            color: Colors.blue[400]!,
          ),
          Icon(
            Icons.qr_code,
            color: Colors.blue[400]!,
          ),
          Icon(
            Icons.settings,
            color: Colors.blue[400]!,
          ),
        ],
      ),
    );
  }
}
