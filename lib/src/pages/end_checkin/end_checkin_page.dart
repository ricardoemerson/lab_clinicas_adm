import 'package:flutter/material.dart';

class EndCheckinPage extends StatelessWidget {
  const EndCheckinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EndCheckinPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EndCheckinPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
