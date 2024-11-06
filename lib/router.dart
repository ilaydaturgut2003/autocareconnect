import 'package:auto_route/auto_route.dart';
import 'package:autocareconnect/router.gr.dart';
import 'package:flutter/material.dart';

import 'package:autocareconnect/pages/home_page.dart';
import 'package:autocareconnect/pages/login_page.dart';
import 'package:autocareconnect/pages/signup_page.dart';
import 'package:autocareconnect/pages/profile_page.dart';
import 'package:autocareconnect/pages/browse_services_page.dart';
import 'package:autocareconnect/pages/service_details_page.dart';
import 'package:autocareconnect/pages/booking_page.dart';
import 'package:autocareconnect/pages/provider_dashboard_page.dart';
import 'package:autocareconnect/pages/help_support_page.dart';

//AppRouter
@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List <AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: '/home', initial: true),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: SignUpRoute.page, path: '/signup'),
    AutoRoute(page: ServiceDetailsRoute.page, path: '/service_details'),
    AutoRoute(page: BrowseServicesRoute.page, path: '/browse_services'),
    AutoRoute(page: ProfileRoute.page, path: '/myprofile'),
    AutoRoute(page: BookingRoute.page, path: '/booking_page'),
    AutoRoute(page: ProviderDashboardRoute.page, path: '/provider_dashboard'),
    AutoRoute(page: HelpSupportRoute.page, path: '/help_and_support'),
  ];
}
