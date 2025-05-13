import 'package:flutter/material.dart';
import 'package:navigation/domain/user.dart';

class ProfileScreen extends StatefulWidget {
  // final User user;

  // const ProfileScreen({super.key, required this.user});
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bornDateController = TextEditingController();

  bool isModified = false;

  User user = User(email: "user@gmail.com", 
                   name: "User", 
                   password: "pass123", 
                   username: "user123", 
                   imageUrl: 'https://placeholder.com/avatar.png',
                   bornDate: "1999-07-06",); // Changed to String

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: user.name);
    emailController = TextEditingController(text: user.email);
    usernameController = TextEditingController(text: user.username);

    // Add listeners to detect changes
    nameController.addListener(_checkIfModified);
    emailController.addListener(_checkIfModified);
    usernameController.addListener(_checkIfModified);
  }

  void _checkIfModified() {
    setState(() {
      isModified = nameController.text != user.name ||
          emailController.text != user.email;
    });
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _selectBornDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(user.bornDate), // Parse String to DateTime
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate.toIso8601String() != user.bornDate) {
      setState(() {
        bornDateController.text = _formatDate(pickedDate);
        user = User(
          username: user.username,
          name: user.name,
          email: user.email,
          password: user.password,
          imageUrl: user.imageUrl,
          bornDate: pickedDate.toIso8601String(), // Convert DateTime to String
        );
        _checkIfModified();
      });
    }
  }

  void _saveChanges() {
    // Save the updated parameters (e.g., send to backend or update state)
    final updatedUser = User(
      username: user.username,
      name: nameController.text,
      email: nameController.text,
      password: user.password,
      imageUrl: user.imageUrl,
      bornDate: user.bornDate,
    );

    // Simulate saving and show a confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );

    setState(() {
      isModified = false; // Reset modification flag
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.imageUrl ?? 'https://placeholder.com/avatar.png'),
                  onBackgroundImageError: (exception, stackTrace) {
                    setState(() {}); // Trigger rebuild to show error icon
                  },
                  child: const Icon(
                    Icons.broken_image,
                    // size: 100,
                    color: Colors.grey,
                  ),
                ),
              ),
              Divider(
                height: 1, // The height of the divider
                color: Colors.grey, // The color of the divider
                thickness: 1, // The thickness of the divider line
                // indent: 20, // The left padding (indent) of the divider
                // endIndent: 20, // The right padding (endIndent) of the divider
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: bornDateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Born Date',
                  border: OutlineInputBorder(),
                ),
                onTap: _selectBornDate, // Open date picker on tap
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: isModified ? _saveChanges : null, // Enable only if modified
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
