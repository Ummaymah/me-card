import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? id;
  String title;
  String body;
  String author;
  Timestamp timestamp;
  Post({
    this.id,
    required this.title,
    required this.body,
    required this.author,
    required this.timestamp,
  });

  Post copyWith({
    String? id,
    String? title,
    String? body,
    String? author,
    Timestamp? timestamp,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      author: author ?? this.author,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'author': author,
      'timestamp': timestamp,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      author: map['author'] ?? '',
      timestamp: map['timestamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(id: $id, title: $title, body: $body, author: $author, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        other.author == author &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        body.hashCode ^
        author.hashCode ^
        timestamp.hashCode;
  }
}
