import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hiddify/core/router/app_router.dart';
import 'package:hiddify/features/about/view/about_page.dart';
import 'package:hiddify/features/common/adaptive_root_scaffold.dart';
import 'package:hiddify/features/geo_asset/overview/geo_assets_overview_page.dart';
import 'package:hiddify/features/home/view/view.dart';
import 'package:hiddify/features/intro/intro_page.dart';
import 'package:hiddify/features/logs/view/logs_page.dart';
import 'package:hiddify/features/profile/add/add_profile_modal.dart';
import 'package:hiddify/features/profile/details/profile_details_page.dart';
import 'package:hiddify/features/profile/overview/profiles_overview_page.dart';
import 'package:hiddify/features/proxies/view/view.dart';
import 'package:hiddify/features/settings/view/config_options_page.dart';
import 'package:hiddify/features/settings/view/per_app_proxy_page.dart';
import 'package:hiddify/features/settings/view/settings_page.dart';
import 'package:hiddify/utils/utils.dart';

part 'routes.g.dart';

GlobalKey<NavigatorState>? _dynamicRootKey =
    useMobileRouter ? rootNavigatorKey : null;

@TypedShellRoute<MobileWrapperRoute>(
  routes: [
    TypedGoRoute<IntroRoute>(path: "/intro", name: IntroRoute.name),
    TypedGoRoute<HomeRoute>(
      path: "/",
      name: HomeRoute.name,
      routes: [
        TypedGoRoute<AddProfileRoute>(
          path: "add",
          name: AddProfileRoute.name,
        ),
        TypedGoRoute<ProfilesOverviewRoute>(
          path: "profiles",
          name: ProfilesOverviewRoute.name,
        ),
        TypedGoRoute<NewProfileRoute>(
          path: "profiles/new",
          name: NewProfileRoute.name,
        ),
        TypedGoRoute<ProfileDetailsRoute>(
          path: "profiles/:id",
          name: ProfileDetailsRoute.name,
        ),
        TypedGoRoute<LogsRoute>(
          path: "logs",
          name: LogsRoute.name,
        ),
        TypedGoRoute<SettingsRoute>(
          path: "settings",
          name: SettingsRoute.name,
          routes: [
            TypedGoRoute<ConfigOptionsRoute>(
              path: "config-options",
              name: ConfigOptionsRoute.name,
            ),
            TypedGoRoute<PerAppProxyRoute>(
              path: "per-app-proxy",
              name: PerAppProxyRoute.name,
            ),
            TypedGoRoute<GeoAssetsRoute>(
              path: "routing-assets",
              name: GeoAssetsRoute.name,
            ),
          ],
        ),
        TypedGoRoute<AboutRoute>(
          path: "about",
          name: AboutRoute.name,
        ),
      ],
    ),
    TypedGoRoute<ProxiesRoute>(
      path: "/proxies",
      name: ProxiesRoute.name,
    ),
  ],
)
class MobileWrapperRoute extends ShellRouteData {
  const MobileWrapperRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return AdaptiveRootScaffold(navigator);
  }
}

@TypedShellRoute<DesktopWrapperRoute>(
  routes: [
    TypedGoRoute<IntroRoute>(path: "/intro", name: IntroRoute.name),
    TypedGoRoute<HomeRoute>(
      path: "/",
      name: HomeRoute.name,
      routes: [
        TypedGoRoute<AddProfileRoute>(
          path: "add",
          name: AddProfileRoute.name,
        ),
        TypedGoRoute<ProfilesOverviewRoute>(
          path: "profiles",
          name: ProfilesOverviewRoute.name,
        ),
        TypedGoRoute<NewProfileRoute>(
          path: "profiles/new",
          name: NewProfileRoute.name,
        ),
        TypedGoRoute<ProfileDetailsRoute>(
          path: "profiles/:id",
          name: ProfileDetailsRoute.name,
        ),
      ],
    ),
    TypedGoRoute<ProxiesRoute>(
      path: "/proxies",
      name: ProxiesRoute.name,
    ),
    TypedGoRoute<LogsRoute>(
      path: "/logs",
      name: LogsRoute.name,
    ),
    TypedGoRoute<SettingsRoute>(
      path: "/settings",
      name: SettingsRoute.name,
      routes: [
        TypedGoRoute<ConfigOptionsRoute>(
          path: "config-options",
          name: ConfigOptionsRoute.name,
        ),
        TypedGoRoute<GeoAssetsRoute>(
          path: "routing-assets",
          name: GeoAssetsRoute.name,
        ),
      ],
    ),
    TypedGoRoute<AboutRoute>(
      path: "/about",
      name: AboutRoute.name,
    ),
  ],
)
class DesktopWrapperRoute extends ShellRouteData {
  const DesktopWrapperRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return AdaptiveRootScaffold(navigator);
  }
}

class IntroRoute extends GoRouteData {
  const IntroRoute();
  static const name = "Intro";

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const MaterialPage(
      fullscreenDialog: true,
      name: name,
      child: IntroPage(),
    );
  }
}

class HomeRoute extends GoRouteData {
  const HomeRoute();
  static const name = "Home";

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(
      name: name,
      child: HomePage(),
    );
  }
}

class ProxiesRoute extends GoRouteData {
  const ProxiesRoute();
  static const name = "Proxies";

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(
      name: name,
      child: ProxiesPage(),
    );
  }
}

class AddProfileRoute extends GoRouteData {
  const AddProfileRoute({this.url});

  final String? url;

  static const name = "Add Profile";

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return BottomSheetPage(
      fixed: true,
      name: name,
      builder: (controller) => AddProfileModal(
        url: url,
        scrollController: controller,
      ),
    );
  }
}

class ProfilesOverviewRoute extends GoRouteData {
  const ProfilesOverviewRoute();
  static const name = "Profiles";

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return BottomSheetPage(
      name: name,
      builder: (controller) =>
          ProfilesOverviewModal(scrollController: controller),
    );
  }
}

class NewProfileRoute extends GoRouteData {
  const NewProfileRoute();
  static const name = "New Profile";

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const MaterialPage(
      fullscreenDialog: true,
      name: name,
      child: ProfileDetailsPage("new"),
    );
  }
}

class ProfileDetailsRoute extends GoRouteData {
  const ProfileDetailsRoute(this.id);
  final String id;
  static const name = "Profile Details";

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage(
      fullscreenDialog: true,
      name: name,
      child: ProfileDetailsPage(id),
    );
  }
}

class LogsRoute extends GoRouteData {
  const LogsRoute();
  static const name = "Logs";

  static final GlobalKey<NavigatorState>? $parentNavigatorKey = _dynamicRootKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    if (useMobileRouter) {
      return const MaterialPage(
        fullscreenDialog: true,
        name: name,
        child: LogsPage(),
      );
    }
    return const NoTransitionPage(name: name, child: LogsPage());
  }
}

class SettingsRoute extends GoRouteData {
  const SettingsRoute();
  static const name = "Settings";

  static final GlobalKey<NavigatorState>? $parentNavigatorKey = _dynamicRootKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    if (useMobileRouter) {
      return const MaterialPage(
        fullscreenDialog: true,
        name: name,
        child: SettingsPage(),
      );
    }
    return const NoTransitionPage(name: name, child: SettingsPage());
  }
}

class ConfigOptionsRoute extends GoRouteData {
  const ConfigOptionsRoute();
  static const name = "Config Options";

  static final GlobalKey<NavigatorState>? $parentNavigatorKey = _dynamicRootKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    if (useMobileRouter) {
      return const MaterialPage(
        fullscreenDialog: true,
        name: name,
        child: ConfigOptionsPage(),
      );
    }
    return const MaterialPage(
      fullscreenDialog: true,
      name: name,
      child: ConfigOptionsPage(),
    );
  }
}

class PerAppProxyRoute extends GoRouteData {
  const PerAppProxyRoute();
  static const name = "Per-app Proxy";

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const MaterialPage(
      fullscreenDialog: true,
      name: name,
      child: PerAppProxyPage(),
    );
  }
}

class GeoAssetsRoute extends GoRouteData {
  const GeoAssetsRoute();
  static const name = "Routing Assets";

  static final GlobalKey<NavigatorState>? $parentNavigatorKey = _dynamicRootKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    if (useMobileRouter) {
      return const MaterialPage(
        fullscreenDialog: true,
        name: name,
        child: GeoAssetsOverviewPage(),
      );
    }
    return const MaterialPage(
      fullscreenDialog: true,
      name: name,
      child: GeoAssetsOverviewPage(),
    );
  }
}

class AboutRoute extends GoRouteData {
  const AboutRoute();
  static const name = "About";

  static final GlobalKey<NavigatorState>? $parentNavigatorKey = _dynamicRootKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    if (useMobileRouter) {
      return const MaterialPage(
        fullscreenDialog: true,
        name: name,
        child: AboutPage(),
      );
    }
    return const NoTransitionPage(name: name, child: AboutPage());
  }
}
