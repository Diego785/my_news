import 'package:flutter/material.dart';
import 'package:my_news/src/models/category_model.dart';
import 'package:my_news/src/services/news_service.dart';
import 'package:my_news/src/theme/dark.dart';
import 'package:my_news/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatefulWidget {
  const Tab2Page({super.key});

  @override
  State<Tab2Page> createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    Provider.of<NewsService>(context).getArticlesByCategory('business');
    final newsService =
        Provider.of<NewsService>(context).getArticlesCategorySelected;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListCategories(),
            (newsService.length == 0)
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: NewsList(newsService)),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ListCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: newsService.categories.length,
        itemBuilder: (context, index) {
          final cName = newsService.categories[index].name;

          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(newsService.categories[index]),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${cName[0].toUpperCase()}${cName.substring(1)}',
                  style: TextStyle(
                    color: (newsService.selectedCategory == cName)
                        ? myTheme.accentColor
                        : Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;
  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final selectedCategory = Provider.of<NewsService>(context).selectedCategory;

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          category.icon,
          color: (selectedCategory == category.name)
              ? myTheme.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
