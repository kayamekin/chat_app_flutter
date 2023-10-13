import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:udemy_firebase_course/widgets/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _form = GlobalKey<FormState>();

  var _isLogin = true;

  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';
  File? _selectedImage;
  var _isAuthentication = false;

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid || !_isLogin && _selectedImage == null) {
      // show error message
      return;
    }

    _form.currentState!.save();

    try {
      setState(() {
        _isAuthentication = true;
      });
      if (_isLogin) {
        // ignore: unused_local_variable
        final userCredential = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Giriş başarılı")));
      } else {
        final userCredential = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child("user_images")
            .child('${userCredential.user!.uid}.jpg');
        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();

        //   -----
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': _enteredUsername,
          'email': _enteredEmail,
          'image': imageUrl,
          'password': _enteredPassword,
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // ...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'authentication failed.'),
        ),
      );
      setState(() {
        _isAuthentication = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (!_isLogin)
                    UserImagePicker(onPickImage: (pickedImage) {
                      _selectedImage = pickedImage;
                    }),
                  Text(
                    _isLogin ? "Login" : "Sign up",
                    style: TextStyle(color: Colors.grey, fontSize: 24),
                  ),
                  const SizedBox(height: 24),
                  if (!_isLogin)
                    TextFormField(
                      enableSuggestions: false,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length < 4) {
                          return 'Please enter a valid username (at least 4 characters).';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredUsername = value!;
                      },
                      textCapitalization: TextCapitalization.none,
                      decoration: const InputDecoration(
                        hintText: "Username",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  TextFormField(
                    onSaved: (value) {
                      _enteredEmail = value!;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !value.contains("@")) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    onSaved: (value) {
                      _enteredPassword = value!;
                    },
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.trim().length < 6) {
                        return "Please must be at least 6 characters long.";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_isAuthentication) const CircularProgressIndicator(),
                  if (!_isAuthentication)
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text(_isLogin ? "Login" : "Signup"),
                    ),
                  if (!_isAuthentication)
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? "Create an account"
                            : "I already have an account. Login")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
