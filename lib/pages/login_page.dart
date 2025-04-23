import 'package:flutter/material.dart';
import 'package:shared_preferences_dio/pages/drawer_page.dart';
import 'package:shared_preferences_dio/shared/widgets/app_images.dart';

class TrilhaLoginPage extends StatefulWidget {
  const TrilhaLoginPage({super.key});

  @override
  State<TrilhaLoginPage> createState() => _TrilhaLoginPageState();
}

class _TrilhaLoginPageState extends State<TrilhaLoginPage> {
  TextEditingController trilhaEmailController =
      TextEditingController(text: 'email');
  TextEditingController trilhaSenhaController =
      TextEditingController(text: 'tes');
  bool _trilhaObscureText = true;
  var color1 = Colors.deepPurple;
  var color2 = Colors.redAccent;
  // String email = '';
  // String senha = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 4, 4),
      body: SingleChildScrollView(
        //configuração do SingChildScrollView
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Expanded(
                        flex: 11,
                        child: Image.asset(
                          AppImages.Logo,
                          height: 200,
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                  Text('Já tem cadastro?',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      )),
                  Text(
                    'Faça seu login e make the change._',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextField(
                    controller: trilhaEmailController,
                    onChanged: (value) {
                      print(value);
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 0),
                      //enabledBorder: BorderSide(color: Colors.grey[600]),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 103, 58, 183)),
                      ),
                      labelText: 'E-mail',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: Icon(Icons.email,
                          color: Color.fromARGB(255, 103, 58, 183)),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: trilhaSenhaController,
                    onChanged: (value) {
                      print(value);
                    },
                    obscureText: _trilhaObscureText,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 0),
                      labelText: 'Senha',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: Icon(Icons.lock, color: color1),
                      suffixIcon: InkWell(
                        //Pode ser o GestureDetector ou InkWell
                        onTap: () => _trilhaObscureText = !_trilhaObscureText,
                        child: IconButton(
                          icon: Icon(
                            _trilhaObscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: color1,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_trilhaObscureText = !_trilhaObscureText) {
                                color1 == color2;
                              } else {
                                _trilhaObscureText = false;
                              }
                              print(trilhaEmailController.text);
                              print(trilhaSenhaController.text);
                            });
                          },
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.purple,
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              7.0,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (trilhaEmailController.text.trim() == 'email' &&
                            trilhaSenhaController.text.trim() == 'tes') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                ('Logado com sucesso'),
                              ),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrilhaDrawerPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Error ao tentar logar',
                              ),
                            ),
                          );
                          print('Algum erro aconteceu');
                        }
                      },
                      child: Text(
                        'ENTRAR',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                    flex: 3,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Esqueci minha senha',
                      style: TextStyle(color: Colors.yellowAccent),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Criar Conta',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
