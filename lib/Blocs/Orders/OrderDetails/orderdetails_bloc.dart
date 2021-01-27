import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostoreapplication/Model/OrdersModel/orderdetails_model.dart';
import 'package:neostoreapplication/NetworkApi/OrdersService/orders_service.dart';
import 'package:neostoreapplication/Session/user_session.dart';

import 'orderdetails_events.dart';
import 'ordersdetails_states.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  OrderDetailsBloc() : super(OrderDetailsInitialState());

  @override
  Stream<OrderDetailsState> mapEventToState(OrderDetailsEvent event) async* {
    if (event is OrderDetailsFetch) {
      yield OrderDetailsLoadingState();
      var accesToken = await UserSession().getSessionDetails();
      print("Order Details of ${event.orderId} : Access Token : $accesToken");
      Response response =
          await OrdersService().getOrdersDetails(accesToken, event.orderId);
      if (response.statusCode == 200) {
        var orderDetails =
            OrderDetailModel.fromJson(json.decode(response.data));
        yield OrderDetailsLoadState(orderDetailModel: orderDetails);
      } else {
        var errorResponse = json.decode(response.data);
        yield OrderDetailsLoadFailedState(errorMsg: errorResponse["user_msg"]);
      }
    }
  }
}
