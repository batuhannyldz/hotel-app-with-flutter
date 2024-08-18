import 'package:airbnb/login_service.dart';
import 'package:flutter/material.dart';
import 'hotel_list.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (LoginService.authenticate(username, password)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HotelList()),
      );
    } else {
      // Giris basarisiz olduysa hata mesaji goster
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Giriş Başarısız'),
          content: Text('Kullanıcı adı veya şifre yanlış.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 300.0,
              height: 300.0,
            ),
            SizedBox(height: 50),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Kullanici Adi',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Sifre',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              child: Text('Giriş'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[400],
                foregroundColor: Colors.white,
                minimumSize: Size(400, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}