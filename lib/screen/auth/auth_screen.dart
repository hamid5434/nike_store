import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/bloc/auth/auth_bloc.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/widgets/widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController usernameController =
      TextEditingController(text: 'h_khobani@yahoo.com');
  TextEditingController passwordController =
      TextEditingController(text: 'hamid54');

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const onBackground = Colors.white;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Theme(
        data: themeData.copyWith(
            snackBarTheme: SnackBarThemeData(
                backgroundColor: themeData.colorScheme.primary,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size.fromHeight(56),
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
                  backgroundColor: MaterialStateProperty.all(onBackground),
                  foregroundColor: MaterialStateProperty.all(
                      themeData.colorScheme.secondary)),
            ),
            colorScheme:
                themeData.colorScheme.copyWith(onSurface: onBackground),
            inputDecorationTheme: InputDecorationTheme(
                labelStyle: const TextStyle(
                  color: onBackground,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1)))),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: BlocProvider<AuthBloc>(
                create: (context) {
                  final bloc = AuthBloc(authRepository);
                  bloc.stream.forEach((state) {
                    if (state is AuthSuccess) {
                      Navigator.pop(context);
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.exception.message),
                        ),
                      );
                    }
                  });
                  bloc.add(AuthStated());
                  return bloc;
                },
                child: BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) {
                    return current is AuthLoading ||
                        current is AuthInitial ||
                        current is AuthError;
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/nike_logo.png',
                          color: Colors.white,
                          width: 120,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'خوش آمدید',
                          style: themeData.textTheme.headline4!.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'لطفا وارد حساب کاربری خود شوید.',
                          style: themeData.textTheme.headline6!.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller: usernameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              const InputDecoration(label: Text('آدرس ایمیل')),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        PasswordTextField(
                          controller: passwordController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            BlocProvider.of<AuthBloc>(context).add(
                                AuthButtonIsClicked(usernameController.text,
                                    passwordController.text));
                          },
                          child: state is AuthLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  state.isLoginMode ? 'ورود' : 'ثبت نام',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(AuthModeChangeIsClicked());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.isLoginMode
                                    ? 'حساب کاربری ندارید؟'
                                    : 'حساب کاربری دارید؟',
                                style: TextStyle(
                                    color: onBackground.withOpacity(0.7)),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                state.isLoginMode ? 'ثبت نام' : 'ورود',
                                style: TextStyle(
                                    color: themeData.colorScheme.primary,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
