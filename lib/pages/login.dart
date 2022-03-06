// ignore_for_file: avoid_types_as_parameter_names, avoid_print, must_be_immutable, nullable_type_in_catch_clause, empty_catches, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class Login extends StatefulWidget {
  late String darkmode;
  late String autoLogin;

  Login({Key? key, required this.darkmode, required this.autoLogin}) : super(key: key);

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  int value = 0;
  String buttonText = "Eingeloggt bleiben: Off";

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
                    color: returnDarkmodeColor(widget.darkmode),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        "Anmeldung",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: returnDarkmodeTextColor(widget.darkmode),
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
                          style: TextStyle(color: returnDarkmodeTextColor(widget.darkmode)),
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email oder Username",
                            labelStyle: TextStyle(
                              color: returnDarkmodeTextColor(widget.darkmode),
                            ),
                            suffixIcon: const Icon(Icons.email, size: 17),
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: returnDarkmodeTextColor(widget.darkmode),
                            ),
                            suffixIcon: const Icon(Icons.password, size: 17),
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
                      CustomRadioButton(buttonText, 1),
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
                                //print(widget.darkmode);
                                //var status = await Permission.storage.status;
                                //if (status.isDenied) {
                                //  await Permission.storage.request();
                                //  return;
                                //}
                                String autoLogin = await readData("autoLogin");
                                if (autoLogin == "true") {
                                  await saveData("username", emailController.text);
                                  await saveData("passwort", passwordController.text);
                                }
                                await checkLogin(context, emailController.text, passwordController.text);
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: returnDarkmodeButtonColor(widget.darkmode),
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
    print("a = " + a);
    Map<String, dynamic> userMap = jsonDecode(a);
    print("userMap: " + userMap.toString());
    var Username = userMap['name'];
    var Permission = userMap['permissions'];
    var error = userMap['error'];
    if (error != "000") {
      getLoginAlert(context, "Falsche Anmeldedaten");
    } else {
      if (Username != Null && Username != "") {
        if (Permission != Null && Permission != "") {
          await saveData("username", Username.toString());
          await saveData("permission", Permission.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserHome(darkmode: widget.darkmode)));
          //print('Login Erfolg');
        } else {
          getLoginAlert(context, error);
        }
      } else {
        getLoginAlert(context, error);
      }
    }
  }

  getLoginAlert(_context, String error) {
    return showDialog(
      context: _context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: const Color(0xFFF27121),
        title: const Text("Falsche Daten"),
        content: Text("Fehler: " + error),
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

  authUser(context, username, passwort) async {
    var res = await http.post(Uri.parse('http://192.168.178.93/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': passwort,
        'action': "auth",
      }),
    );

    return res.body;
  }

  readData(String dataKey) async {
    final prefs = await SharedPreferences.getInstance();
    final key = dataKey;
    final value = prefs.getString(key) ?? 0;
    return value;
  }

  saveData(String _dataKey, String _data) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _dataKey;
    final data = _data;
    final value = prefs.setString(key, data);
    return value;
  }

  Widget CustomRadioButton(String text, int index) {
    // ignore: deprecated_member_use
    print(widget.autoLogin);
    return OutlineButton(
      onPressed: () async {
        if (value != index) {
          await saveData("autoLogin", "false");
          setState(() {
            value = index;
            buttonText = "Eingeloggt bleiben: Off";
            widget.autoLogin = "false";
          });
        } else {
          await saveData("autoLogin", "true");
          setState(() {
            value = 0;
            buttonText = "Eingeloggt bleiben: On";
            widget.autoLogin = "true";
          });
        }
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? const Color.fromARGB(255, 0, 0, 0) : Colors.green,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      borderSide:
          BorderSide(color: (value == index) ? Colors.green : Colors.white),
    );
  }

  returnDarkmodeColor(String darkmode) {
    print("Home - Darkmode: " + darkmode);
    if (darkmode == "0" || darkmode == "Darkmode: Off") {
      return Colors.white;
    }
    if (darkmode == "1" || darkmode == "Darkmode: On") {
      return const Color.fromARGB(255, 39, 39, 39);
    }
  }

  returnDarkmodeTextColor(String darkmode) {
    if (darkmode == "0" || darkmode == "Darkmode: Off") {
      return Colors.black;
    }
    if (darkmode == "1" || darkmode == "Darkmode: On") {
      return Colors.white;
    }
  }

  Color returnDarkmodeButtonColor(String darkmode) {
    Color color = Colors.white;
    if (darkmode == "0" || darkmode == "Darkmode: Off") {
      color = Colors.white;
    }
    if (darkmode == "1" || darkmode == "Darkmode: On") {
      color = const Color.fromARGB(255, 39, 39, 39);
    }
    return color;
  }
}
