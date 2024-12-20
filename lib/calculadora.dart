import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  // Variáveis de controle da expressão e do resultado
  String _expressao = '';
  String _resultado = '';

  // Constantes para os botões
  final String _limpar = 'Limpar';

  // Método chamado ao pressionar um botão
  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == _limpar) {
        _expressao = ''; // Limpa a expressão
        _resultado = ''; // Limpa o resultado
      } else if (valor == '=') {
        _calcularResultado(); // Calcula o resultado
      } else {
        _expressao += valor; // Adiciona o valor à expressão
      }
    });
  }

  // Método para calcular o resultado da expressão
  void _calcularResultado() {
    try {
      // Tenta calcular a expressão e exibe o resultado
      _resultado = _avaliarExpressao(_expressao).toString();
    } catch (e) {
      // Se der erro, exibe uma mensagem de erro
      _resultado = 'Erro: não foi possível calcular';
      debugPrint('Erro ao calcular: $e');
    }
  }

  // Método para avaliar a expressão usando a biblioteca expressions
  double _avaliarExpressao(String expressao) {
    // Substitui os símbolos de multiplicação e divisão pelos corretos
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');
    
    // Avalia a expressão
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    Expression expression = Expression.parse(expressao);
    final resultado = avaliador.eval(expression, {});
    return resultado;
  }

  // Método que cria os botões da calculadora
  Widget _botao(String valor) {
    return TextButton(
      onPressed: () => _pressionarBotao(valor), // Ao pressionar, chama a função
      child: Text(
        valor,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Método que constrói a interface gráfica
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculadora")),
      body: Column(
        children: [
          // Área para mostrar a expressão digitada
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                _expressao,
                style: const TextStyle(fontSize: 36),
              ),
            ),
          ),
          
          // Área para mostrar o resultado
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                _resultado,
                style: const TextStyle(fontSize: 36),
              ),
            ),
          ),
          
          // Grid de botões
          Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: 4, // Número de colunas
              childAspectRatio: 2, // Tamanho proporcional dos botões
              children: <Widget>[
                _botao('7'),
                _botao('8'),
                _botao('9'),
                _botao('÷'),
                _botao('4'),
                _botao('5'),
                _botao('6'),
                _botao('x'),
                _botao('1'),
                _botao('2'),
                _botao('3'),
                _botao('-'),
                _botao('0'),
                _botao('.'),
                _botao('='),
                _botao('+'),
              ],
            ),
          ),
          
          // Botão de limpar
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: _botao('Limpar'),
            ),
          ),
        ],
      ),
    );
  }
}
