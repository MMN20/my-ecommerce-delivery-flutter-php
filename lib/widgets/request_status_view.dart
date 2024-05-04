import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_ecommerce_delivery/core/class/request_status.dart';
import 'package:my_ecommerce_delivery/core/constants/app_lottie_assets.dart';

class RequestStatusView extends StatelessWidget {
  const RequestStatusView(
      {super.key,
      required this.requestStatus,
      required this.child,
      required this.onErrorTap});

  final RequestStatus requestStatus;
  // if the request if success or none
  final Widget child;
  final void Function() onErrorTap;

  @override
  Widget build(BuildContext context) {
    double lottieHeight = Get.height * 0.25;
    BorderRadius borderRadius = BorderRadius.circular(15);
    switch (requestStatus) {
      case RequestStatus.loading:
        return Center(
          child: Lottie.asset(AppLottieAssets.loading, height: lottieHeight),
        );
      case RequestStatus.empty:
        return Center(
            child: Lottie.asset(AppLottieAssets.empty,
                height: lottieHeight, repeat: false));
      case RequestStatus.internetConnectionError:
        return Center(
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onErrorTap,
            child: Lottie.asset(AppLottieAssets.offline, height: lottieHeight),
          ),
        );
      case RequestStatus.serverError:
        return Center(
          child: InkWell(
              borderRadius: borderRadius,
              onTap: onErrorTap,
              child: Lottie.asset(AppLottieAssets.serverError,
                  height: lottieHeight)),
        );
      case RequestStatus.serverException:
        return Center(
          child: InkWell(
              borderRadius: borderRadius,
              onTap: onErrorTap,
              child: Lottie.asset(AppLottieAssets.serverError, height: 200)),
        );

      default:
        return child;
    }
  }
}
