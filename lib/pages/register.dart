import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fe_customcrew/components/my_register_button.dart';
import 'package:fe_customcrew/components/my_textfield.dart';
import 'package:fe_customcrew/components/square_tile.dart';
import 'dashboard.dart';

class registerPage extends StatelessWidget {
  registerPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> registerUser(BuildContext context) async {
    final String name = nameController.text;
    final String email = emailController.text;
    final String username = usernameController.text;
    final String password = passwordController.text;
    final Uri url = Uri.parse('YOUR_API_REGISTER_ENDPOINT');

    try {
      final http.Response response = await http.post(
        url,
        body: {
          'name': name,
          'email': email,
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Handle registration success
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dasboard()),
        );
      } else {
        // Handle registration failure
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to register user. Please try again later.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      // Handle error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to register user. Please check your internet connection.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(height: 50),
              Text(
                'Register here!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: nameController,
                hintText: 'Masukan nama anda',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: emailController,
                hintText: 'Masukan email anda',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: usernameController,
                hintText: 'Masukan Username anda',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: 'Masukan password anda',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              MyButton(
                onTap: () {
                  registerUser(context);
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
