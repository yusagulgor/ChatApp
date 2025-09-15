import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const UserCard({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color.fromARGB(255, 60, 60, 60),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: ListTile(
          title: Text(name, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
