import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posty/models/post.dart';
import 'package:posty/screens/authentication_screen.dart';
import 'package:posty/screens/manage_posts_screen.dart';
import 'package:posty/utilities/constants.dart';
import 'package:posty/widgets/post_card.dart';

class PostsScreen extends StatefulWidget {
  final bool? isEditing;
  PostsScreen({Key? key, this.isEditing}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final Stream<QuerySnapshot> _postsStream =
      FirebaseFirestore.instance.collection('posts').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(FontAwesomeIcons.blog),
        title: Text(
          'Posty',
          style: GoogleFonts.berkshireSwash(
            fontSize: 28,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                FirebaseAuth auth = FirebaseAuth.instance;
                await auth.signOut();
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (_) => AuthenticationScreen()));
              },
              icon: const Icon(FontAwesomeIcons.signInAlt))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _postsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Post post = Post.fromMap(snapshot.data!.docs[index].data()
                      as Map<String, dynamic>);
                  return PostCard(
                    post: post,
                    isUserPost: false,
                  );
                });
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => ManagePostsScreen(),
            ),
          );
        },
        label: Text(
          'Manage Post',
          style: GoogleFonts.berkshireSwash(fontSize: 18),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
