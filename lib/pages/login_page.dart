import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twofort/util/firebase_auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FireBaseAuthService fireBaseAuthService=FireBaseAuthService();
  bool _isLoading = false;
  void _login() async {
    setState(() {
      _isLoading = true; // Start loading
    });
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    try{
      User? user = await fireBaseAuthService.logIn(email, password);
      if(user!=null && mounted){
        Navigator.pushReplacementNamed(context, '/home');
      }
      else {
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Login failed. Please try again.'),
          ));
        }
      }
    }
    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $e'),
        ));
      }
    }
    finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _signUp(){
    Navigator.pushNamed(context, '/singUpPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed:  _isLoading ? null : _login,
                  child:  _isLoading? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      :const Text('Login'),
                ),
                ElevatedButton(
                  onPressed:  _signUp,
                  child: const Text('Sign up'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

