import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iact/Desktop/Landing_page.dart';
import 'package:iact/mobile/MobileLayout.dart';

import 'mobile/MobilePortfolioPage.dart';
import 'mobile/MobileServicesPage.dart';
import 'mobile/MobileTeamPage.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const LandingPage(),
      routes: [
        // ✅ Move nested routes here!
        GoRoute(
          path: 'services',
          builder: (context, state) => MobileLayout(
            child: const MobileServicesPage(),
          ),
        ),
        GoRoute(
          path: 'portfolio',
          builder: (context, state) => MobileLayout(
            child: const MobilePortfolioPage(),
          ),
        ),
        GoRoute(
          path: 'team',
          builder: (context, state) => MobileLayout(
            child: const MobileTeamPage(),
          ),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'IACT- Ideas In Action',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: false,
      ),
    );
  }
}
