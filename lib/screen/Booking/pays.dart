import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';
import 'package:provider/provider.dart';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/apiServices/servicesService.dart';
import 'package:Rafeed/models/orderModel.dart';
import 'package:Rafeed/models/serviceModel.dart';
import 'package:Rafeed/screen/bottomBarPages/bottomBar.dart';

class CardPaymentMethods extends StatelessWidget {
  final ServiceModel service;
  Order? order;
  int? price = null;
  CardPaymentMethods({
    Key? key,
    required this.service,
    this.order,
    this.price,
  }) : super(key: key);

  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      log(PaymentStatus.values.toString() +
          ": " +
          PaymentStatus.values.indexOf(result.status).toString());
      switch (result.status) {
        case PaymentStatus.paid:
          log(result.id);
          log("success");
          break;
        case PaymentStatus.failed:
          log("failed");
          // handle failure.
          break;

        default:
          log(PaymentStatus.values.toString() +
              ": " +
              PaymentStatus.values.indexOf(result.status).toString());
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //       ApplePay(
        //         config: PaymentConfig(
        //   publishableApiKey: 'pk_test_HjU8Zc9C2QUC837xmLxtcAm475gTjw6hWpJyLvNB',
        //   amount: 150,
        //   description: '${service.id}',
        //   // currency: "USD",
        //   metadata: {'size': '250g'},
        //   creditCard: CreditCardConfig(saveCard: true, manual: false),
        //   applePay: ApplePayConfig(
        //       merchantId: 'YOUR_MERCHANT_ID',
        //       label: 'YOUR_STORE_NAME',
        //       manual: false),
        // ),
        //         onPaymentResult: onPaymentResult,
        //       ),
        //       const Text("or"),
        CreditCard(
          config: PaymentConfig(
            publishableApiKey:
                '',
            amount: price != null
                ? (price! * 100).toInt()
                : (service.price * 100).toInt(),
            description: '${service.id}',
            // currency: "USD",
            metadata: {'size': '250g'},
            creditCard: CreditCardConfig(saveCard: true, manual: false),
            applePay: ApplePayConfig(
                merchantId: 'YOUR_MERCHANT_ID',
                label: 'YOUR_STORE_NAME',
                manual: false),
          ),
          onPaymentResult: (result) async {
            if (result is PaymentResponse) {
              log(PaymentStatus.values.toString() +
                  ": " +
                  PaymentStatus.values.indexOf(result.status).toString());
              switch (result.status) {
                case PaymentStatus.paid:
                  log(result.id);
                  log("success");
                  if (price == null) {
                    Provider.of<LoginSignup>(context, listen: false)
                        .bookingInfo["paymentId"] = result.id;

                    await Provider.of<LoginSignup>(context, listen: false)
                        .bookService(
                            service.id!,
                            Provider.of<LoginSignup>(context, listen: false)
                                .bookingInfo);
                  } else {
                    Map<String, dynamic> map = {
                      "value": price,
                      "id": result.id
                    };
                    Provider.of<ServicesService>(context, listen: false)
                        .sendTip(map, order!.id ?? "");
                  }
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => BottomBar()));
                  break;
                case PaymentStatus.failed:
                  log("failed");
                  // handle failure.
                  break;

                default:
                  log(PaymentStatus.values.toString() +
                      ": " +
                      PaymentStatus.values.indexOf(result.status).toString());
                  break;
              }
            }
          },
        )
      ],
    );
  }
}
