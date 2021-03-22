class Information {
  String name;
  String title;
  String company;
  String phone;
  String email;
  String website;
  String linkedin;

  Information(
      {this.name,
      this.title,
      this.company,
      this.phone,
      this.email,
      this.website,
      this.linkedin});

  Information.fromJson(Map<String, String> json)
      : name = json['name'],
        title = json['title'],
        company = json['company'],
        phone = json['phone'],
        email = json['email'],
        website = json['website'],
        linkedin = json['linkedin'];

  Map<String, String> toJson() => {
        'name': name,
        'title': title,
        'company': company,
        'phone': phone,
        'email': email,
        'website': website,
        'linkedin': linkedin,
      };
}
