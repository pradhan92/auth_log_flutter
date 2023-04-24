import 'dart:convert';

import 'package:auth_log/authentication/login.dart';
import 'package:auth_log/screen/home.dart';
import 'package:auth_log/services/auth_services.dart';
import 'package:auth_log/services/globals.dart';
import 'package:auth_log/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name ='';
  String email ='';
  String password ='';

  CreateAccountPressed()async{
     bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      http.Response response =
          await AuthServices.register(name, email, password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen(),
            ));
      } else {
        errorSnackBar(context, responseMap.values.first[0]);
      }
    } else {
      errorSnackBar(context, 'email not valid');
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 255, 0,0),
        centerTitle: true,
        elevation:0,
        title: const Text('Register',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        ),
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
             const SizedBox(
                height: 30,
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Name'),
                onChanged: (value) {
                  name = value;
                },
              ),
                 const SizedBox(
                height: 30,
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Email'),
                onChanged: (value) {
                  email = value;
                },
              ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Password'),
            onChanged: (value){
              password = value;
            },
          ),
          const SizedBox(
                height: 50,
              ),
          RoundedButton(
            btnText: 'Create a new account',
            onBtnPressed: ()=> CreateAccountPressed(),
          ),
          const SizedBox(
                height: 70,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Login(),
                      ));
                },
                child:const Text(
                   'already have an account',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
        ],
      ),
    ),
    ),
    );
  }
}