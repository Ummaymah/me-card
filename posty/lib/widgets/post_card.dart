import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:posty/models/post.dart';
import 'package:posty/screens/post_details_screen.dart';
import 'package:posty/screens/post_screen.dart';
import 'package:posty/utilities/constants.dart';

class PostCard extends StatelessWidget {
  Post post;
  bool isUserPost;
  PostCard({
    Key? key,
    required this.post,
    required this.isUserPost,
  }) : super(key: key);

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => PostDetails(post: post),
        ),
      ),
      onLongPress: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => PostScreen(
            post: post,
            isEditing: true,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: kLightBoxDecoration,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.berkshireSwash(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              post.body,
              style: GoogleFonts.montserrat(),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.indigo,
                    boxShadow: kLightBoxDecoration,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.author,
                      style: GoogleFonts.nunito(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(post.timestamp.toDate()),
                      style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Spacer(),
                isUserPost
                    ? IconButton(
                        onPressed: () async {
                          print('POST IS: ${post.id}');
                          CollectionReference posts =
                              FirebaseFirestore.instance.collection('posts');
                          await posts.doc(post.id).delete();
                        },
                        icon: const Icon(
                          Icons.remove_circle_rounded,
                          size: 35,
                          color: Colors.red,
                        ))
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
