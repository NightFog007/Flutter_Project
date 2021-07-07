import './ui/screens/details.dart';
import './ui/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize("ca-app-pub-9010870803829618~3900588087");
  // Admob.initialize("ca-app-pub-3940256099942544~1458002511");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'OpenSans'
      ),
      home: HomeScreen(),
      routes: {
        'details' : (ctx) => DetailsScreen(),
      }
    );
  }
}
