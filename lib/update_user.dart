import 'package:firebase_test/models/user_model.dart';
import 'package:firebase_test/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController ageController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    usernameController = TextEditingController(
        text: context.watch<UserProvider>().selectedUser!.name);
    emailController = TextEditingController(
        text: context.watch<UserProvider>().selectedUser!.email);
    ageController = TextEditingController(
        text: context.watch<UserProvider>().selectedUser!.age.toString());
    UserModel? user = context.watch<UserProvider>().selectedUser;
    return Scaffold(
        appBar: AppBar(title: Text('Update User')),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.abc),
                    prefixIconColor: Colors.deepPurple,
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Colors.deepPurple,
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
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
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                      child: const Text('Update'),
                      onPressed: () async {
                        if (usernameController.text != null &&
                            emailController.text != null) {
                          user!.name = usernameController.text;
                          user.email = emailController.text;
                          user.age = int.parse(ageController.text);
                          user.image = '';

                          var provider =
                              Provider.of<UserProvider>(context, listen: false);
                          await provider.updateUser(user);

                          Navigator.pop(context);
                        }
                      }))
            ],
          ),
        ));
  }
}
