import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:queuing/register.dart';
import 'package:http/http.dart' as http;
import 'transaction.dart';

void main() {
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhilCST Queuing System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    var url = Uri.http("192.168.87.148", '/login/login.php', {'q': '{http}'});
    var response = await http.post(url, body: {
      "username": user.text,
      "password": pass.text,
    });
    var data = json.decode(response.body);
    if (data.toString() == "Success") {

      Fluttertoast.showToast(
        msg: 'Login Successful',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Transactions(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Username and password invalid',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 211, 121, 3), Color.fromARGB(255, 202, 77, 5)])),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                SizedBox(
                  height: 15,
                ),
                CircleAvatar(
                  radius: 45.0,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/logo.png'),
                    radius: 43,
                  ),
                ),
                Text(
                  'PhilCST Queuing System',
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    height: 1,
                    width: 0.8,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 10),
                  child: TextField(
                    controller: user,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    decoration: InputDecoration(
                        prefixIconConstraints:
                        const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.white60,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Username',
                        hintStyle: const TextStyle(
                            color: Colors.black, fontSize: 20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide:
                            const BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide:
                            const BorderSide(color: Colors.white70))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 10),
                  child: TextField(
                    controller: pass,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    obscureText: isPasswordVisible ? false : true,
                    decoration: InputDecoration(
                        prefixIconConstraints:
                        const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white70,
                          size: 22,
                        ),
                        suffixIconConstraints:
                        const BoxConstraints(minWidth: 45, maxWidth: 46),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white70,
                            size: 22,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Password',
                        hintStyle: const TextStyle(
                            color: Colors.black, fontSize: 20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide:
                            const BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide:
                            const BorderSide(color: Colors.white70))),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    login();
                  },
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.black12.withOpacity(.2),
                              offset: const Offset(2, 2))
                        ],
                        borderRadius: BorderRadius.circular(100)
                            .copyWith(bottomRight: const Radius.circular(0)),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 116, 45, 3),
                          Colors.amber.shade900
                        ])),
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}