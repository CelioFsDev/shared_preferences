import 'package:flutter/material.dart';
import 'package:shared_preferences/shared/widgets/app_images.dart';

class ListViewHorizontalPage extends StatefulWidget {
  const ListViewHorizontalPage({super.key});

  @override
  State<ListViewHorizontalPage> createState() => _ListViewHorizontalPageState();
}

class _ListViewHorizontalPageState extends State<ListViewHorizontalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista Horizontal')),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Card(
                  child: Image.asset(
                    AppImages.paisagem1,
                    // height: 100,
                  ),
                ),
                Card(
                  child: Image.asset(
                    AppImages.paisagem2,
                    // height: 100,
                  ),
                ),
                Card(
                  child: Image.asset(
                    AppImages.paisagem2,
                    // height: 100,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
