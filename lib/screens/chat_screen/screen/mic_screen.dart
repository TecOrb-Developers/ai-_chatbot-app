import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechSampleApp extends StatefulWidget {
  const SpeechSampleApp({super.key});
  @override
  State<SpeechSampleApp> createState() => _SpeechSampleAppState();
}

TextEditingController textEditingController = TextEditingController();

class _SpeechSampleAppState extends State<SpeechSampleApp> {
  var text = 'speech to text';
  final SpeechToText speechToText = SpeechToText();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                hintText: "let's start",
              ),
            ),
            Text(text),
            GestureDetector(
                onTapDown: (details) async {
                  print('initialize');
                  var available = await speechToText.initialize();
                  if (available) {
                    setState(() {
                      speechToText.listen(
                        onResult: (result) {
                          setState(() {
                            textEditingController.text = result.recognizedWords;
                            text = result.recognizedWords;
                            print(text);
                          });
                        },
                      );
                    });
                  }
                },
                onTapUp: (details) {
                  print('stop');
                  speechToText.stop();
                },
                child: CircleAvatar(
                    radius: 40, backgroundColor: Colors.amber, child: micIcon))
          ],
        ),
      ),
    );
  }
}
