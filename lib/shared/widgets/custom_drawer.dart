import 'package:flutter/material.dart';
import 'package:shared_preferences_dio/pages/configuracoes_page.dart';
import 'package:shared_preferences_dio/pages/dados_cadastrais.dart';
import 'package:shared_preferences_dio/pages/login_page.dart';
import 'package:shared_preferences_dio/pages/numeros_aleatorios_page.dart';
import 'package:shared_preferences_dio/shared/widgets/termos_de_uso.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  context: context,
                  builder: (BuildContext bc) {
                    return Wrap(
                      //deixa os itens agrupados
                      children: [
                        ListTile(
                          title: Text("CAMERA"),
                          leading: Icon(Icons.camera),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text("GALERIA"),
                          leading: Icon(Icons.photo_album_outlined),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text("SAIR"),
                          leading: Icon(Icons.exit_to_app),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });
            },
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/images/logo.jpg',
                ),
              ),
              accountName: Text('Célio Ferreira'),
              accountEmail: Text('email@email.com'),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrilhaDadosCadastrais(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.person),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Text(
                    'Dados Cadastrais',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NumerosAleatoriosPage(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.numbers),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Text(
                    'Numeros Aleatórios',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfiguracaoPage(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.construction),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Text(
                    'Configurações',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    Icon(Icons.library_add),
                    Text('Termos de uso e Privacidade'),
                  ],
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Center(
                              child: Text('TERMOS DE USO',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextTermosDeUso(),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
          ),
          Divider(),
          InkWell(
            child: Row(
              children: [
                Icon(Icons.exit_to_app),
                Text('Sair'),
              ],
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return AlertDialog(
                      alignment: Alignment.center,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text('Meu app',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      content: Wrap(children: [
                        Text('Deseja realmente sair do aplicativo?'),
                      ]),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Não'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TrilhaLoginPage()) as String);
                              },
                              child: Text('Sim'),
                            ),
                          ],
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
