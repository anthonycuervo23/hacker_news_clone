class UrlHelper {
  static String urlForItem(dynamic itemId) {
    return 'https://hacker-news.firebaseio.com/v0/item/$itemId.json';
  }

  static String urlItems(String page) {
    return 'https://hacker-news.firebaseio.com/v0/$page.json';
  }
}
