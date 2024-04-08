import 'package:flutter/material.dart';
import 'package:loginmarquei3/componentes/decoracao_login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {
  HomePage({super.key});

  bool queroEntrar = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final RegExp emailRegExp = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Fazer Login',
                    style: TextStyle(fontSize: 39, fontWeight: FontWeight.bold),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Ainda não tem conta?'),
                      TextButton(
                          onPressed: EsqueciSenha,
                          child: Text(
                            'Crie a sua agora',
                            style: TextStyle(color: Color(0xFF0053CC)),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text('E-mail',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: getAuthenticationInputDecoration(''),
                          validator: (email) {
                            if (email == null) {
                              return 'insira um email';
                            }
                            if (email.length < 10) {
                              return 'Insira um e-mail maior';
                            }
                            if (!email.contains("@")) {
                              return "o e-mail tem que ter '@' ";
                            }
                            if (!email.contains(".com")) {
                              return "o e-mail tem que ter '.com' ";
                            }
                            return null;
                          },
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                        const Row(
                          children: [
                            Text('Senha',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: getAuthenticationInputDecoration(""),
                          validator: (senha) {
                            if (senha == '') {
                              return 'insira uma senha';
                            }
                          },
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0053CC)),
                              foregroundColor:
                                  const MaterialStatePropertyAll(Colors.white),
                              minimumSize: const MaterialStatePropertyAll(
                                Size(400.0, 40.0),
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0)))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              realizarLogin(context);
                            }
                          },
                          child: const Text('Fazer Login'),
                        ),
                        const SizedBox(
                          height: 22.0,
                        ),
                        const TextButton(
                            onPressed: EsqueciSenha,
                            child: Text(
                              'Esqueci minha senha',
                              style: TextStyle(color: Color(0xFF0053CC)),
                            )),
                        const SizedBox(
                          height: 22.0,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Marquei',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('©2024, todos os direitos reservados'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }


  
  realizarLogin(BuildContext context) async {
    var url = Uri.parse('https://marquei-api.fly.dev/api/core/token/');

    try {
      var response = await http.post(
        url,
        body: {
          "password": _passwordController.text,
          "email": _emailController.text,
        },
      );

      if (response.statusCode == 200) {
        // Login bem-sucedido, você pode lidar com a resposta da API aqui
        print('>>>>>>Login bem-sucedido');
        print(response
            .body); // Aqui você pode processar os dados da resposta, se necessário
      } else {
        // Login falhou
        print('>>>>>>Falha no login: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Dados Inválidos'),
            behavior: SnackBarBehavior.floating,
          ),
        ); // Aqui você pode exibir uma mensagem de erro para o usuário
      }
    } catch (error) {
      // Erro de conexão ou outro erro
      print('>>>>>>Erro durante a chamada da API: $error');
      // Aqui você pode exibir uma mensagem de erro para o usuário, por exemplo, usando um showDialog
    }
  }

  static void EsqueciSenha() async {
    const url = 'https://www.globo.com';
    try {
      await launchUrl(Uri.parse(url));
    } catch (error) {
      print('link inválido');
    }
  }

}