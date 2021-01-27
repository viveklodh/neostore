import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neostoreapplication/Pages/Address%20Screen/add_address.dart';
import 'package:neostoreapplication/Pages/Address%20Screen/address_list.dart';
import 'package:neostoreapplication/Pages/AuthScreens/forgot_password_screen.dart';
import 'package:neostoreapplication/Pages/AuthScreens/login_screen.dart';
import 'package:neostoreapplication/Pages/AuthScreens/signup_screen.dart';
import 'package:neostoreapplication/Pages/OrdersScreens/myorders_screen.dart';
import 'package:neostoreapplication/Pages/OrdersScreens/orderdetails_screen.dart';
import 'package:neostoreapplication/Pages/Product%20Screen/product_details_screen.dart';
import 'package:neostoreapplication/Pages/Product%20Screen/product_listing_screen.dart';
import 'package:neostoreapplication/Pages/cart_screen.dart';
import 'package:neostoreapplication/Pages/edit_profile.dart';
import 'package:neostoreapplication/Pages/gateway_screen.dart';
import 'package:neostoreapplication/Pages/home_screen.dart';
import 'package:neostoreapplication/Pages/my_account_screen.dart';
import 'package:neostoreapplication/Pages/reset_password.dart';
import 'package:neostoreapplication/Pages/store_locator.dart';

class RouterPage {
  static Route<dynamic> ongenerateRoute(RouteSettings settings) {
    var data = settings.arguments;
    switch (settings.name) {
      case RoutingConstants.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RoutingConstants.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case RoutingConstants.signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case RoutingConstants.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen(accessToken: data));
      case RoutingConstants.gatewayScreen:
        return MaterialPageRoute(builder: (_) => GatewayScreen());
      case RoutingConstants.myAccountScreen:
        return MaterialPageRoute(builder: (_) => MyAccount(user: data));
      case RoutingConstants.editProfileScreen:
        return MaterialPageRoute(
            builder: (_) => EditProfileScreen(
                  userData: data,
                ));
      case RoutingConstants.resetPasswordScreen:
        return MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(token: data));
      case RoutingConstants.storeLocatorScreen:
        return MaterialPageRoute(builder: (_) => StoreLocator());
      case RoutingConstants.productListingScreen:
        return MaterialPageRoute(
            builder: (_) => ProductListingScreen(
                  product: data,
                ));
      case RoutingConstants.productDetailScreen:
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(
                  data: data,
                ));
      case RoutingConstants.ordersScreen:
        return MaterialPageRoute(builder: (_) => MyOrdersScreen());
      case RoutingConstants.cartScreen:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case RoutingConstants.addressListScreen:
        return MaterialPageRoute(builder: (_) => AddressList());
      case RoutingConstants.addAddressScreen:
        return MaterialPageRoute(builder: (_) => AddAddressScreen());
      case RoutingConstants.orderDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => OrderDetailsScreen(order_id: data));
    }
  }
}

class RoutingConstants {
  static const String loginScreen = "/loginScreen";
  static const String forgotPasswordScreen = "/forgotpasswordScreen";
  static const String signUpScreen = "/signUpScreen";
  static const String homeScreen = "/homeScreen";
  static const String gatewayScreen = "/gatewayScreen";
  static const String myAccountScreen = "/myaccountScreen";
  static const String editProfileScreen = "/editprofileScreen";
  static const String resetPasswordScreen = "/resetpasswordScreen";
  static const String storeLocatorScreen = "/storelocatorScreen";
  static const String productListingScreen = "/productlistingScreen";
  static const String productDetailScreen = "/productdetailsScreen";
  static const String ordersScreen = "/ordersScreen";
  static const String cartScreen = "/cartScreen";
  static const String addressListScreen = "/addresslistScreen";
  static const String addAddressScreen = "/addAddressScreen";
  static const String orderDetailsScreen = "/orderdetailsScreen";
}
