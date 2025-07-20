import 'package:bloc_project/route/app_pages.dart';
import 'package:bloc_project/route/app_routes.dart';
import 'package:bloc_project/src/generated/i18n/app_localizations.dart';
import 'package:bloc_project/theme/app_theme.dart';
import 'package:bloc_project/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/profile_bloc.dart';
import 'i18n/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('th');

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<ProfileBloc>(create: (_) => ProfileBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: _themeMode,
        locale: _locale,
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        onGenerateRoute: AppPages.onGenerateRoute,
        // initialRoute: AppRoutes.login,
        home: Builder(
          builder:
              (context) => Scaffold(
                appBar: AppBar(
                  title: Text(AppLocalizations.of(context)!.appTitle),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.brightness_6),
                      onPressed: _toggleTheme,
                    ),
                    PopupMenuButton(
                      icon: const Icon(Icons.language),
                      onSelected: (value) {
                        _changeLocale(Locale(value));
                      },
                      itemBuilder:
                          (_) => [
                            const PopupMenuItem(
                              value: 'en',
                              child: Text('English'),
                            ),
                            const PopupMenuItem(
                              value: 'th',
                              child: Text('ไทย'),
                            ),
                          ],
                    ),
                  ],
                ),
                body: const LoginScreen(),
              ),
        ),
      ),
    );
  }
}
