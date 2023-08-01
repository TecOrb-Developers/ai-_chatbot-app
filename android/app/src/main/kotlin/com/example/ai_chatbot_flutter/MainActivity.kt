package com.example.ai_chatbot_flutter
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.stripe.android.ApiResultCallback
import com.stripe.android.PaymentIntentResult
import com.stripe.android.Stripe
import com.stripe.android.model.ConfirmPaymentIntentParams
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.jetbrains.annotations.NotNull
class MainActivity : FlutterActivity() {
    private val CARD_DETAILS_CHANNEL = "example.com/card_details"
    private lateinit var stripe: Stripe
    private lateinit var context: Context
    private  val secretPublicKey = "pk_test_51NNrKrSFPGceK1Mz303vBJkaxMgq3LGX6p2fbRo0PnycSIoiUsSgVwjTCBGJFY4BJrzH6YfKZev0mz3J1U8DgrhB00v55q5jkZ" // Replace with your Stripe Publishable Key
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CARD_DETAILS_CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "saveCardDetails") {
                context = this
                val cardNumber = call.argument<String>("cardNumber")
                val cvv = call.argument<String>("cvv")
                val expiryMonth = call.argument<String>("expiryMonth")
                val cardId = call.argument<String>("cardId")
                val expiryYear = call.argument<String>("expiryYear")
                val saveCardBoolean = call.argument<String>("saveCardBoolean")
                val cardName = call.argument<String>("cardName")
                val client_secret_id = call.argument<String>("client_secret_id")
                paymentIntent(cardId, client_secret_id)
                Log.d("TAG", "configureFlutterEngine: $cardId")
                // result.success("Card details saved successfully.")
                result.success("$cardId$cardName$cardNumber$expiryMonth$expiryYear")
            } else {
                result.notImplemented()
            }
        }
    }
    override fun onStart() {
        super.onStart()
        context = this
       stripe = Stripe(this, secretPublicKey)
    }
    private fun paymentIntent(cardId: String?, client_secret_id: String?) {
        val paymentMethodId = cardId.orEmpty()
        val confirmPaymentParams = client_secret_id?.let { clientSecret ->
            ConfirmPaymentIntentParams.createWithPaymentMethodId(
                paymentMethodId,
                clientSecret
            )
        }
        if (confirmPaymentParams != null) {
            stripe.confirmPayment(this, confirmPaymentParams,
                object : ApiResultCallback<PaymentIntentResult> {
                    override fun onError(@NotNull e: Exception) {
                        // Handle error during payment confirmation
                        e.printStackTrace()
                    }
                    override fun onSuccess(result: PaymentIntentResult) {
                        // Handle payment confirmed successfully
                    }
                })
        }
    }
}

