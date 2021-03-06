using Appboy.Utilities;
using System;

namespace Appboy.Models.Cards {
  public class CrossPromotionSmallCard : Card {
    public string Title { get; private set; }

    public string Subtitle { get; private set; }

    public string Caption { get; private set; }

    public string ImageUrl { get; private set; }

    public double Rating { get; private set; }

    public int ReviewCount { get; private set; }

    public double Price { get; private set; }

    public string Url { get; private set; }
#if UNITY_ANDROID
    public string Package { get; private set; }
#endif
#if UNITY_IOS
    public string MediaType { get; private set; }
    public int ITunesId { get; private set; }
    public bool Universal { get; private set; }
#endif

    public CrossPromotionSmallCard(JSONClass json) : base(json) {
      if (json["title"] == null || json["subtitle"] == null || json["caption"] == null || json["rating"] == null || json["reviews"] == null || json["price"] == null || json["url"] == null) {
        throw new ArgumentException("Missing required field(s).");
      }
      Title = json["title"];
      Subtitle = json["subtitle"];
      Caption = json["caption"];
      ImageUrl = json["image"];
      Rating = json["rating"].AsDouble;
      ReviewCount = json["reviews"].AsInt;
      Price = json["price"].AsDouble;
      Url = json["url"];

#if UNITY_ANDROID
      if (json["package"] == null) {
        throw new ArgumentException("Missing required field(s).");
      }
      Package = json["package"];
#endif
#if UNITY_IOS
      if (json["media_type"] == null || json["itunes_id"] == null) {
        throw new ArgumentException("Missing required field(s).");
      }
      MediaType = json["media_type"];
      ITunesId = json["itunes_id"].AsInt;
      if (json["universal"].AsBool) {
        Universal = json["universal"].AsBool;
      }
#endif
    }

    public override string ToString() {
      string partial = String.Format("CrossPromotionSmallCard[{0}, Title={1}, Subtitle={2}, Caption={3}, " + 
        "ImageUrl={4}, Rating={5}, ReviewCount={6}, Price={7}, uri={8}",
                                     base.ToString(), Title, Subtitle, Caption, ImageUrl, Rating, ReviewCount, Price, Url);
      string platformSpecific = "]";
#if UNITY_ANDROID
      platformSpecific = String.Format("Package={0}]", Package);
#endif
#if UNITY_IOS
      platformSpecific = String.Format("MediaType={0}, ITunesId={1}, Universal={2}]", MediaType, ITunesId, Universal);
#endif
      return partial + platformSpecific;
    }
  }
}
