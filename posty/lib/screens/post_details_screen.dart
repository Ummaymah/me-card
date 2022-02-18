import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posty/models/post.dart';

class PostDetails extends StatelessWidget {
  final Post? post;
  const PostDetails({Key? key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post Details',
          style: GoogleFonts.berkshireSwash(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Text(
                'Qui molestiae modi voluptatem quae in velit voluptate. Praesentium necessitatibus totam assumenda hic eum pariatur. Unde perferendis suscipit debitis eaque vel velit rerum aut incidunt. Est est fugiat quae non iste nisi totam quibusdam ipsam. Qui ratione iusto magnam animi fuga quisquam consequuntur illo. Similique praesentium et maxime odio mollitia esse officia dolorum autem.',
                style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(),
                title: Text('Kim Taehyung'),
                subtitle: Text('31st December 2022'),
              ),
              Text(
                'Est saepe aut odit at itaque voluptatem alias ea mollitia. Est cupiditate ut rerum provident rerum nisi ut eius velit. Labore aut doloribus necessitatibus et suscipit aspernatur voluptatem nesciunt. Ut exercitationem laborum hic vero cum. Vel odit vero quis minima quia.oluptatibus eveniet doloremque quasi sed laboriosam aliquam hic. Quaerat iusto non molestias incidunt possimus soluta. Incidunt nihil et voluptas est in. Sit quos tempore dolores sunt quibusdam assumenda ullam minima. Dolorem cum et quibusdam dolores recusandae ipsum. Molestias magnam est similique unde suscipit qui.Aperiam libero quis rem voluptatem voluptates. Modi eligendi praesentium. Quis minus rerum occaecati animi et earum.',
                style: GoogleFonts.montserrat(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
