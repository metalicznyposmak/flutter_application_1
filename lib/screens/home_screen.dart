import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/app_bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _logout(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Przycisk'),
        ),
      ),
      bottomNavigationBar: const AppBottomBar(current: AppSection.home),
    );
  }
}
