import 'package:flutter/material.dart';
import 'package:navigation/domain/user.dart';
import 'package:navigation/main.dart'; // Import database instance

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.username});

  final String username;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bornDateController = TextEditingController();

  bool isModified = false;
  User? user;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final fetchedUser = await database.userDao.getUserByUsername(widget.username);
    if (fetchedUser != null) {
      setState(() {
        user = fetchedUser;
        nameController.text = user!.name;
        emailController.text = user!.email;
        usernameController.text = user!.username;
        bornDateController.text = user!.bornDate.substring(0, 10);
      });
    }
  }

  void _checkIfModified() {
    setState(() {
      isModified = user != null &&
          (nameController.text != user!.name ||
           emailController.text != user!.email ||
           bornDateController.text != user!.bornDate);
    });
  }

  Future<void> _saveChanges() async {
    if (user != null) {
      final updatedUser = User(
        username: user!.username,
        name: nameController.text,
        email: emailController.text,
        password: user!.password,
        imageUrl: user!.imageUrl,
        bornDate: bornDateController.text,
      );
      await database.userDao.updateUser(updatedUser);
      setState(() {
        user = updatedUser;
        isModified = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }

  Future<void> _selectBornDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(user?.bornDate ?? DateTime.now().toString().substring(0, 10)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        bornDateController.text = '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
        _checkIfModified();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user!.imageUrl ?? 'https://placeholder.com/avatar.png'),
                      onBackgroundImageError: (exception, stackTrace) {
                        setState(() {});
                      },
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                      onChanged: (_) => _checkIfModified(),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: usernameController,
                      readOnly: true,
                      decoration: const InputDecoration(labelText: 'Username', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                      onChanged: (_) => _checkIfModified(),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: bornDateController,
                      readOnly: true,
                      decoration: const InputDecoration(labelText: 'Born Date', border: OutlineInputBorder()),
                      onTap: _selectBornDate,
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: isModified ? _saveChanges : null,
                      child: const Text('Update'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
