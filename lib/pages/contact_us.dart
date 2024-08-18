import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İletişim'),
        backgroundColor: Colors.red,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
        ),
      ),
    );
  }
}