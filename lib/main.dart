import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color.fromARGB(255, 234, 237, 240),
              Color.fromARGB(255, 176, 200, 221),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                      ),
                    ),
                    const DarkModeSwitch(),
                  ],
                ),
              ),
              const TopWidget(),
              const MiddleWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<DarkModeSwitch> createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  bool isDarkModeOn = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDarkModeOn = !isDarkModeOn;
        });
      },
      child: Image.asset(
        isDarkModeOn
            ? 'images/night_mode_button.png'
            : 'images/light_mode_button.png',
        width: 80,
      ),
    );
  }
}

class TopWidget extends StatelessWidget {
  const TopWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ) +
              const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(32)),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFF67DED3),
                Color(0xFF51A8FD),
              ],
              tileMode: TileMode.mirror,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(4, 8), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              // 1st ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    '27°',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // 2nd ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Wrocław',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Monday, 10/22',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.air,
                    color: Color.fromARGB(50, 255, 255, 255),
                    size: 80,
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned.fill(
          left: 32,
          top: 0,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 200,
              height: 150,
              child: Image.network(
                'https://freepngimg.com/thumb/categories/2275.png',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MiddleWidget extends StatelessWidget {
  const MiddleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 16,
      ),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(32)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(4, 8), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          // Headline
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weather details'.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Icon(
                Icons.refresh,
                color: Colors.black45,
                size: 24,
              )
            ],
          ),
          // Spacer
          const SizedBox(height: 32),
          // Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              GridDetailsElement(icon: Icons.ac_unit_outlined),
              GridDetailsElement(icon: Icons.accessible_outlined),
              GridDetailsElement(icon: Icons.anchor_sharp),
            ],
          ),
          // Spacer
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              GridDetailsElement(icon: Icons.card_membership_rounded),
              GridDetailsElement(icon: Icons.temple_buddhist),
              GridDetailsElement(icon: Icons.drive_eta),
            ],
          ),
        ],
      ),
    );
  }
}

class GridDetailsElement extends StatelessWidget {
  const GridDetailsElement({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.cyan,
        ),
        const SizedBox(height: 4),
        const Text(
          'wind',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 4),
        const Text(
          '9km/h',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
