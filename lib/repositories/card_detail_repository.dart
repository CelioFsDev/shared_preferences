import 'package:shared_preferences/model/card_detail.dart';
import 'package:shared_preferences/shared/widgets/app_images.dart';

class CardDetailRepository {
  Future<CardDetail> get() async {
    await Future.delayed(Duration(seconds: 3));
    return CardDetail(
      idAnimationHero: 1,
      titleCard: 'Meu card',
      imagem: AppImages.Logo,
      textCard:
          'Usamos cookies opcionais para melhorar sua experiência em nossos sites, como por meio de conexões de mídia social e para exibir publicidade personalizada com base em sua atividade online. Se você rejeitar os cookies opcionais, serão usados somente os cookies necessários para fornecer os serviços. Você pode alterar sua escolha clicando em Gerenciar cookies na parte inferior da página.Política de privacidade Cookies de terceiros',
    );
  }
}
