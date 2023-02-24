class Post {
  int? idPost;
  String? dscPost;
  String? datePost;

  Post({this.idPost, this.dscPost, this.datePost});
  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
        idPost: map['idPost'],
        dscPost: map['dscPost'],
        datePost: map['datePost']);
  }
}
