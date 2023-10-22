import 'package:ai_chat_bot/feature_box.dart';
import 'package:ai_chat_bot/pallete.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:ai_chat_bot/openai_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SpeechToText speechToText = SpeechToText();
  String lastWords = '';
  OpenAIservices openAIservices = OpenAIservices();
  @override
  void initState() {
    super.initState();
    initSpeechtoText();
  }

  Future initSpeechtoText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);

    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ai Chat Bot',
          style: TextStyle(color: Colors.black, fontFamily: 'Cera Pro'),
        ),
        backgroundColor: Pallete.whiteColor,
        elevation: 0,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: Stack(
                // alignment: AlignmentDirectional(0, 2),
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      decoration: const BoxDecoration(
                          color: Pallete.assistantCircleColor,
                          shape: BoxShape.circle),
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      height: 125,
                      child: const Center(
                        child: Image(
                            image: AssetImage(
                                'assets/images/virtualAssistant.png')),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //   CHAT BUBBLE
            Container(
              margin: const EdgeInsets.only(
                  top: 40, bottom: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Pallete.borderColor),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Padding(
                padding:
                    EdgeInsets.only(top: 20, bottom: 10, left: 8, right: 8),
                // padding: const EdgeInsets.symmetric(horizontal: 40)
                //     .copyWith(bottom: 10),
                child: Text(
                  'Good Morning What can I do for you?',
                  style: TextStyle(fontFamily: 'Cera Pro', fontSize: 25),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Here are a few commands',
                  style: TextStyle(
                      fontFamily: 'Cera Pro',
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            const Column(
              children: [
                Feature_box(
                    Title: 'Chat GPT',
                    color: Pallete.firstSuggestionBoxColor,
                    description:
                        'A smarter way to stay organized and informed with Chat GPT'),
                Feature_box(
                    Title: 'DALL-E',
                    color: Pallete.secondSuggestionBoxColor,
                    description:
                        'Get inspired and stay creative with your personal assistant powered by DALL-E'),
                Feature_box(
                    Title: 'Smart Voice Assistant',
                    color: Pallete.thirdSuggestionBoxColor,
                    description:
                        'Get the best of both worlds by your personal voice assistant powered by \nChat GPT and DALL-E'),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.firstSuggestionBoxColor,
        hoverColor: Pallete.whiteColor,
        splashColor: Pallete.mainFontColor,
        focusColor: const Color.fromARGB(255, 209, 168, 22),
        focusElevation: 40,
        child: const Icon(
          Icons.mic_none_outlined,
          color: Pallete.blackColor,
        ),
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            await stopListening();
            final speech = openAIservices.IsArtprompt(lastWords);
            print(speech);
          } else {
            await initSpeechtoText();
          }
        },
      ),
    );
  }
}


 // //     CHAT GPT BUBBLE
          // Column(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(
          //           top: 8, bottom: 8, left: 16, right: 16),
          //       child: Container(
          //         width: double.infinity,
          //         height: MediaQuery.of(context).size.height / 8.5,
          //         decoration: BoxDecoration(
          //           color: Pallete.firstSuggestionBoxColor,
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //         child: const Padding(
          //           padding: EdgeInsets.only(left: 8.0),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'Chat GPT',
          //                 style: TextStyle(
          //                     fontFamily: 'Cera Pro',
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.only(top: 8.0),
          //                 child: Text(
          //                   'A smarter way to stay organized and informed with Chat GPT',
          //                   style: TextStyle(
          //                     fontFamily: 'Cera Pro',
          //                     fontSize: 14,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     //  DALL-E IMAGE BUBBLE
          //     Padding(
          //       padding: const EdgeInsets.only(
          //           top: 8, bottom: 8, left: 16, right: 16),
          //       child: Container(
          //         width: double.infinity,
          //         height: MediaQuery.of(context).size.height / 8.5,
          //         decoration: BoxDecoration(
          //           color: Pallete.secondSuggestionBoxColor,
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //         child: const Padding(
          //           padding: EdgeInsets.only(left: 8.0),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'DALL-E',
          //                 style: TextStyle(
          //                     fontFamily: 'Cera Pro',
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.only(top: 8.0),
          //                 child: Text(
          //                   'Get inspired and stay creative with your personal assistant powered by DALL-E',
          //                   style: TextStyle(
          //                     fontFamily: 'Cera Pro',
          //                     fontSize: 14,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(
          //           top: 8, bottom: 8, left: 16, right: 16),
          //       child: Container(
          //         width: double.infinity,
          //         height: MediaQuery.of(context).size.height / 8.5,
          //         decoration: BoxDecoration(
          //           color: Pallete.thirdSuggestionBoxColor,
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //         child: const Padding(
          //           padding: EdgeInsets.only(left: 8.0),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'Smart Voice Assistant',
          //                 style: TextStyle(
          //                     fontFamily: 'Cera Pro',
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.only(top: 8.0),
          //                 child: Text(
          //                   'Get the best of both worlds by your personal voice assistant powert by Chat GPt and DALL-E',
          //                   style: TextStyle(
          //                     fontFamily: 'Cera Pro',
          //                     fontSize: 14,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // )