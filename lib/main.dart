import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'Cubit_Shop/cubit.dart';
import 'Login_Screen.dart';
import 'OnBoarding_Screen.dart';
import 'Shop_Layout.dart';
import 'SplashScreen.dart';
import 'Themes/themes.dart';
import 'cubit_login/cubit_observer.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token')??'';
  print(token);

  if(onBoarding != null)
  {
    if(token.isNotEmpty) widget = ShopLayout();
    else widget = ShopLoginScreen();
  } else
  {
    widget = OnboardingScreen();
  }
  // CacheHelper.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(
        startWidget: widget,
      ),
    ),
  );}

class MyApp extends StatelessWidget {

   Widget? startWidget;


  MyApp({
     this.startWidget,
  });


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: themeProvider.themeMode,
              theme: lighttheme,
              darkTheme: darktheme,
              home: SplashScreen(),

            );
          }
      ),
    );
  }
}