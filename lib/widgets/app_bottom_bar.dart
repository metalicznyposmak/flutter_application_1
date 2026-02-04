import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/search_screen.dart';
import 'package:flutter_application_1/screens/basket_screen.dart';

enum AppSection {
  search,
  home,
  basket,
  profile,
}

class AppBottomBar extends StatelessWidget {
  final AppSection current;

  const AppBottomBar({Key? key, required this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = TextButton.styleFrom(
      foregroundColor: Colors.white,
      disabledForegroundColor: Colors.white,
    );
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: current == AppSection.search
                  ? null
                  : () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
              style: buttonStyle,
              child: const Text('Wyszukaj'),
            ),
            TextButton(
              onPressed: current == AppSection.home ? null : () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
              style: buttonStyle,
              child: const Text('Home'),
            ),
            TextButton(
              onPressed: current == AppSection.basket ? null : () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BasketScreen(),
                      ),
                     );
                   },
              style: buttonStyle,
              child: const Text('Koszyk')
            ),
            TextButton(
              onPressed: current == AppSection.profile ? null : () {},
              style: buttonStyle,
              child: const Text('Profil'),
            ),
          ],
        ),
      ),
    );
  }
}
