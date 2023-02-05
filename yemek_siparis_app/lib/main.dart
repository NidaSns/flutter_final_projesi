import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_app/ui/cubit/sepet_cubit.dart';
import 'package:yemek_siparis_app/ui/screens/anasayfa.dart';
import 'package:yemek_siparis_app/ui/screens/auth_screen.dart';
import 'ui/cubit/anasayfa_cubit.dart';
import 'ui/cubit/auth_cubit.dart';
import 'ui/cubit/yemek_detay_cubit.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => SepetCubit()),
        BlocProvider(create: (context) => YemekDetayCubit()),
        BlocProvider(create: (context) => AnasayfaCubit()),
      ],
      child: BlocConsumer<AuthCubit, void>(
        builder: (BuildContext ctx, auth) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.teal,
              ),
              home: ctx.read<AuthCubit>().isAuth
                  ? const Anasayfa()
                  : const AuthScreen());
        },
        listener: (ctx, isAuth) {},
      ),
    );
  }
}
