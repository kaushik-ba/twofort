import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twofort/util/firebase_auth_service.dart';

import 'home_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FireBaseAuthService fireBaseAuthService=FireBaseAuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  void _signUp() async {
    setState(() {
      _isLoading = true; // Start loading
    });
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    try{
      User? user = await fireBaseAuthService.signUp(email, password);
      if(user!=null && mounted){
        _firestore.collection('users').doc(user.uid).set({
          'username':_userNameController.text
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successfully signed up!'),
        ));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,  // This removes all previous routes
        );
      }
      else {
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Sign up failed. Please try again.'),
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
              controller: _userNameController,
              decoration: const InputDecoration(labelText: 'User Name'),
            ),
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
            ElevatedButton(
              onPressed:  _isLoading ? null : _signUp,
              child:  _isLoading? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
                  :const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

