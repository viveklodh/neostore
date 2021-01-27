import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostoreapplication/Model/Product%20Data/product_detail_model.dart';
import 'package:neostoreapplication/NetworkApi/ProductService/product_service.dart';

import 'details_events.dart';
import 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial());

  @override
  Stream<DetailsState> mapEventToState(DetailsEvent event) async* {
    if (event is LoadProductDetails) {
      yield DetailsLoading();
      print("product id is: ${event.id}");
      Response response = await ProductService().getProductsDetails(event.id);
      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        print(data);
        yield DetailsSuccessLoad(
            productDetailModel: ProductDetailModel.fromJson(data));
      } else {
        var data = json.decode(response.data);
        yield DetailsFailLoad(errorMsg: data["message"]);
      }
    }
    if (event is SetRatingEvent) {
      print("Rating to SET: ${event.rating}");
      Response response =
          await ProductService().setRating(event.rating, event.product_id);
      if (response.statusCode == 200) {
        print(response.data);
      } else {
        print(response.data);
      }
    }
  }
}
