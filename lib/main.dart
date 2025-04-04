import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iact/Desktop/Landing_page.dart';
import 'package:iact/mobile/MobileLayout.dart';
import 'package:iact/mobile/MobilePortfolioPage.dart';
import 'package:iact/mobile/MobileServicesPage.dart';
import 'package:iact/mobile/MobileTeamPage.dart';
import 'package:iact/mobile/MobileAboutPage.dart';

void main() {
  runApp(const MyApp());
}

class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  const ResponsiveLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use 1200 as the breakpoint for mobile/desktop
        if (constraints.maxWidth < 1200) {
          return MobileLayout(child: child);
        } else {
          // For desktop, return the child directly without the mobile layout wrapper
          return child;
        }
      },
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) => ResponsiveLayout(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LandingPage(),
        ),
        GoRoute(
          path: '/services',
          builder: (context, state) => const MobileServicesPage(),
        ),
        GoRoute(
          path: '/portfolio',
          builder: (context, state) => const MobilePortfolioPage(),
        ),
        GoRoute(
          path: '/team',
          builder: (context, state) => const MobileTeamPage(),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const MobileAboutPage(),
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
