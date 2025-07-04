import 'package:coffee_shop_app/routes/app_router.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'coffee shop',
      routerConfig: appRouter,
    );
  }
}