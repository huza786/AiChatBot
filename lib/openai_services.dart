import 'dart:convert';

import 'package:ai_chat_bot/secrets.dart';
import 'package:http/http.dart' as http;

class OpenAIservices {
  final List<Map<String, String>> messages = [];
  // ignore: non_constant_identifier_names
  Future<String> IsArtprompt(String prompt) async {
    try {
      var res = await http.post(
        Uri.parse(
          'https://api.openai.com/v1/chat/completions',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openApiKey',
        },
        body: (
          jsonEncode(
            {
              'model': 'gpt-3.5-turbo',
              'messages': [
                {
                  'role': 'user',
                  'content':
                      'Is this message wants to generate an AI art, image ,picture or any thing similar? $prompt simply answer with a yes or no ',
                },
              ],
            },
          ),
        ),
      );
      //post request end'
      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        switch (content) {
          case 'YES':
          case 'yes':
          case 'YES.':
          case 'yes.':
            final res = await DALLEprompt(prompt);

          default:
            final res = await ChatGPTprompt(prompt);
        }
      }
      return 'an internal error occured';
    } catch (e) {
      return e.toString();
    }
  }

  // ignore: non_constant_identifier_names
  Future<String> ChatGPTprompt(String prompt) async {
    try {
      messages.add({'role': 'user', 'content': prompt});
      final res = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openApiKey',
          },
          body: jsonEncode({"model": "gpt-3.5-turbo", "messages": messages}));
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        messages.add({'role': 'assistant', 'content': content});
        print(content);
        return content;
      }
      return 'An internal error occured';
    } catch (e) {
      return e.toString();
    }
  }

  // ignore: non_constant_identifier_names
  Future<String> DALLEprompt(String prompt) async {
    try {
      messages.add({
        'role': 'user',
        'content': prompt,
      });
      final res = await http.post(
          Uri.parse('https://api.openai.com/v1/images/generations'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openApiKey'
          },
          body: {
            "prompt": "A cute baby sea otter",
            "n": 1,
            "size": "1024x1024"
          });
      if (res.statusCode == 200) {
        String content = jsonDecode(res.body)['data']['url'];
        messages.add({
          'role': 'user',
          'content': content,
        });
        print(content);

        return content;
      }
      return 'An internal error ocurred';
    } catch (e) {
      return e.toString();
    }
  }
}
