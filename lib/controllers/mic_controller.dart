import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MicController extends GetxController {
  SpeechToText speechToText = SpeechToText();
  var text = '';

  void startListening() async {
    print("start listening");
    var available = await speechToText.initialize();
    if (available) {
      speechToText.listen(
        onResult: (result) {
          text = result.recognizedWords;
          update();
          print(text);
        },
      );
    }
  }

  void stopListening() async {
    print('stop listening');
    await speechToText.stop();
    update();
  }
}
