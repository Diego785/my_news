import 'package:flutter/material.dart';
import 'package:my_news/src/pages/tab1_page.dart';
import 'package:my_news/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegationModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavegationModel>(context);

    return BottomNavigationBar(
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.red,
      currentIndex: navigationModel.paginaActual,
      onTap: (i) => navigationModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.black,
          icon: Icon(
            Icons.person_outline,
          ),
          label: 'Para tí',
        ),
        
        BottomNavigationBarItem(
            icon: Icon(
              Icons.public,
            ),
            label: 'Encabezados'),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navegationModel = Provider.of<_NavegationModel>(context);

    return PageView(
    controller: navegationModel.pageController,
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _NavegationModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = new PageController(initialPage: 0);

  int get paginaActual => this._paginaActual;
  set paginaActual(int valor) {
    this._paginaActual = valor;

    _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    
    notifyListeners();
  }

  PageController get pageController => this._pageController;

}
