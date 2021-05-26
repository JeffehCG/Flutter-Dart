import 'dart:io';
import 'dart:math';
import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main(List<String> args) {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Impedindo que a tela vire (Aplicação só fica em uma orientação)
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp
    // ]);

    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          // Definindo um tema de desing padrão para o app
          // primaryColor: Colors.purple, //Define uma cor fixa
          primarySwatch: Colors.purple, // Define uma lista de cor
          accentColor: Colors.amber, // Cor de realce,
          fontFamily:
              'Quicksand', // Fontes (Configuradas no arquivo pubspec.yaml)
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              // Definindo tema para o appbar
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans', fontWeight: FontWeight.bold)))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  // Analisando e detectando os estados da aplicação
  // Adicionando um observador na iniciação do Widget
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  // Metodo chamado sempre que ocorre uma mudança no estado da aplicaçãos
  @override
    void didChangeAppLifecycleState(AppLifecycleState state) {
      super.didChangeAppLifecycleState(state);
      print(state);
    }

    // Os estados são
    // paused - Quando a aplicação esta em background
    // resumed - Pronta para receber entrada do usuario
    // inactive - Transição entre os estados
    // suspended - Aplicação fechada

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  bool _showChart = false;

  List<Transaction> _transaction = [
    Transaction(
        id: 't0',
        title: 'Conta Antiga',
        value: 400.00,
        date: DateTime.now().subtract(Duration(days: 33))),
    Transaction(
        id: 't1',
        title: 'Novo Tenis',
        value: 310.76,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: 't2',
        title: 'Conta de Luz',
        value: 211.30,
        date: DateTime.now().subtract(Duration(days: 4))),
    Transaction(
        id: 't3',
        title: 'Conta de Agua',
        value: 89.77,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        id: 't4',
        title: 'Cartão de Credito',
        value: 456.00,
        date: DateTime.now().subtract(Duration(days: 0))),
    Transaction(
        id: 't5',
        title: 'Gazolina',
        value: 50.00,
        date: DateTime.now().subtract(Duration(days: 7))),
    Transaction(
        id: 't6',
        title: 'Refeição',
        value: 25.99,
        date: DateTime.now().subtract(Duration(days: 5)))
  ];

  List<Transaction> get _recentTransaction {
    // Pegando transações de ate 7 dias atras
    return _transaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      // Reponsavel por controllar o parametros que mudam
      _transaction.add(newTransaction);
    });

    Navigator.of(context).pop(); // Fechando o modal
  }

  _deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((tr) => tr.id == id);
    });
  }

  _updateTransaction(Transaction transaction) {
    setState(() {
      for (var tr in _transaction) {
        if (tr.id == transaction.id) tr = transaction;
      }
    });

    Navigator.of(context).pop(); // Fechando o modal
  }

  _openTransactionFormModal(BuildContext context, [Transaction transaction]) {
    showModalBottomSheet(
        // Metodo para abrir modal
        context: context,
        builder: (ctx) {
          return TransactionForm(_addTransaction, _updateTransaction,
              transaction); // Componente de Formulario
        });
  }

  Widget _getIconButtonsAndroidOrIOS(IconData icon, Function fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final titleAppBar = Text(
      'Despesas Pessoais',
      style: TextStyle(
          fontSize: 20 *
              mediaQuery
                  .textScaleFactor // Definindo o tamanho da fonte de acordo com a preferencia do usuario (textScaleFactor = Configuração do dispositivo, por padrão é 1)
          ),
    );

    final actionsAppBar = [
      if (isLandscape) // Exibe Toggle apenas no modo paisagem
        _getIconButtonsAndroidOrIOS(
            _showChart
                ? (Platform.isIOS ? CupertinoIcons.list_bullet : Icons.list)
                : (Platform.isIOS ? CupertinoIcons.chart_bar : Icons.pie_chart),
            () {
          setState(() {
            _showChart = !_showChart;
          });
        }),
      _getIconButtonsAndroidOrIOS(
          // Botão para abrir formulario
          Platform.isIOS ? CupertinoIcons.add : Icons.add,
          () => _openTransactionFormModal(context))
    ];

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: titleAppBar,
            trailing: Row(
              mainAxisSize: MainAxisSize.min, // Ocupando o minimo possivel
              children: actionsAppBar,
            ),
          )
        : AppBar(
            title: titleAppBar,
            actions: actionsAppBar,
          );

    // Responsividade - Pegando a altura disponivel (Tela menos altura appBar menos padding)
    final avaibleHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
        //SafeArea - Componente que concidera apenas a area segura da tela para colocar os componentes, (Tem aparelho que tem note)
        child: SingleChildScrollView(
      //Habilitando scroll
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .stretch, // Alinha a orientação secundaria (Da Column é a linha)
        children: [
          if (isLandscape) // Exibe Toggle apenas no modo paisagem
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Alinha a orientação principal (Da Row é a linha)
              children: [
                Text('Exibir Grafico'),
                Switch.adaptive(
                    // Usando o .adaptive ele ira adaptar o layout de acordo com a plataforma (IOS, Android)
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    }),
              ],
            ),
          if (_showChart || !isLandscape)
            Container(
                height: avaibleHeight *
                    (!isLandscape
                        ? 0.3
                        : 0.65), // Responsividade - Definindo altura igual a 30% da tela disponivel
                child: Chart(
                    _recentTransaction) // Componente de Grafico de transacoes
                ),
          if (!_showChart || !isLandscape)
            Container(
                height: avaibleHeight *
                    (!isLandscape
                        ? 0.7
                        : 0.85), // Responsividade - Definindo altura igual a 70% da tela disponivel
                child: TransactionList(_transaction, _deleteTransaction,
                    _openTransactionFormModal) // Componente de Lista de Transações
                ),
        ],
      ),
    ));

    return Platform
            .isIOS // Alterando layout de acordo com a plataforma (IOS,Android etc...)
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () =>
                  _openTransactionFormModal(context), // abrir formulario
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}

// Aonde o código estava:

// Theme.of(context).textTheme.title
// Você vai deixar assim

// Theme.of(context).textTheme.headline6
