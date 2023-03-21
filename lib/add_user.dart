import 'package:firebase_test/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController ageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    ageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add User')),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.abc),
                  prefixIconColor: Colors.deepPurple,
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  prefixIconColor: Colors.deepPurple,
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.numbers),
                  prefixIconColor: Colors.deepPurple,
                  border: OutlineInputBorder(),
                  labelText: 'Age',
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                    child: const Text('Add User'),
                    onPressed: () async {
                      UserModel user = UserModel(
                          name: nameController.text,
                          email: emailController.text,
                          age: int.parse(ageController.text),
                          image: '');
                      context.read<UserProvider>().postUser(user);

                      Navigator.pop(context);
                    })),
          ]),
        )
        // Center(
        //   child: Padding(
        //     padding: const EdgeInsets.all(20.0),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         TextField(
        //           controller: nameController,
        //           decoration: InputDecoration(
        //             hintText: "Name",
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         TextField(
        //           controller: emailController,
        //           decoration: InputDecoration(
        //             hintText: "Email",
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         TextField(
        //           controller: ageController,
        //           decoration: InputDecoration(
        //             hintText: "Age",
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         ElevatedButton(
        //           onPressed: () {
        //             UserModel user = UserModel(
        //                 name: nameController.text,
        //                 email: emailController.text,
        //                 age: int.parse(ageController.text),
        //                 image: '');
        //             context.read<UserProvider>().postUser(user);

        //             Navigator.pop(context);
        //           },
        //           child: Text('Add User'),
        //         ),
        //       ],
        //     ),
        //   ),
        // )
        );
  }
}
