import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Defina suas chaves de API em variáveis (mantenha-as seguras, considere usar variáveis de ambiente)
const String geminiApiKey = 'AIzaSyDlDOlJOPvDSgQQic6Ba4DZkp5-cg5YwBY';
const String geminiApiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  Future<void> _handleSubmitted(String text) async {
    _textController.clear();
    ChatMessage userMessage = ChatMessage(
      text: text,
      isUser: true,
    );
    setState(() {
      _messages.insert(0, userMessage);
    });

    try {
      final response = await http.post(
        Uri.parse('$geminiApiUrl?key=$geminiApiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': text}]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('candidates') && responseData['candidates'].isNotEmpty) {
          final String replyText = responseData['candidates'][0]['content']['parts'][0]['text'];
          ChatMessage botMessage = ChatMessage(
            text: replyText,
            isUser: false,
          );
          setState(() {
            _messages.insert(0, botMessage);
          });
        } else {
          _handleError('Resposta da API vazia ou mal formatada.');
        }
      } else {
        _handleError('Erro na requisição para a API Gemini: ${response.statusCode}');
      }
    } catch (error) {
      _handleError('Ocorreu um erro ao se comunicar com a API Gemini: $error');
    } finally {
      setState(() {
      });
    }
  }

  void _handleError(String errorMessage) {
    ChatMessage errorChatMessage = ChatMessage(
      text: 'Erro: $errorMessage',
      isUser: false,
      isError: true,
    );
    setState(() {
      _messages.insert(0, errorChatMessage);
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(
                hintText: "Digite sua pergunta...",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
                    icon: Icon(Icons.send_outlined, color: Theme.of(context).colorScheme.primary),
                    onPressed: () => _handleSubmitted(_textController.text),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        
        width: 600.0,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Chat com Gemini"),
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 1,
          ),
          body: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length,
                ),
              ),
              Divider(height: 1.0, color: Colors.grey[300]),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                child: _buildTextComposer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.text, required this.isUser, this.isError = false});
  final String text;
  final bool isUser;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isUser
                ? Theme.of(context).colorScheme.primaryContainer
                : isError
                    ? Colors.red[200] // Cor de fundo para mensagens de erro
                    : Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                isUser ? 'Você' : isError ? 'Erro' : 'Gemini',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isUser
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Colors.black87,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: isUser
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}