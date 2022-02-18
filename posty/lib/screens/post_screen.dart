import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posty/models/post.dart';

class PostScreen extends StatefulWidget {
  Post? post;
  bool? isEditing;
  PostScreen({Key? key, this.post, this.isEditing}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime today = DateTime.now();
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  bool _isLoading = false;
  createPost() async {
    setState(() => _isLoading = true);
    await posts.add({
      'title': _titleController.text,
      'body': _bodyController.text,
      'author': FirebaseAuth.instance.currentUser!.displayName,
      'timestamp': Timestamp.now(),
    }).then((post) => post.update({'id': post.id}));
    Navigator.pop(context);
  }

  updatePost() async {
    setState(() => _isLoading = true);
    posts.doc(widget.post!.id).update({
      'title': _titleController.text.isNotEmpty
          ? _titleController.text
          : widget.post!.title,
      'body': _bodyController.text.isNotEmpty
          ? _bodyController.text
          : widget.post!.body,
    }).then((_) {});
    Navigator.pop(context);
  }

  editingMode() {
    widget.isEditing == true ? _titleController.text = widget.post!.title : '';
    widget.isEditing == true ? _bodyController.text = widget.post!.body : '';
  }

  @override
  void initState() {
    editingMode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditing == true ? 'Edit Post' : 'Create Post',
          style: GoogleFonts.berkshireSwash(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  maxLines: 2,
                  controller: _titleController,
                  decoration: InputDecoration(
                    label: const Text('Title'),
                    hintText: 'Type your title here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  maxLines: 20,
                  controller: _bodyController,
                  decoration: InputDecoration(
                    label: const Text('Body'),
                    hintText: 'Type your body here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      final user = snapshot.data;
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage('${user?.photoURL}'),
                        ),
                        title: Text('${user?.displayName}'),
                        subtitle:
                            Text('${today.day} ${today.month} ${today.year}'),
                      );
                    }),
                const SizedBox(
                  height: 15,
                ),
                _isLoading
                    ? const LinearProgressIndicator(minHeight: 50)
                    : GestureDetector(
                        onTap:
                            widget.isEditing == true ? updatePost : createPost,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              widget.isEditing == true
                                  ? 'Update Post'
                                  : 'Make Post',
                              style: GoogleFonts.berkshireSwash(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
