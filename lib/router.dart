import 'package:auto_route/auto_route.dart';
import 'package:autocareconnect/router.gr.dart';

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
