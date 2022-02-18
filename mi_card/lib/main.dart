import 'package:flutter/material.dart';

void main() {
  runApp(const MeCard());
}

class MeCard extends StatelessWidget {
  const MeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: const Jojo(),
    );
  }
}

class Jojo extends StatefulWidget {
  const Jojo({Key? key}) : super(key: key);

  @override
  State<Jojo> createState() => _JojoState();
}

class _JojoState extends State<Jojo> {
  double level = 50;
  double level1 = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       level++;
      //     });
      //   },
      //   child: const Icon(Icons.add),
      // ),
      backgroundColor: Colors.red.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/ummaymah.JPG'),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Ummaymah Noor',
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lobster'),
          ),
          const SizedBox(height: 15),
          const Divider(thickness: 2.0, height: 5.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.email),
                const Text(
                  'ummaymah@icloud.com',
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.phone),
                const Text(
                  '0802228769876',
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(
              value: level1 / 100,
              color: Colors.brown,
            ),
          ),
          if (level >= 100) Text('Congratulations')
        ],
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              setState(() {
                level++;
              });
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              setState(() {
                level1--;
              });
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
