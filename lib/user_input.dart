import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInputPage extends StatefulWidget {
  const UserInputPage({super.key});

  @override
  State<UserInputPage> createState() => _UserInputPageState();
}

class _UserInputPageState extends State<UserInputPage> {
  final TextEditingController nameController = TextEditingController();

  Future<void> saveUser() async {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập tên')),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('Users').add({
      'name': nameController.text.trim(),
      'createdAt': Timestamp.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lưu thành công')),
    );

    nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeef4ff),
      body: Center(
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person,
                  size: 45,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Firebase User Input",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Nhập thông tin người dùng và lưu vào Firestore",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Họ và tên",
                  hintText: "Nhập tên của bạn",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: saveUser,
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text(
                    "Lưu vào Firebase",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}