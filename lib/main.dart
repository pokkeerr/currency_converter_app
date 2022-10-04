import 'package:currency_converter_app/cubits/currency_convert_cubit/currency_convert_cubit.dart';
import 'package:currency_converter_app/cubits/internet_connection/internet_connection_cubit.dart';
import 'package:currency_converter_app/cubits/supoort_countries_cubit/suppourted_countries_cubit.dart';
import 'package:currency_converter_app/data/db/currency_convert_db.dart';
import 'package:currency_converter_app/data/di.dart';
import 'package:currency_converter_app/data/repos/currency_convert_repo.dart';
import 'package:currency_converter_app/data/repos/support_countreis_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>(create: (_) => di<InternetCubit>()),
          BlocProvider<SuppourtedCountriesCubit>(
              create: (_) => SuppourtedCountriesCubit(
                  di<SupportCountriesRepo>(),
                  di<CurrencyConverterDB>(),
                  di<InternetCubit>())),
          BlocProvider<CurrencyConvertCubit>(
              create: (_) => CurrencyConvertCubit(di<CurrencyConvertRepo>(),
                  di<CurrencyConverterDB>(), di<InternetCubit>())),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
              title: 'Curruncy Converter',
              theme: ThemeData(primarySwatch: Colors.blue),
              home: const MyHomePage());
        }));
  }
}
