import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ppob_app/features/account/kontak_favourite/kontakprovider_page.dart';
import 'package:ppob_app/features/account/preferensi/preferences_provider.dart'; // 🔹 provider baru
import 'package:ppob_app/shared/theme/app_theme.dart';
import 'package:ppob_app/shared/constants/app_constants.dart';
import 'package:ppob_app/splash_screen.dart';
import 'package:ppob_app/services/api_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PreferencesProvider()),
        ChangeNotifierProvider(create: (context) => KontakProvider()), // 🔹 tambahan
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached || state == AppLifecycleState.inactive) {
      ApiService.logout();
      // otomatis logout saat app ditutup
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        // Consumer tetap "mendengarkan" perubahan dari provider
        return Consumer<PreferencesProvider>(
          builder: (context, provider, child) {
            // ✅ PERBAIKAN: MaterialApp dibungkus dengan MediaQuery
            return MediaQuery(
              // Ambil data MediaQuery yang ada dan ubah textScaler-nya
              data: MediaQuery.of(context).copyWith(
                // textScaler digunakan untuk mengatur skala font global
                textScaler: TextScaler.linear(provider.fontSizeMultiplier),
              ),
              child: MaterialApp(
                title: AppStrings.appName,
                // Tema sekarang HANYA menerapkan fontFamily dari provider 
                theme: AppTheme.lightTheme.copyWith(
                  textTheme: AppTheme.lightTheme.textTheme.apply(
                    fontFamily: provider.fontFamily,
                  ),
                ),
                home: const SplashScreen(),
                debugShowCheckedModeBanner: false,
              ),
            );
          },
        );
      },
    );
  }
}