import 'package:flutter/material.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/widgets/widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  TextEditingController usernameController =
      TextEditingController(text: 'h_khobani@yahoo.com');
  TextEditingController passwordController =
      TextEditingController(text: 'hamid54');

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const onBackground = Colors.white;
    return Theme(
      data: themeData.copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size.fromHeight(56),
                ),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                backgroundColor: MaterialStateProperty.all(onBackground),
                foregroundColor:
                    MaterialStateProperty.all(themeData.colorScheme.secondary)),
          ),
          colorScheme: themeData.colorScheme.copyWith(onSurface: onBackground),
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
            child: Column(
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
                  decoration: const InputDecoration(label: Text('آدرس ایمیل')),
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
                    await authRepository.login(
                      username: usernameController.text,
                      password: passwordController.text,
                    );

                    //await authRepository.refreshToken(token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImFkYTJkMTk3YmI4ODI1ZTJiZDMyNzRkYmYxM2JmZGNmNGVlN2IwMmZmNjc1MzdjMWUxZWNmYmM5NzgzMTYyNDJiOTkyNWY4MzI3YjM4MDNhIn0.eyJhdWQiOiIyIiwianRpIjoiYWRhMmQxOTdiYjg4MjVlMmJkMzI3NGRiZjEzYmZkY2Y0ZWU3YjAyZmY2NzUzN2MxZTFlY2ZiYzk3ODMxNjI0MmI5OTI1ZjgzMjdiMzgwM2EiLCJpYXQiOjE2NTM0OTczMDIsIm5iZiI6MTY1MzQ5NzMwMiwiZXhwIjoxNjg1MDMzMzAyLCJzdWIiOiIxMDc3Iiwic2NvcGVzIjpbXX0.CnF9NcbUSoxCbqnjUxvldJOYL2t4uUTTgQuY8A3yYO1zbCUole-_ujUgG2fop17NPMWjylw8Hi77iYZb52uPIxkiY1PGeQL2veUlNsQOZhUcDfSpg5IPd7eExUUZPTIQOuXiJJtEIvgwMvROk0pGptWw6kwti_a26a3carbqmwVtNA14tnEnNA5CmVXvfew3QwFuuLDlurEzxFne5l6MeU3568yKI6OmoY5FFHU6ktOOShxySOftlTrtBknjOax5GwlbAdxB6B7sucUxvSjvskb-UmriqxXr2A_9_yPRyjXATtvLZPLxn0hrRGD4jtdG_HrpaiVGsawJrqisyzPDfP_9K51jCB8dDYVwOIjtmMiMdVMFHgVWNw5ge782nr8gYukSZz8YomR44JdgrViukAww7T1jWoSpVQDnJ4ttdl7oN5KcppDPuVaLwo23zjiyVCHc7nA99L6-8UrTt_9afkQ5sSiMRzwTA2zw-VcDpCkvgkr0WKJQkzmhYKq8U24_ggibhy8iiyv11WMS1r56CTRMJeiinpOv56IHl2Dy0oaK2pxi9Q-riZDkwG0Zq51EsNkmJcHHtiQg-Z6jkccg4lii-XXPUNKowEGxni');

                    // try {
                    //   await authRepository.register(username: 'hamid@yahoo.com', password: 'hamid54');
                    // } catch (ex) {
                    //   print(ex.toString());
                    // }
                    //
                  },
                  child: Text(
                    isLogin ? 'ورود' : 'ثبت نام',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isLogin ? 'حساب کاربری ندارید؟' : 'حساب کاربری دارید؟',
                        style: TextStyle(color: onBackground.withOpacity(0.7)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        isLogin ? 'ثبت نام' : 'ورود',
                        style: TextStyle(
                            color: themeData.colorScheme.primary,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
