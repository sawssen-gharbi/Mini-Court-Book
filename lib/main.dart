import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_court_book/core/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_court_book/features/bookings/presentation/blocs/bloc/my_booking_bloc.dart';
import 'package:mini_court_book/features/facilities/presentation/blocs/bloc/facility_bloc.dart';
import 'package:mini_court_book/features/facilities/presentation/pages/home_screen.dart';
import 'package:mini_court_book/injection_container.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();
  await di.serviceLocator.allReady();

  runApp(DevicePreview(enabled: false, builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 883),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<FacilityBloc>()),
            BlocProvider(create: (_) => serviceLocator<MyBookingBloc>()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            title: 'Mini CourtBook',
            theme: AppTheme.theme,
            home: HomeScreen(),
          ),
        );
      },
    );
  }
}
