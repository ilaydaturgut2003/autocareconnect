// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:autocareconnect/pages/application_status_page.dart' as _i1;
import 'package:autocareconnect/pages/booking_page.dart' as _i2;
import 'package:autocareconnect/pages/browse_services_page.dart' as _i3;
import 'package:autocareconnect/pages/help_support_page.dart' as _i4;
import 'package:autocareconnect/pages/home_page.dart' as _i5;
import 'package:autocareconnect/pages/login_page.dart' as _i6;
import 'package:autocareconnect/pages/post_service_page.dart' as _i7;
import 'package:autocareconnect/pages/profile_page.dart' as _i8;
import 'package:autocareconnect/pages/provider_dashboard_page.dart' as _i9;
import 'package:autocareconnect/pages/provider_signup_page.dart' as _i10;
import 'package:autocareconnect/pages/service_details_page.dart' as _i11;
import 'package:autocareconnect/pages/signup_page.dart' as _i12;
import 'package:flutter/material.dart' as _i14;

/// generated route for
/// [_i1.ApplicationStatusPage]
class ApplicationStatusRoute extends _i13.PageRouteInfo<void> {
  const ApplicationStatusRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ApplicationStatusRoute.name,
          initialChildren: children,
        );

  static const String name = 'ApplicationStatusRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i1.ApplicationStatusPage();
    },
  );
}

/// generated route for
/// [_i2.BookingPage]
class BookingRoute extends _i13.PageRouteInfo<void> {
  const BookingRoute({List<_i13.PageRouteInfo>? children})
      : super(
          BookingRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookingRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i2.BookingPage();
    },
  );
}

/// generated route for
/// [_i3.BrowseServicesPage]
class BrowseServicesRoute extends _i13.PageRouteInfo<void> {
  const BrowseServicesRoute({List<_i13.PageRouteInfo>? children})
      : super(
          BrowseServicesRoute.name,
          initialChildren: children,
        );

  static const String name = 'BrowseServicesRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i3.BrowseServicesPage();
    },
  );
}

/// generated route for
/// [_i4.HelpSupportPage]
class HelpSupportRoute extends _i13.PageRouteInfo<void> {
  const HelpSupportRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HelpSupportRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpSupportRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i4.HelpSupportPage();
    },
  );
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomePage();
    },
  );
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute({List<_i13.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i6.LoginPage();
    },
  );
}

/// generated route for
/// [_i7.PostServicePage]
class PostServiceRoute extends _i13.PageRouteInfo<void> {
  const PostServiceRoute({List<_i13.PageRouteInfo>? children})
      : super(
          PostServiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'PostServiceRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i7.PostServicePage();
    },
  );
}

/// generated route for
/// [_i8.ProfilePage]
class ProfileRoute extends _i13.PageRouteInfo<void> {
  const ProfileRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i8.ProfilePage();
    },
  );
}

/// generated route for
/// [_i9.ProviderDashboardPage]
class ProviderDashboardRoute
    extends _i13.PageRouteInfo<ProviderDashboardRouteArgs> {
  ProviderDashboardRoute({
    _i14.Key? key,
    required String userId,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          ProviderDashboardRoute.name,
          args: ProviderDashboardRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'ProviderDashboardRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProviderDashboardRouteArgs>();
      return _i9.ProviderDashboardPage(
        key: args.key,
        userId: args.userId,
      );
    },
  );
}

class ProviderDashboardRouteArgs {
  const ProviderDashboardRouteArgs({
    this.key,
    required this.userId,
  });

  final _i14.Key? key;

  final String userId;

  @override
  String toString() {
    return 'ProviderDashboardRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i10.ProviderSignupPage]
class ProviderSignupRoute extends _i13.PageRouteInfo<void> {
  const ProviderSignupRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ProviderSignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProviderSignupRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i10.ProviderSignupPage();
    },
  );
}

/// generated route for
/// [_i11.ServiceDetailsPage]
class ServiceDetailsRoute extends _i13.PageRouteInfo<ServiceDetailsRouteArgs> {
  ServiceDetailsRoute({
    _i14.Key? key,
    required String serviceId,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          ServiceDetailsRoute.name,
          args: ServiceDetailsRouteArgs(
            key: key,
            serviceId: serviceId,
          ),
          initialChildren: children,
        );

  static const String name = 'ServiceDetailsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ServiceDetailsRouteArgs>();
      return _i11.ServiceDetailsPage(
        key: args.key,
        serviceId: args.serviceId,
      );
    },
  );
}

class ServiceDetailsRouteArgs {
  const ServiceDetailsRouteArgs({
    this.key,
    required this.serviceId,
  });

  final _i14.Key? key;

  final String serviceId;

  @override
  String toString() {
    return 'ServiceDetailsRouteArgs{key: $key, serviceId: $serviceId}';
  }
}

/// generated route for
/// [_i12.SignUpPage]
class SignUpRoute extends _i13.PageRouteInfo<void> {
  const SignUpRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i12.SignUpPage();
    },
  );
}
