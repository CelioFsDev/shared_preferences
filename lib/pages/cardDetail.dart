import 'package:flutter/material.dart';
import 'package:shared_preferences_dio/model/card_detail.dart';

class CardDetailPage extends StatelessWidget {
  final CardDetail cardDetail;
  const CardDetailPage({Key? key, required this.cardDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: cardDetail.idAnimationHero,
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      cardDetail.imagem,
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        cardDetail.titleCard,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Text(
                    cardDetail.textCard,
                    maxLines: 10,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
