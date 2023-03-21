import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/providers/users_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addUser');
                },
                icon: const Icon(Icons.add))
          ],
          title: const Text('Firebase CRUD'),
        ),
        body: SafeArea(
            child: ListView.builder(
          itemCount: context.watch<UserProvider>().users.length,
          itemBuilder: (context, index) => Card(
            elevation: 6,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Text((index + 1).toString()),
              ),
              title: Text(context.watch<UserProvider>().users[index].name),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context
                        .watch<UserProvider>()
                        .users[index]
                        .email
                        .toString()),
                    Text(context
                        .watch<UserProvider>()
                        .users[index]
                        .age
                        .toString()),
                  ]),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.update, color: Colors.deepPurple),
                      onPressed: () async {
                        var provider =
                            Provider.of<UserProvider>(context, listen: false);
                        await provider
                            .setUser(context.read<UserProvider>().users[index]);
                        Navigator.pushNamed(context, '/updateUser');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.deepPurple),
                      onPressed: () async {
                        await context.read<UserProvider>().deleteUser(
                            context.read<UserProvider>().users[index].id!);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ))
        // Center(
        //     child: Padding(
        //   padding: const EdgeInsets.all(20.0),
        //   child: ListView.builder(
        //     itemBuilder: (BuildContext context, index) {
        //       return Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: ListTile(
        //           leading: const Padding(
        //             padding: EdgeInsets.all(8.0),
        //             child: Icon(Icons.person),
        //           ),
        //           title: Text(context.watch<UserProvider>().users[index].name),
        //           subtitle: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(context
        //                     .watch<UserProvider>()
        //                     .users[index]
        //                     .email
        //                     .toString()),
        //                 Text(context
        //                     .watch<UserProvider>()
        //                     .users[index]
        //                     .age
        //                     .toString()),
        //               ]),
        //           trailing: SizedBox(
        //             width: 100,
        //             child: Row(
        //               children: [
        //                 IconButton(
        //                   icon: Icon(Icons.update),
        //                   onPressed: () async {
        //                     var provider = Provider.of<UserProvider>(context,
        //                         listen: false);
        //                     await provider.setUser(
        //                         context.read<UserProvider>().users[index]);
        //                     Navigator.pushNamed(context, '/updateUser');
        //                   },
        //                 ),
        //                 IconButton(
        //                   icon: Icon(Icons.delete),
        //                   onPressed: () async {
        //                     await context.read<UserProvider>().deleteUser(
        //                         context.read<UserProvider>().users[index].id!);
        //                   },
        //                 )
        //               ],
        //             ),
        //           ),
        //         ),
        //       );
        //     },
        //     itemCount: context.watch<UserProvider>().users.length,
        //   ),
        // ))
        );
  }
}
