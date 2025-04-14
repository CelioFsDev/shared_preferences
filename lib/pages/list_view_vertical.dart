import 'package:flutter/material.dart';
import 'package:shared_preferences_dio/shared/widgets/app_images.dart';

class ListViewVerticalPage extends StatefulWidget {
  const ListViewVerticalPage({super.key});

  @override
  State<ListViewVerticalPage> createState() => _ListViewVerticalPageState();
}

class _ListViewVerticalPageState extends State<ListViewVerticalPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Image.asset(AppImages.user2),
          title: Text("Usuario 2"),
          subtitle: Row(
            children: [
              Text('Olá Tudo bem '),
              Text('08:59'),
            ],
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (menu) {
              if (menu == 'Opção2') {
                print('opção2 ');
              }
            },
            itemBuilder: (BuildContext) {
              return <PopupMenuItem<String>>[
                PopupMenuItem<String>(
                  value: 'Opcao1',
                  child: Text('Opção1'),
                ),
                PopupMenuItem<String>(
                  value: 'Opcao2',
                  child: Text('Opção2'),
                ),
                PopupMenuItem<String>(
                  value: 'Opcao3',
                  child: Text('Opção3'),
                ),
              ];
            },
          ),
          isThreeLine: true,
          onTap: () {},
        ),
        Image.asset(AppImages.user1),
        Image.asset(AppImages.user3),
        Image.asset(AppImages.paisagem1),
        Image.asset(AppImages.paisagem2),
        Image.asset(AppImages.paisagem3),
      ],
    );
  }
}
