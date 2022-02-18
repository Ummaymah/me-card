import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const BTS());
}

class BTS extends StatelessWidget {
  const BTS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Bangtan(),
    );
  }
}

class Bangtan extends StatefulWidget {
  const Bangtan({Key? key}) : super(key: key);

  @override
  State<Bangtan> createState() => _BangtanState();
}

class _BangtanState extends State<Bangtan> {
  bool isPlaying = false;
  final player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/photo3.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Positioned(
            top: 50,
            bottom: 50,
            left: 50,
            right: 50,
            child: Column(
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/photo2.jpg'),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'BTS',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway'),
                ),
                const SizedBox(height: 15),
                const Text(
                  'ARMY COLLECTION',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.white70,
                    child: ListTile(
                      title: const Text('Life Goes On'),
                      textColor: Colors.black,
                      trailing: GestureDetector(
                        child: IconButton(
                          onPressed: () {},
                          iconSize: 30,
                          icon: Icon(isPlaying
                              ? Icons.pause_circle_filled_rounded
                              : Icons.play_circle_outline_sharp),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.white70,
                    child: ListTile(
                      title: const Text('Pied Piper'),
                      textColor: Colors.black,
                      trailing: GestureDetector(
                        child: IconButton(
                          onPressed: () {},
                          iconSize: 30,
                          icon: const Icon(Icons.play_circle_outline_sharp),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.white70,
                    child: ListTile(
                      title: const Text('Make It Right'),
                      textColor: Colors.black,
                      trailing: GestureDetector(
                        child: IconButton(
                          onPressed: () {},
                          iconSize: 30,
                          icon: const Icon(Icons.play_circle_outline_sharp),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.white70,
                    child: ListTile(
                      title: const Text('Dynamite'),
                      textColor: Colors.black,
                      trailing: GestureDetector(
                        child: IconButton(
                          onPressed: () {},
                          iconSize: 30,
                          icon: const Icon(Icons.play_circle_outline_sharp),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.white70,
                    child: ListTile(
                      title: const Text('Euphoria'),
                      textColor: Colors.black,
                      trailing: GestureDetector(
                        child: IconButton(
                          onPressed: () {},
                          iconSize: 30,
                          icon: const Icon(Icons.play_circle_outline_sharp),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
