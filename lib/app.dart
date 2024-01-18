import 'package:minakomi/screens/auth/auth_init.dart';
import 'package:minakomi/utils/local_storage.dart';
import 'package:minakomi/utils/tablet_detector.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:minakomi/export.dart';
import 'blocs/auth/auth_bloc.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    changeTheme();
    super.initState();
  }

  changeTheme() async {
    String theme = await LocalStorage().readTheme();
    context.read<AuthBloc>().add(AuthChangeTheme(theme: theme));
  }

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return OverlaySupport.global(
      toastTheme: ToastThemeData(
        background: AppColors.primary,
      ),
      child: GestureDetector(onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      }, child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.themeData,
            navigatorObservers: [
              BotToastNavigatorObserver(),
            ],
            builder: (context, child) {
              final MediaQueryData data = MediaQuery.of(context);
              final isTablet = TabletDetector.isTablet(context);
              child = botToastBuilder(context, child);
              return MediaQuery(
                data: data.copyWith(textScaleFactor: isTablet ? 1.2 : 1),
                child: child,
              );
            },
            // initialRoute: '/authInit',

            // onGenerateRoute: (settings) {
            //   // print("settings route name: ${settings.name}");
            //   // print(settings);
            //   // if (settings.name == 'select_music_page') {
            //   //   return MaterialPageRoute(builder: (_) => const SelectMusic());
            //   // }
            //   return MaterialPageRoute(builder: (_) => AuthInit());
            // },
            navigatorKey: NavigationService.instance.navigationKey,
            themeMode: ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            supportedLocales: const [Locale('en', 'US')],
            home: AuthInit(),
          );
        },
      )),
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
