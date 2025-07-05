import 'package:coffee_shop_app/screens/flash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, build)=> const FlashScreen()
    ),
  ]
);