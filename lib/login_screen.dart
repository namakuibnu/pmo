import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart'; // Pastikan HomeScreen diimport
import 'admin_screen.dart'; // Buat layar untuk admin
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi untuk login
  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername =
        prefs.getString('username'); // Ambil username yang disimpan
    String? savedPassword =
        prefs.getString('password'); // Ambil password yang disimpan

    String inputUsername = _usernameController.text;
    String inputPassword = _passwordController.text;

    if (inputUsername == "admin" && inputPassword == "admin123") {
      // Jika login sebagai admin
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login sebagai Admin berhasil!')),
      );

      // Arahkan ke AdminScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminScreen()),
      );
    } else if (inputUsername == savedUsername &&
        inputPassword == savedPassword) {
      // Jika login sebagai user biasa
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Berhasil!')),
      );

      // Arahkan ke HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Jika login gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username atau password salah')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.lightBlue.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'image/tent_icon.png',
                    height: 120,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Tenda Rental',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 40),
                  // Username TextField
                  TextField(
                    controller: _usernameController,
                    style: TextStyle(color: Colors.black), // Warna teks hitam
                    decoration: InputDecoration(
                      labelText: 'Username',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Password TextField
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      if (_usernameController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Username dan Password harus diisi')),
                        );
                      } else {
                        _login();
                      }
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Register Button
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text(
                      'Daftar Akun',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
