import 'dart:async';

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
import 'package:nike_store/screen/cart/price_info_screen.dart';
import 'package:nike_store/screen/cart/widget/widgtes.dart';
import 'package:nike_store/screen/shipping/shipping_screen.dart';
import 'package:nike_store/widgets/image_loading_service.dart';
import 'package:nike_store/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc? cartBloc;
  final RefreshController _refreshController = RefreshController();
  StreamSubscription? stateStreamSubscription;
  ValueNotifier<bool> isShowButtonPay = ValueNotifier(false);

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
    _refreshController.dispose();
    stateStreamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryVariant,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('?????? ????????'),
        ),
        floatingActionButton: ValueListenableBuilder<bool>(
          valueListenable: isShowButtonPay,
          builder: (context, value, child) {
            return Visibility(
              visible: value,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    final state = cartBloc!.state;
                    if (state is CartSuccess) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ShippingScreen(
                            totalPrice: state.cartItems.totalPrice!,
                            shippingCost: state.cartItems.shippingCost!,
                            payablePrice: state.cartItems.payablePrice!,
                          ),
                        ),
                      );
                    }
                  },
                  label: const Text('????????????'),
                ),
              ),
            );
          },
        ),
        body: BlocProvider<CartBloc>(
          create: (context) {
            final bloc = CartBloc(cartRepository);
            cartBloc = bloc;
            stateStreamSubscription = bloc.stream.listen((state) {
              isShowButtonPay.value = state is CartSuccess ? true : false;

              if (_refreshController.isRefresh) {
                if (state is CartSuccess) {
                  _refreshController.refreshCompleted();
                } else if (state is CartError) {
                  _refreshController.refreshFailed();
                }
              }
            });
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
                return SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  header: const ClassicHeader(
                    refreshingText: '???? ?????? ???????? ??????????...',
                    completeText: '???? ???????????? ?????????? ????',
                    canTwoLevelText: '???? ?????? ???????? ??????????...',
                    idleText: '???????? ??????????',
                    releaseText: '???????? ???????? ?????????? ?????? ????????',
                    failedText: '???????? ??????',
                  ),
                  //footer: const ClassicFooter(),
                  onRefresh: () {
                    cartBloc?.add(CartStarted(
                        AuthRepository.authChangeNotifier.value,
                        isRefreshing: true));
                  },
                  child: ListView.builder(
                    itemCount: cartItems.cartItems!.length + 1,
                    padding: const EdgeInsets.only(bottom: 80),
                    itemBuilder: (context, index) {
                      if (index == cartItems.cartItems!.length) {
                        return PriceInfoScreen(
                          payablePrice: state.cartItems.payablePrice!,
                          shippingCost: state.cartItems.shippingCost!,
                          totalPrice: state.cartItems.totalPrice!,
                        );
                      }
                      final data = cartItems.cartItems![index];
                      return CartItem(
                        data: data,
                        onDeleteButtonClick: () {
                          cartBloc
                              ?.add(CartDeleteButtonClicked(data.cartItemId!));
                        },
                        onDecraseButtonClick: () {
                          if (data.count! > 1) {
                            cartBloc?.add(
                                DecreaseCountButtonClicked(data.cartItemId!));
                          }
                        },
                        onIncraseButtonClick: () {
                          cartBloc?.add(
                              IncreaseCountButtonClicked(data.cartItemId!));
                        },
                      );
                    },
                  ),
                );
              } else if (state is CartAuthRequired) {
                return EmptyView(
                  image: SvgPicture.asset(
                    'assets/images/auth_required.svg',
                    width: 140,
                    height: 140,
                  ),
                  message:
                      '?????????? ?????????? ???????? ???????????? ?????? ???????? ???????? ?????????? ???????? ???????? ???????????? ?????? ???????? .',
                  callToAction: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ),
                      );
                    },
                    child: Text(
                      '????????',
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
                  message: '?????? ???????? ?????? ???????? ???? ????????.',
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
        //               ? '?????? ??????????'
        //               : '???????? ???????? ???????? ???????????? ?????? ????????'),
        //           isAuthenticated
        //               ? ElevatedButton(
        //             onPressed: () async {
        //               await authRepository.signOut();
        //             },
        //             child: const Text(
        //               '???????? ???? ????????',
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
        //               '????????',
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
