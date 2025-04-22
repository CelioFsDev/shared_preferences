import 'package:flutter/material.dart';
import 'package:shared_preferences_dio/pages/configuracoes/configuracoes_hive_page.dart';
import 'package:shared_preferences_dio/pages/configuracoes/configuracoes_shared_preferences_page.dart';
import 'package:shared_preferences_dio/pages/dados_cadastrais/dados_cadastrais.dart';
import 'package:shared_preferences_dio/pages/login_page.dart';
import 'package:shared_preferences_dio/pages/numeros_aleatorios/numeros_aleatorios_hive_page.dart';
import 'package:shared_preferences_dio/pages/numeros_aleatorios/numeros_aleatorios_shared_preferences_page.dart';
import 'package:shared_preferences_dio/shared/widgets/termos_de_uso.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
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
                            title: const Text("CAMERA"),
                            leading: const Icon(Icons.camera),
                            onTap: () {},
                          ),
                          ListTile(
                            title: const Text("GALERIA"),
                            leading: const Icon(Icons.photo_album_outlined),
                            onTap: () {},
                          ),
                          ListTile(
                            title: const Text("SAIR"),
                            leading: const Icon(Icons.exit_to_app),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/images/logo.jpg',
                  ),
                ),
                accountName: const Text('Célio Ferreira'),
                accountEmail: const Text('email@email.com'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TrilhaDadosCadastrais(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
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
            const Divider(),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const NumerosAleatoriosSharedPreferencesPage(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.numbers),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Text(
                          'Numeros Aleatórios SharedPreferences',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NumerosAleatoriosHivePage(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.numbers),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      'Numeros Aleatórios Hive',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ConfiguracaoSharedPreferencesPage(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.construction),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      'Configurações sharedPreferences',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConfiguracoesHivePage(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.construction),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      'Configurações Hive',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: const Row(
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
                        return const SingleChildScrollView(
                          child: Column(
                            children: [
                              Center(
                                child: Text('TERMOS DE USO',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextTermosDeUso(),
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
            ),
            const Divider(),
            InkWell(
              child: const Row(
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
                        title: const Text('Meu app',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        content: const Wrap(children: [
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
                                child: const Text('Não'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context,
                                      MaterialPageRoute(
                                              builder: (context) =>
                                                  const TrilhaLoginPage())
                                          as String);
                                },
                                child: const Text('Sim'),
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
      ),
    );
  }
}
