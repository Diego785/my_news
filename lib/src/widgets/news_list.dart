import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:my_news/src/models/news_models.dart';
import 'package:my_news/src/theme/dark.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;

  const NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.news.length,
      itemBuilder: (context, index) {
        return _Noticia(noticia: this.news[index], index: index);
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const _Noticia({required this.noticia, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(noticia, index),
        _TarjetaTitulo(noticia),
        _TarjetaImage(noticia),
        _TarjetaBody(noticia),
        _TarjetaBotones(noticia),
        SizedBox(height: 10),
        Divider(),
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  final Article noticia;

  const _TarjetaBotones(this.noticia);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
          onPressed: () {},
          fillColor: myTheme.accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.star_border),
        ),
        SizedBox(
          width: 10,
        ),
        RawMaterialButton(
          onPressed: () => _launchURL(noticia.url),
          fillColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.visibility),
        ),
      ],
    );
  }
}

_launchURL(urlNew) async {
  final url = urlNew;
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;

  const _TarjetaBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text((noticia.description != null) ? noticia.description! : ''),
    );
  }
}

class _TarjetaImage extends StatelessWidget {
  final Article noticia;

  const _TarjetaImage(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        child: Container(
          child: (noticia.urlToImage != null)
              ? FadeInImage(
                  placeholder: AssetImage('assets/img/giphy.gif'),
                  image: NetworkImage(noticia.urlToImage!),
                )
              : Image(
                  image: AssetImage('assets/img/no-image.png'),
                ),
        ),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        noticia.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final int index;

  const _TarjetaTopBar(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${index + 1}. ',
            style: TextStyle(color: myTheme.accentColor),
          ),
          Text('${noticia.source.name}. '),
        ],
      ),
    );
  }
}
