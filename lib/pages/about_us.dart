import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hakkımızda'),
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