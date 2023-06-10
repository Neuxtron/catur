import 'dart:convert';

import 'package:catur/models/game.dart';
import 'package:flutter/material.dart';
import 'globals.dart';
import 'package:http/http.dart' as http;

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String _text = "Membuat permainan baru...";

  Future createGame() async {
    String url = "$server/catur/create_game.php";

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 201) {
      Game game = Game.fromJson(jsonDecode(response.body));

      if (game.status) {
        setState(() {
          _text = "Menunggu lawan...\nId Anda: ${game.idGame}";
        });
      } else {
        setState(() {
          _text = "Gagal membuat permainan";
        });
      }
    } else {
      setState(() {
        _text = "Gagal membuat permainan";
      });
    }
  }

  @override
  void initState() {
    createGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
