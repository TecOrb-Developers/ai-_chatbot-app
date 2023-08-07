package com.example.ai_chatbot_flutter;

import com.stripe.android.Stripe;
import com.stripe.android.model.ConfirmPaymentIntentParams;
import com.stripe.android.model.PaymentIntent;

public class PaymentProcessor {
    // Replace 'YourStripeSecretKey' with your actual Stripe Secret Key
    private static final String STRIPE_SECRET_KEY = "YourStripeSecretKey";
  //  private final Stripe stripe;

   /* public PaymentProcessor(MainActivity activity) {
        stripe = new Stripe(activity, STRIPE_SECRET_KEY);
    }*/

    public static boolean confirmPayment(Stripe stripe, String paymentMethodId, String paymentIntentId, MainActivity activity) {
        ConfirmPaymentIntentParams confirmParams = ConfirmPaymentIntentParams
                .createWithPaymentMethodId(paymentMethodId, paymentIntentId);
        try {
           // PaymentIntent paymentIntent = stripe.confirmPayment(confirmParams, activity);
            //return "succeeded".equals(paymentIntent.getStatus());
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


}




