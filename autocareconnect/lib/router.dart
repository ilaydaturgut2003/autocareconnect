import 'package:auto_route/auto_route.dart';
import 'package:autocareconnect/router.gr.dart';
import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/home_page.dart';

//AppRouter
@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List <AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: SignUpRoute.page, path: '/signup'),
    AutoRoute(page: HomeRoute.page, path: '/home', initial: true),
  ];
}
