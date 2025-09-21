import 'package:chattingapp/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: "lib/.env");
  runApp(const MainApp());
}

//Custom notification
//Log out
//mesaj ekranı kişi seçilince gözüksün diğer türlü boş ekran
//Kullanıcı kendi ismini ana ekranda muhtelemen sol üst köşede görsün.
//mesaj gözükme delayi azaltılacak
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
