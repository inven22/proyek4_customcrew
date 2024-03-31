import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fe_customcrew/components/button_forgot.dart';
import 'package:fe_customcrew/components/my_textfield.dart';
import 'package:fe_customcrew/components/square_tile.dart';
import 'dashboard.dart';

class Forgotpw extends StatelessWidget {
  Forgotpw({super.key});

  final TextEditingController emailController = TextEditingController();

  Future<void> resetPassword(BuildContext context) async {
    final String email = emailController.text;
    final Uri url = Uri.parse('YOUR_API_FORGOT_PASSWORD_ENDPOINT');

    try {
      final http.Response response = await http.post(
        url,
        body: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        // Handle reset password success
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Check your email for instructions to reset your password.'),
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
      } else {
        // Handle reset password failure
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to reset password. Please try again later.'),
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
            content: Text('Failed to reset password. Please check your internet connection.'),
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
              Image.network(
                'https://th.bing.com/th/id/OIP.sUpDsWLRzc0J4J6hY31zSwHaHa?w=167&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7', // Ganti dengan URL gambar yang benar
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 50),
              Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: emailController,
                hintText: 'Masukan email anda',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyButton(
                onTap: () {
                  resetPassword(context);
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
