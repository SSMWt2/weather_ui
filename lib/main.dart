import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_ui/cubit/main_cubit.dart';

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

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MainCubit(),
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    state.isNightMode
                        ? const Color.fromARGB(255, 3, 75, 148)
                        : const Color.fromARGB(255, 234, 237, 240),
                    state.isNightMode
                        ? const Color.fromARGB(255, 0, 105, 197)
                        : const Color.fromARGB(255, 176, 200, 221),
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
                    const BottomWidget(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BottomWidget extends StatefulWidget {
  const BottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  bool isNightMode = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) {
        // ignore: todo
        // TODO: implement listener
        setState(() {
          isNightMode = state.isNightMode;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomWidgetDetail(
            isNightMode: isNightMode,
            icon: Icons.sunny,
            day: 'Fri',
            data: '28.10',
            temperature: '15°C',
            isSelected: false,
          ),
          BottomWidgetDetail(
            isNightMode: isNightMode,
            icon: Icons.cloud,
            day: 'Sat',
            data: '29.10',
            temperature: '19°C',
            isSelected: true,
          ),
          BottomWidgetDetail(
            isNightMode: isNightMode,
            icon: Icons.wind_power,
            day: 'Sun',
            data: '30.10',
            temperature: '18°C',
            isSelected: false,
          ),
          BottomWidgetDetail(
            isNightMode: isNightMode,
            icon: Icons.cloudy_snowing,
            day: ':(',
            data: '31.11',
            temperature: '15°C',
            isSelected: false,
          ),
        ],
      ),
    );
  }
}

class BottomWidgetDetail extends StatelessWidget {
  const BottomWidgetDetail({
    Key? key,
    required this.isNightMode,
    required this.day,
    required this.data,
    required this.temperature,
    required this.icon,
    required this.isSelected,
  }) : super(key: key);

  final bool isNightMode;
  final String day;
  final String data;
  final String temperature;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 60,
      decoration: isSelected
          ? BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    isNightMode
                        ? const Color.fromARGB(255, 1, 30, 126)
                        : Colors.blue,
                    isNightMode
                        ? const Color.fromARGB(255, 0, 140, 255)
                        : const Color.fromARGB(255, 129, 225, 255),
                  ]),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            )
          : null,
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            day,
            style: TextStyle(
              color: isNightMode ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
          Text(
            data,
            style: TextStyle(
                color: isNightMode ? Colors.white : Colors.black, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Icon(
            icon,
            color: isNightMode ? Colors.white : Colors.black,
          ),
          const SizedBox(height: 8),
          Text(
            temperature,
            style: TextStyle(
              color: isNightMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
  bool isNightMode = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isNightMode = !isNightMode;
          isNightMode
              ? context.read<MainCubit>().switchNightMode()
              : context.read<MainCubit>().switchDailyMode();
        });
      },
      child: Image.asset(
        isNightMode
            ? 'images/night_mode_button.png'
            : 'images/light_mode_button.png',
        width: 80,
      ),
    );
  }
}

class TopWidget extends StatefulWidget {
  const TopWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TopWidget> createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  bool isNightMode = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) {
        // ignore: todo
        // TODO: implement listener
        setState(() {
          isNightMode = state.isNightMode;
        });
      },
      child: Stack(
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
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  isNightMode
                      ? const Color.fromARGB(255, 0, 81, 255)
                      : const Color(0xFF67DED3),
                  isNightMode
                      ? const Color.fromARGB(255, 13, 0, 201)
                      : const Color(0xFF51A8FD),
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
                      '19°',
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
                          'Zadubie',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Saturday, 10/22',
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
      ),
    );
  }
}

class MiddleWidget extends StatefulWidget {
  const MiddleWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MiddleWidget> createState() => _MiddleWidgetState();
}

class _MiddleWidgetState extends State<MiddleWidget> {
  bool isNightMode = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) {
        // ignore: todo
        // TODO: implement listener

        setState(() {
          isNightMode = state.isNightMode;
        });
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(32)),
          color: isNightMode
              ? const Color.fromARGB(255, 0, 24, 160)
              : Colors.white,
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isNightMode ? Colors.white : Colors.black,
                  ),
                ),
                Icon(
                  Icons.refresh,
                  color: isNightMode ? Colors.white : Colors.black45,
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
      ),
    );
  }
}

class GridDetailsElement extends StatefulWidget {
  const GridDetailsElement({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final IconData icon;

  @override
  State<GridDetailsElement> createState() => _GridDetailsElementState();
}

class _GridDetailsElementState extends State<GridDetailsElement> {
  bool isNightMode = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) {
        // ignore: todo
        // TODO: implement listener
        setState(() {
          isNightMode = state.isNightMode;
        });
      },
      child: Column(
        children: [
          Icon(
            widget.icon,
            color: Colors.cyan,
          ),
          const SizedBox(height: 4),
          const Text(
            'wind',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            '9km/h',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isNightMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
