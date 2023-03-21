import 'package:firebase_test/models/user_model.dart';
import 'package:flutter/material.dart';

import '../services.dart';

class UserProvider extends ChangeNotifier {
  final _service = Services();
  List<UserModel> _users = [];
  List<UserModel> get users => _users;
  UserModel? _newUser;
  UserModel? get newUser => _newUser;
  UserModel? _selectedUser;
  UserModel? get selectedUser => _selectedUser;
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _ageController;
  TextEditingController? get nameController => _nameController;

  setUser(UserModel user) {
    _selectedUser = user;
    notifyListeners();
  }

  Future<void> getUsers() async {
    _users = await _service.getUsers();

    notifyListeners();
  }

  Future<void> getUserById(String id) async {
    _selectedUser = await _service.getUserById(id);
    notifyListeners();
  }

  Future<void> postUser(UserModel user) async {
    _newUser = await _service.postUser(user);
    getUsers();
    notifyListeners();
  }

  Future<void> updateUser(UserModel user) async {
    await _service.updateUser(user);
    getUsers();
    notifyListeners();
  }

  Future<void> deleteUser(String id) async {
    await _service.deleteUser(id);
    getUsers();
    notifyListeners();
  }

  setController() {
    TextEditingController _nameController =
        TextEditingController(text: selectedUser!.name);
    TextEditingController _emailController =
        TextEditingController(text: selectedUser!.email);
    TextEditingController _ageController =
        TextEditingController(text: selectedUser!.age.toString());
  }
}
