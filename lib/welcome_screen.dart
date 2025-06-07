import 'package:flutter/material.dart';
import 'chat_gemini_screen.dart'; // Importe a tela do chat

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late ColorTween _colorTween;
  Color _backgroundColor = Colors.white; // Cor inicial de fundo

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Defina as cores de transição (substitua pelas cores do GDGSSA para a inicial)
    _colorTween = ColorTween(begin: Colors.blue[200], end: Colors.grey[100]);
    _backgroundColor = _colorTween.evaluate(_animationController)!;

    _animationController.addListener(() {
      setState(() {
        _backgroundColor = _colorTween.evaluate(_animationController)!;
      });
    });

    _animationController.forward(); // Inicia a animação
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToChat() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ChatScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Bem-vindo",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Image.asset('assets/images/gdg_lauro.png', width: 600, height: 150),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _navigateToChat,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Text(
                    "Conversar com Gemini",
                    style: TextStyle(fontSize: 18),
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