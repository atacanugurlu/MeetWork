class BusinessCardInfo {
  int cardID;
  String name;
  String title;
  String company;
  String phone;
  String email;
  String website;
  String linkedin;

  BusinessCardInfo(this.cardID, this.name, this.title, this.company, this.phone,
      this.email, this.website, this.linkedin);

  BusinessCardInfo.fromMap(Map<String, dynamic> map)
      : cardID = map["cardID"],
        name = map["name"],
        title = map["title"],
        company = map["company"],
        phone = map["phone"],
        email = map["email"],
        website = map["website"],
        linkedin = map["linkedin"];

  Map<String, dynamic> toMap() => {
        "cardID": cardID,
        "name": name,
        "title": title,
        "company": company,
        "phone": phone,
        "email": email,
        "website": website,
        "linkedin": linkedin,
      };
}
