import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String password = "12312";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login screen")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text('Please enter your password:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Text>.generate(
                  password.length,
                  (i) => const Text(
                    "*",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            ],
          ),
          Column(children: [
            ...List<Row>.generate(3, (i) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List<OutlinedButton>.generate(3, (j) {
                  String value = (3 * i + j + 1).toString();
                  return OutlinedButton(
                      onPressed: () => _appendToPassword(value),
                      child: Text(value));
                }),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(onPressed: () {}, child: const Text('OK')),
                OutlinedButton(
                    onPressed: () => _appendToPassword("0"),
                    child: const Text('0')),
                OutlinedButton(
                  onPressed: _removeLastCharFromPassword,
                  child: const Icon(Icons.backspace),
                ),
              ],
            )
          ]),
        ],
      ),
    );
  }

  void _appendToPassword(String char) {
    setState(() {
      password = password + char;
    });
  }

  void _removeLastCharFromPassword() {
    setState(() {
      password = password.substring(0, password.length - 1);
    });
  }

  void _login() {}
}
