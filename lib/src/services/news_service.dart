import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:my_news/src/models/category_model.dart';

import 'package:my_news/src/models/news_models.dart';

final _URL_NEWS_API = 'https://newsapi.org/v2';
final _APIKEY = '29b7885791ce436daebf6c6e655e2680';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.football, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
    Category(FontAwesomeIcons.language, 'spanish'),
    Category(FontAwesomeIcons.language, 'english'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();
    categories.forEach((element) {
      this.categoryArticles[element.name] = [];
    });
  }

  String get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;

    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticlesCategorySelected =>
      this.categoryArticles[this.selectedCategory]!;

  getTopHeadlines() async {
    final url = '$_URL_NEWS_API/top-headlines?apiKey=$_APIKEY&language=en';
    final uri = Uri.parse(url);
    final resp = await http.get(uri);

    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category] != null) {
      if (this.categoryArticles[category]!.length > 0) {
        return this.categoryArticles[category];
      }

      final url;
      if (category == 'spanish' || category == 'english') {
        (category == 'spanish')
            ? url = '$_URL_NEWS_API/top-headlines?apiKey=$_APIKEY&language=es'
            : url = '$_URL_NEWS_API/top-headlines?apiKey=$_APIKEY&language=en';
      } else {
        url = '$_URL_NEWS_API/top-headlines?apiKey=$_APIKEY&category=$category';
      }
      final uri = Uri.parse(url);
      final resp = await http.get(uri);

      final newsResponse = newsResponseFromJson(resp.body);
      this.categoryArticles[category]!.addAll(newsResponse.articles);

      notifyListeners();
    }
  }
}
