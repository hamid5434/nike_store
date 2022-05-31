import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_store/bloc/cart/cart_bloc.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/models/cart/cart_item_entity.dart';
import 'package:nike_store/models/login/login_model.dart';
import 'package:nike_store/screen/auth/auth_screen.dart';
import 'package:nike_store/screen/cart/widget/widgtes.dart';
import 'package:nike_store/widgets/image_loading_service.dart';
import 'package:nike_store/widgets/widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc? cartBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AuthRepository.authChangeNotifier.addListener(authChangeNotifierListener);
  }

  void authChangeNotifierListener() {
    cartBloc?.add(CartAuthInfoChanged(AuthRepository.authChangeNotifier.value));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AuthRepository.authChangeNotifier
        .removeListener(authChangeNotifierListener);
    cartBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryVariant,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('سبد خرید'),
        ),
        body: BlocProvider<CartBloc>(
          create: (context) {
            final bloc = CartBloc(cartRepository);
            cartBloc = bloc;
            bloc.add(CartStarted(AuthRepository.authChangeNotifier.value));
            return bloc;
          },
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CartError) {
                return Center(
                  child: Text(state.exception.message.toString()),
                );
              } else if (state is CartSuccess) {
                final cartItems = state.cartItems;
                return ListView.builder(
                  itemCount: cartItems.cartItems!.length,
                  itemBuilder: (context, index) {
                    final data = cartItems.cartItems![index];
                    return CartItem(
                      data: data,
                      onDeleteButtonClick: () {
                        cartBloc?.add(CartDeleteButtonClicked(data.cartItemId!));
                      },
                    );
                  },
                );
              } else if (state is CartAuthRequired) {
                return EmptyView(
                  image: SvgPicture.asset(
                    'assets/images/auth_required.svg',
                    width: 140,
                    height: 140,
                  ),
                  message:
                      'کاربر گرامی برای مشاهده سبد خرید باید ابتدا وارد حساب کاربری خود شوید .',
                  callToAction: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'ورود',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                  ),
                );
              } else if (state is CartEmpty) {
                return EmptyView(
                  image: SvgPicture.asset(
                    'assets/images/empty_cart.svg',
                    width: 150,
                    height: 150,
                  ),
                  message: 'سبد خرید شما خالی می باشد.',
                );
              } else {
                throw Exception('state not support');
              }
            },
          ),
        )

        // ValueListenableBuilder<LoginModel?>(
        //   valueListenable: AuthRepository.authChangeNotifier,
        //   builder: (context, authState, child) {
        //     bool isAuthenticated =
        //         authState != null && authState.accessToken!.isNotEmpty;
        //     return SizedBox(
        //       width: MediaQuery.of(context).size.width,
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Text(isAuthenticated
        //               ? 'خوش آمدید'
        //               : 'لطفا وارد حساب کاربری خود شوید'),
        //           isAuthenticated
        //               ? ElevatedButton(
        //             onPressed: () async {
        //               await authRepository.signOut();
        //             },
        //             child: const Text(
        //               'خروج از حساب',
        //             ),
        //           )
        //               : ElevatedButton(
        //             onPressed: () {
        //               Navigator.of(context, rootNavigator: true).push(
        //                 MaterialPageRoute(
        //                   builder: (context) => const AuthScreen(),
        //                 ),
        //               );
        //             },
        //             child: const Text(
        //               'وورد',
        //             ),
        //           ),
        //           ElevatedButton(
        //             onPressed: () async {
        //               await authRepository.refreshToken();
        //             },
        //             child: const Text(
        //               'Refresh Token',
        //             ),
        //           )
        //         ],
        //       ),
        //     );
        //   },
        // ),

        );
  }
}
