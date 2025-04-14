import 'package:flutter/material.dart';
import 'package:shared_preferences_dio/model/card_detail.dart';
import 'package:shared_preferences_dio/pages/cardDetail.dart';
import 'package:shared_preferences_dio/repositories/card_detail_repository.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  CardDetail? cardDetail;
  var cardDetailRepository = CardDetailRepository();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    cardDetail = await cardDetailRepository.get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: double.infinity,
            child: cardDetail == null
                ? LinearProgressIndicator()
                : InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CardDetailPage(
                                    cardDetail: cardDetail!,
                                  )));
                    },
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: cardDetail!.idAnimationHero,
                      child: Card(
                        elevation: 16,
                        shadowColor: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    cardDetail!.imagem,
                                    height: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Text(
                                      cardDetail!.titleCard,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                cardDetail!.textCard,
                                maxLines: 3,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Ler mais",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
