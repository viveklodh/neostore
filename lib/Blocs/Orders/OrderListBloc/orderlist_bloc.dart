import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostoreapplication/Model/OrdersModel/orders_model.dart';
import 'package:neostoreapplication/NetworkApi/OrdersService/orders_service.dart';
import 'package:neostoreapplication/Session/user_session.dart';

import 'orderlist_events.dart';
import 'orderlist_state.dart';

class OrderListBloc extends Bloc<OrderListEvents, OrderListState> {
  OrderListBloc() : super(InitialOrderListState());

  @override
  Stream<OrderListState> mapEventToState(OrderListEvents event) async* {
    if (event is FetchOrderList) {
      yield OrderListLoadingState();
      var accessToken = await UserSession().getSessionDetails();
      if (accessToken != null) {
        print("Acess Token: $accessToken");
        Response response = await OrdersService().getOrdersList(accessToken);
        print("List Of Orders: ");
        if (response.statusCode == 200) {
          var ordersList = json.decode(response.data);
          print("List Of Orders: $ordersList");
          OrdersList _orderList = OrdersList.fromJson(ordersList);
          if (_orderList.data.length != 0) {
            print(_orderList.toJson());
            yield LoadOrderList(orderList: _orderList);
          } else {
            yield OrderListEmpty();
          }
        } else {
          var errorResponse = json.decode(response.data);
          print(errorResponse);
          yield OrderListFailed();
        }
      }
    }
    if (event is OrderPlaceEvent) {
      var accessToken = await UserSession().getSessionDetails();
      Response response =
          await OrdersService().placeOrders(event.address, accessToken);
      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        yield OrderPlacedSuccessfullyState(successMsg: data["user_msg"]);
      } else {
        var data = json.decode(response.data);
        yield OrderPlacedFailedState(errorMsg: data["user_msg"]);
      }
    }
  }
}
