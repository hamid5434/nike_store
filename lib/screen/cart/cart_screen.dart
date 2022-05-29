import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/bloc/cart/cart_bloc.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/models/cart/cart_item_entity.dart';
import 'package:nike_store/models/login/login_model.dart';
import 'package:nike_store/screen/auth/auth_screen.dart';
import 'package:nike_store/widgets/image_loading_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // cartRepository.getAll().then((value) {
    //   print(value.toString());
    // }).catchError((e) {
    //   print(e.toString());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('سبد خرید'),
        ),
        body: BlocProvider<CartBloc>(
          create: (context) {
            final bloc = CartBloc(cartRepository);
            bloc.add(CartStarted());
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
                return ListView.builder(
                  itemCount: state.cartItems.cartItems!.length,
                  itemBuilder: (context, index) {
                    final data = state.cartItems.cartItems![index];
                    return Container(
                      //height: 120,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.05),
                                blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ImageLoadingService(
                                    url: data.product!.image!,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Text(
                                    data.product!.title!,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'تعداد',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                CupertinoIcons.plus_app)),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          data.count!.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                CupertinoIcons.minus_square)),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      data.product!.previusPrice!.withPriceLabel,
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      data.product!.price!.withPriceLabel,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          InkWell(
                            onTap: () {
                              print('hamid');
                            },
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'حذف از سبد خرید',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
