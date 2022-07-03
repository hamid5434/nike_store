import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/bloc/order_history/order_history_bloc.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/repo/order_repository.dart';
import 'package:nike_store/widgets/image_loading_service.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderHistoryBloc(orderRepository)..add(OrderHistoryStarted()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('سوابق تراکنش'),
        ),
        body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistoryLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            } else if (state is OrderHistorySuccess) {
              return ListView.builder(
                itemCount: state.orders.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'شناسه',
                              ),
                              Text(order.id.toString()),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 1,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'مبلغ',
                              ),
                              Text(order.payablePrice!.withPriceLabel),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 1,
                        ),
                        SizedBox(
                          height: 131,
                          child: order.items == null
                              ? Center(
                                  child: Text(
                                    'اطلاعاتی یافت نشد',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: order.items!.length,
                                  itemBuilder: (context, index) {
                                    final item = order.items![index];
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      margin: EdgeInsets.all(4),
                                      child: ImageLoadingService(
                                        url: item.image!,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is OrderHistoryError) {
              return Center(
                child: Text(state.exception.message.toString()),
              );
            } else {
              return const Center(
                child: Text('state not supported'),
              );
            }
          },
        ),
      ),
    );
  }
}
