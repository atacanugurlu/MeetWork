class BusinessCardInfo {
  String name;
  String title;
  String company;
  String phone;
  String email;
  String website;
  String linkedin;

  BusinessCardInfo(
      {this.name,
      this.title,
      this.company,
      this.phone,
      this.email,
      this.website,
      this.linkedin});

  BusinessCardInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        title = json['title'],
        company = json['company'],
        phone = json['phone'],
        email = json['email'],
        website = json['website'],
        linkedin = json['linkedin'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'title': title,
        'company': company,
        'phone': phone,
        'email': email,
        'website': website,
        'linkedin': linkedin,
      };
}
