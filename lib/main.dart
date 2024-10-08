import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/authentication/bloc/authentication_bloc.dart';
import 'package:millima/features/authentication/views/login_screen.dart';
import 'package:millima/features/home/ui/screens/managment_screen.dart';
import 'package:millima/features/user/bloc/user_bloc.dart';
import 'package:millima/features/user/bloc/user_event.dart';
import 'package:millima/utils/locator.dart';
import 'package:millima/utils/providers.dart';

import 'utils/helpers/dialogs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dependencySetUp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.isLoading) {
            } else {
              AppDialogs.hideLoading(context);

              if (state.error != null) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: state.error == 'Unauthorised'
                          ? const Text(
                              "Unable to Login, password or phone number incorrect")
                          : Text(state.error.toString()),
                      backgroundColor: Colors.red,
                    ),
                  );
                return;
              }
            }

            if (state.status == AuthenticationStatus.authenticated) {
              context.read<UserBloc>().add(GetUserEvent());
            }
          },
          builder: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return const ManagmentScreen();
            }

            return LoginScreen();
          },
        ),
      ),
    );
  }
}
