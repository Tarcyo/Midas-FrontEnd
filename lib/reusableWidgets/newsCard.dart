import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String url;
  final String imamgeUrl;

  const NewsCard(
    this.title,
    this.imamgeUrl,
    this.url, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrlString(url)) {
          await launchUrlString(url);
        } else {
          throw 'Não foi possível abrir a URL: $url';
        }
      },
      child: Container(
        width: 170, // Ajuste a largura conforme necessário
        height: 230, // Ajuste a altura conforme necessário
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(20), // Bordas arredondadas para o container
          color: Colors.white, // Cor de fundo definida como branca
          boxShadow: [
            BoxShadow(
              color:
                  Colors.grey.withOpacity(0.5), // Opacidade da sombra ajustada
              blurRadius: 20,
            ),
          ],
        ),
        padding: const EdgeInsets.all(8), // Preenchimento interno
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(180),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.network(
                        imamgeUrl, // Usando o URL recebido via construtor
                        height: 170, // Ajuste a altura conforme necessário
                        width: 170, // Ajuste a largura conforme necessário
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
                height: 5), // Espaço entre a imagem e o texto de descrição
            Text(
              title, // Use o título recebido via construtor
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "BBC", // Exemplo de texto, você pode modificar conforme necessário
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ), // Espaço entre a imagem e o texto de descrição
          ],
        ),
      ),
    );
  }
}
