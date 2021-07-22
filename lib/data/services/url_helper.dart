class UrlHelper {
  static String urlForStory(dynamic storyId) {
    return 'https://hacker-news.firebaseio.com/v0/item/$storyId.json';
  }

  static String urlStories(String page) {
    return 'https://hacker-news.firebaseio.com/v0/$page.json';
  }
}
