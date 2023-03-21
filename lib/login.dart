import 'package:firebase_test/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            appHeader('CRUD Application'),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
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
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    try {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      UserCredential credential =
                          await auth.signInWithEmailAndPassword(
                              email: usernameController.text,
                              password: passwordController.text);
                      Navigator.pushNamed(context, '/home');
                      context.read<UserProvider>().getUsers();
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
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   alignment: Alignment.center,
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
            //                 await auth.signInWithEmailAndPassword(
            //                     email: usernameController.text,
            //                     password: passwordController.text);
            //             Navigator.pushNamed(context, '/home');
            //             context.read<UserProvider>().getUsers();
            //             print(credential);
            //           } on FirebaseAuthException catch (e) {
            //             if (e.code == 'user-not-found') {
            //               print('No user found for that email.');
            //             } else if (e.code == 'wrong-password') {
            //               print('Wrong password provided for that user.');
            //             }
            //           }
            //         },
            //         child: const Text("Login"),
            //       ),
            //       ElevatedButton(
            //           onPressed: () {
            //             Navigator.pushNamed(context, '/register');
            //           },
            //           child: Text('Register'))
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Container appHeader(String title) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w500,
              fontSize: 30),
        ));
  }
}
