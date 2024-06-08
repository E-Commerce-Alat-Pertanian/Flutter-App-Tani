import 'package:app_tani_sejahtera/pages/orders/components/order_card.dart';
import 'package:app_tani_sejahtera/view_models/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderViewModel()..getOrder(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Order'),
        ),
        body: SafeArea(
          child: Consumer<OrderViewModel>(
            builder: (context, orderViewModel, child) {
              if (orderViewModel.status == ServerStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (orderViewModel.listOrder.isEmpty) {
                return Center(
                  child: Text(
                    "No orders found",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orderViewModel.listOrder.length,
                itemBuilder: (context, index) {
                  final order = orderViewModel.listOrder[index];
                  return OrderCard(
                    keranjang: order.keranjang,
                    order: order,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
