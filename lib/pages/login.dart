// ignore_for_file: avoid_types_as_parameter_names, avoid_print, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF8A2387),
                  Color(0xFFE94057),
                  Color(0xFFF27121),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                //Image.asset("images/logo.png"),
                const SizedBox(height: 15),
                //const Text(
                //  "Informatik - AG",
                //  style: TextStyle(
                //    color: Colors.white,
                //    fontSize: 20,
                //  ),
                //),
                const SizedBox(height: 30),
                Container(
                  height: 480,
                  width: 325,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        "Anmeldung",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Bitte einloggen",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 250,
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: "Email oder Username",
                            suffixIcon: Icon(Icons.email, size: 17),
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Password",
                            suffixIcon: Icon(Icons.password, size: 17),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            //Text(
                            //  "Passwort vergessen?",
                            //  style: TextStyle(
                            //    color: Colors.orangeAccent,
                            //  ),
                            //),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF8A2387),
                                Color(0xFFE94057),
                                Color(0xFFF27121),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GestureDetector(
                              onTap: () async {
                                //var status = await Permission.storage.status;
                                //if (status.isDenied) {
                                //  await Permission.storage.request();
                                //  return;
                                //}
                                await checkLogin(context, emailController.text, passwordController.text);
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ])
    );
  }

  checkLogin(context, username, passwort) async {
    print("Start Login");
    var a = await authUser(context, username, passwort);
    print(a);

    if (emailController.text == "kali") {
      if (passwordController.text == "kali") {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const UserHome()));
      } else {
        getLoginAlert(context);
      }
    } else {
      getLoginAlert(context);
    }
  }

  checkLoginBeta(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const UserHome()));
  }

  getLoginAlert(_context) {
    return showDialog(
      context: _context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: const Color(0xFFF27121),
        title: const Text("Falsche Daten"),
        content: const Text(
            "Du hast ein flasches Passwort oder eine falsche Email angegeben!"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  Future<http.Response> authUser(context, username, passwort) {
    return http.post(Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': passwort,
        'action': "auth",
      }),
    );
  }
}
