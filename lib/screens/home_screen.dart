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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://bdam98b5.blob.core.windows.net/photos/UEW_logo.webp',
              height: 200,
              width: 200,
              ),
            Text('Projekt zaliczeniowy BDAMI IwB', style: TextStyle(fontSize: 19)),
            Text('Wojciech Kucharski 192467'),
            Text('Mikołaj Olczak 192433')
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomBar(current: AppSection.home),
    );
  }
}
