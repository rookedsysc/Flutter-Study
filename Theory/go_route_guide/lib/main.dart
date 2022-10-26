import 'package:flutter/material.dart';
import 'package:go_route_guide/screen/fifth_screen.dart';
import 'package:go_router/go_router.dart';
import 'screen/home_screen.dart';
import 'screen/second_screen.dart';
import 'screen/third_screen.dart';
import 'screen/fourth_screen.dart';
import 'screen/fifth_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

void main() {
  return runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: "GoRouter Example",
    );
  }

  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/homescreen',
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
                path: '/homescreen',
                builder: (context, state) => HomeScreen(),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details',
                    builder: (context, state) => DetailsScreen(label: 'HOMESCREEN'),
                  )
                ],
              ),

              GoRoute(
                path: '/secondscreen',
                builder: (context, state) => SecondScreen(),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details',
                    builder: (context, state) => DetailsScreen(label: '/SECONDSCREEN'),
                  )
                ],
              ),

              GoRoute(
                path: '/thirdscreen',
                builder: (context, state) => ThirdScreen(),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details',
                    builder: (context, state) => DetailsScreen(label: 'THIRDSCREEN'),
                  )
                ],
              ),

              GoRoute(
                path: '/fourthscreen',
                builder: (context, state) => FourthScreen(),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details',
                    builder: (context, state) => DetailsScreen(label: 'FOURTHSCREEN'),
                  )
                ],
              ),

              GoRoute(
                path: '/fifthscreen',
                builder: (context, state) => FifthScreen(),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details',
                    builder: (context, state) => DetailsScreen(label: 'FIFTHSCREEN'),
                  )
                ],
              ),
        ]
      ),
      

    /*GoRoute(
      path: '/',
      builder: ((context, state) {
        return HomeScreen();
      })
    ),
    GoRoute(
      path: '/screen2',
      builder: ((context, state) {
        return SecondScreen();
      })
    ),
    GoRoute(
      path: '/screen3',
      builder: ((context, state) {
        return ThirdScreen();
      })
    ),
    GoRoute(
      path: '/screen4',
      builder: ((context, state) {
        return FourthScreen();
      })
    ),
    GoRoute(
      path: '/screen5',
      builder: ((context, state) {
        return FifthScreen();
      })
    ), */
  ]);
}


class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.child,
    Key? key,
  }) : super(key: key);

  /// The widget to display in the body of the Scaffold.
  /// In this sample, it is a Navigator.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color:Colors.black),
            label: 'Home',
            backgroundColor: Colors.green
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black,),
            label: 'Second',
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black,),
            label: 'Third',
            backgroundColor: Colors.orange
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black,),
            label: 'Fourth',
            backgroundColor: Colors.yellow
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black,),
            label: 'Fifth',
            backgroundColor: Colors.purple
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    if (location.startsWith('/homescreen')) {
      return 0;
    }
    if (location.startsWith('/secondscreen')) {
      return 1;
    }
    if (location.startsWith('/thirdscreen')) {
      return 2;
    }
    if (location.startsWith('/fourthscreen')) {
      return 3;
    }
    if (location.startsWith('/fifthscreen')) {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/homescreen');
        break;
      case 1:
        GoRouter.of(context).go('/secondscreen');
        break;
      case 2:
        GoRouter.of(context).go('/thirdscreen');
        break;
        case 3:
        GoRouter.of(context).go('/fourthscreen');
        break;
        case 4:
        GoRouter.of(context).go('/fifthscreen');
        break;

    }
  }
}

class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    Key? key,
  }) : super(key: key);

  /// The label to display in the center of the screen.
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: Center(
        child: Text(
          'Details for $label',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}