import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Catur Zuzuzu",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 180, 0, 20),
            child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
                backgroundColor: const MaterialStatePropertyAll(Colors.black),
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
              ),
              child: const Text(
                "Permainan Baru",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 130),
            child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
                backgroundColor: const MaterialStatePropertyAll(Colors.black),
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
              ),
              child: const Text(
                "Gabung Permainan",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
