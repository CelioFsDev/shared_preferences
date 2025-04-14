import 'package:flutter/material.dart';
import 'package:shared_preferences_dio/pages/card_page.dart';
import 'package:shared_preferences_dio/pages/list_view_horizontal.dart';
import 'package:shared_preferences_dio/pages/list_view_vertical.dart';
import 'package:shared_preferences_dio/pages/nova_tarefa_page.dart';
import 'package:shared_preferences_dio/shared/widgets/custom_drawer.dart';

class TrilhaDrawerPage extends StatefulWidget {
  const TrilhaDrawerPage({super.key});

  @override
  State<TrilhaDrawerPage> createState() => _TrilhaDrawerPageState();
}

class _TrilhaDrawerPageState extends State<TrilhaDrawerPage> {
  PageController trilhaControllerPage = PageController(initialPage: 0);
  int trilhaPosicaoPagina = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Minha home Drawer'),
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: trilhaControllerPage,
                onPageChanged: (value) {
                  setState(() {
                    trilhaPosicaoPagina = value;
                  });
                },
                scrollDirection: Axis.horizontal,
                children: [
                  CardPage(),
                  ListViewVerticalPage(),
                  ListViewHorizontalPage(),
                  TarefaPage(),
                ],
              ),
            ),
            BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  trilhaControllerPage.jumpToPage(value);
                },
                currentIndex: trilhaPosicaoPagina,
                items: [
                  BottomNavigationBarItem(
                      label: 'CarView', icon: Icon(Icons.home)),
                  BottomNavigationBarItem(
                      label: 'ListView V', icon: Icon(Icons.addchart)),
                  BottomNavigationBarItem(
                      label: 'ListView H', icon: Icon(Icons.image)),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.task), label: 'Tarefas'),
                ])
          ],
        ),
      ),
    );
  }
}
