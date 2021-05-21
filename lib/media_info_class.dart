class SocialMediaInfo {
  String facebookAccount;
  String instagramAccount;
  String tumblrAccount;
  String twitterAccount;
  String tiktokAccount;
  String youtubeAccount;
  String redditAccount;
  String linkedinAccount;
  String twitchAccount;

  SocialMediaInfo(
      this.facebookAccount,
      this.instagramAccount,
      this.tumblrAccount,
      this.twitterAccount,
      this.tiktokAccount,
      this.youtubeAccount,
      this.redditAccount,
      this.linkedinAccount,
      this.twitchAccount);

  SocialMediaInfo.fromMap(Map<String, dynamic> map)
      : facebookAccount = map["facebookAccount"],
        instagramAccount = map["instagramAccount"],
        tumblrAccount = map["tumblrAccount"],
        twitterAccount = map["twitterAccount"],
        tiktokAccount = map["tiktokAccount"],
        youtubeAccount = map["youtubeAccount"],
        redditAccount = map["redditAccount"],
        linkedinAccount = map["linkedinAccount"],
        twitchAccount = map["twitchAccount"];

  Map<String, dynamic> toMap() => {
        "facebookAccount": facebookAccount,
        "instagramAccount": instagramAccount,
        "tumblrAccount": tumblrAccount,
        "twitterAccount": twitterAccount,
        "tiktokAccount": tiktokAccount,
        "youtubeAccount": youtubeAccount,
        "redditAccount": redditAccount,
        "linkedinAccount": linkedinAccount,
        "twitchAccount": twitchAccount,
      };
}
