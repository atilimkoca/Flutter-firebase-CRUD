import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordController = TextEditingController(text: 'testtest123');
    usernameController = TextEditingController(text: 'atilimkoca44@gmail.com');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FireBase'),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(children: [
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Text(
                  'CRUD Application',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  prefixIconColor: Colors.deepPurple,
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  prefixIconColor: Colors.deepPurple,
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Register'),
                  onPressed: () async {
                    try {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      UserCredential credential =
                          await auth.createUserWithEmailAndPassword(
                              email: usernameController.text,
                              password: passwordController.text);
                      Navigator.pop(context);
                      print(credential);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                  },
                )),
          ]),
        )
        // Center(
        //     child: Padding(
        //   padding: EdgeInsets.all(10),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       TextField(
        //         controller: usernameController,
        //         decoration: InputDecoration(
        //           hintText: "Username",
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       TextField(
        //         controller: passwordController,
        //         decoration: InputDecoration(
        //           hintText: "Password",
        //         ),
        //       ),
        //       ElevatedButton(
        //         onPressed: () async {
        //           try {
        //             FirebaseAuth auth = FirebaseAuth.instance;
        //             UserCredential credential =
        //                 await auth.createUserWithEmailAndPassword(
        //                     email: usernameController.text,
        //                     password: passwordController.text);
        //             print(credential);
        //           } on FirebaseAuthException catch (e) {
        //             if (e.code == 'user-not-found') {
        //               print('No user found for that email.');
        //             } else if (e.code == 'wrong-password') {
        //               print('Wrong password provided for that user.');
        //             }
        //           }
        //         },
        //         child: const Text("Register"),
        //       ),
        //     ],
        //   ),
        // )),
        );
  }
}
