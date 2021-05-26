import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String label;
  final double value;
  final double percentage;

  ChartBar({this.label, this.value, this.percentage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder( // Controi o layout, assim sendo possivel ter informações como o tamanho do componente pai, pra utilizar responsividade
      builder: (ctx, contraints) {
        return Column(
        children: [
          Container(
            height: contraints.maxHeight * 0.15,
            child: FittedBox( //Ajusta o tamnho do texto de acordo com o tamnho do componente
              child: Text('${value.toStringAsFixed(2)}')
              ),
          ),
          SizedBox(height: contraints.maxHeight * 0.05),
          Container(
            height: contraints.maxHeight * 0.6, // Responsividade - Calculando porcentagem atraves do tamnho do componente pai 60%
            width: 10,
            child: Stack( // Barra de porcentagem - Stack, um item fica por cima do outro
            alignment: Alignment.bottomCenter,
              children: [
                Container( // Barra
                  decoration: BoxDecoration( // style
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5)
                  ),
                ),
                FractionallySizedBox( // Preenchimento
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                )
              ],
            ), 
          ),
          SizedBox(height: contraints.maxHeight * 0.05),
          Container(
            height: contraints.maxHeight * 0.15,
            child: FittedBox(child: Text(label))
            )
        ],
      );
      },
    );
  }
}