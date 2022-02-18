import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posty/models/post.dart';
import 'package:posty/screens/post_screen.dart';
import 'package:posty/screens/posts_screens.dart';
import 'package:posty/widgets/post_card.dart';

class ManagePostsScreen extends StatefulWidget {
  ManagePostsScreen({Key? key}) : super(key: key);

  @override
  State<ManagePostsScreen> createState() => _ManagePostsScreenState();
}

class _ManagePostsScreenState extends State<ManagePostsScreen> {
  Stream<QuerySnapshot>? _postsStream;

  getPosts() async {
    String? author = FirebaseAuth.instance.currentUser!.displayName;
    _postsStream = FirebaseFirestore.instance
        .collection('posts')
        .where('author', isEqualTo: author)
        .snapshots();
  }

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.push(
              context, CupertinoPageRoute(builder: (_) => PostsScreen())),
          icon: const Icon(Icons.home),
        ),
        title: Text(
          'Manage Posts',
          style: GoogleFonts.berkshireSwash(),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _postsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Post post = Post.fromMap(
                  snapshot.data!.docs[index].data() as Map<String, dynamic>);
              return PostCard(
                post: post,
                isUserPost: true,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => PostScreen(),
            ),
          );
        },
        label: Text(
          'Create Post',
          style: GoogleFonts.berkshireSwash(fontSize: 18),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
