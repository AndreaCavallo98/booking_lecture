class Review {
  late int id;
  late String user_name;
  late String user_surname;
  late String user_image;
  late int rate;
  late String title;
  late String text;
  late String creation_date;

  Review({
    required this.id,
    required this.user_name,
    required this.user_surname,
    required this.user_image,
    required this.rate,
    required this.title,
    required this.text,
    required this.creation_date,
  });

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_name = json['user_name'];
    user_surname = json['user_surname'];
    user_image = json['user_image'];
    rate = json['rate'];
    title = json['title'];
    text = json['text'];
    creation_date = json['creation_date'];
  }
}
