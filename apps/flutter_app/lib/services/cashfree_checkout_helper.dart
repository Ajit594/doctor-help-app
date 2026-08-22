import 'dart:async';

import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';

/// Result of a single Cashfree checkout attempt.
///
/// [success] only means the native checkout flow completed without the user
/// cancelling or the gateway rejecting it outright — it is NOT proof of a
/// server-confirmed payment. Callers must still confirm the final status against
/// the backend (see `PaymentService.getPaymentStatus(..., live: true)`) before
/// treating the booking as paid.
class CashfreeCheckoutResult {
  final bool success;
  final String orderId;
  final String? errorMessage;

  CashfreeCheckoutResult.success(this.orderId)
      : success = true,
        errorMessage = null;

  CashfreeCheckoutResult.failure(this.orderId, this.errorMessage)
      : success = false;
}

/// Wraps [CFPaymentGatewayService]'s imperative callback API as a single
/// awaitable call, so payment screens can just `await` a checkout attempt.
class CashfreeCheckoutHelper {
  Future<CashfreeCheckoutResult> launchCheckout({
    required String orderId,
    required String paymentSessionId,
    required String environment, // 'sandbox' | 'production', as returned by the backend
  }) {
    final completer = Completer<CashfreeCheckoutResult>();

    void onVerify(String verifiedOrderId) {
      if (!completer.isCompleted) {
        completer.complete(CashfreeCheckoutResult.success(verifiedOrderId));
      }
    }

    void onError(CFErrorResponse error, String failedOrderId) {
      if (!completer.isCompleted) {
        completer.complete(
          CashfreeCheckoutResult.failure(failedOrderId, error.getMessage()),
        );
      }
    }

    try {
      final cfEnvironment = environment.toLowerCase() == 'production'
          ? CFEnvironment.PRODUCTION
          : CFEnvironment.SANDBOX;

      final session = CFSessionBuilder()
          .setEnvironment(cfEnvironment)
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();

      final payment = CFWebCheckoutPaymentBuilder().setSession(session).build();

      final service = CFPaymentGatewayService();
      service.setCallback(onVerify, onError);
      service.doPayment(payment);
    } on CFException catch (e) {
      completer.complete(CashfreeCheckoutResult.failure(orderId, e.message));
    } catch (e) {
      completer.complete(CashfreeCheckoutResult.failure(orderId, e.toString()));
    }

    return completer.future;
  }
}
