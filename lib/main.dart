import 'package:flutter/material.dart';

import './/widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';


void main() => runApp(MyApp());  

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dépenses personnelles',
                                                /* il faut utiliser ThemeData() et linker avec color: Theme.of(context). dans decoration : BoxDecoration pour pouvoir ajuster toutes la couleur de l'application d'un seul coup */
      theme: ThemeData(
        primarySwatch: Colors.green,
                                              /* accentColor change la couleur que des widgets configurer pour répondre à cette demande, comme l'est le FloatingButton */ 
        accentColor: Colors.amber,
        fontFamily: 'Quicksand', 
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(fontFamily: 'OpenSans',
           fontWeight: FontWeight.bold,
            fontSize: 18),
          ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
                                              /* title a été remplacé par healdline6 car deprecaded ( 2014 version) */
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,  
            ),
          ),
        )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String? titleInput;
  // String? amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Nouvelle Chaussure',
    //   amount: 89.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Tee Shirt',
    //   amount: 29.99,
    //   date: DateTime.now(),
    // ),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context: ctx, 
      builder: (_){
      return GestureDetector(
        onTap: () {},
        child: NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      ); 
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dépenses personnelles'),
        actions: <Widget>[
         IconButton(
           icon: Icon(Icons.add), 
           onPressed: ()=>_startAddNewTransaction(context),
           ),
        ],
      ),
      body: SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('CHART!'),
                elevation: 5,
              ),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>_startAddNewTransaction(context),
        ),
    );
  }
}
