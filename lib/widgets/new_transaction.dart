import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx){
    print("Constructor NewTransaction Widget");
  }

  @override
  _NewTransactionState createState() {
    print("createState NewTransaction Widget");
    return _NewTransactionState();
    }  
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  _NewTransactionState(){
    print("Constructor NewTransaction State");
  }

  @override
  void initState() {
    print("initState()"); // c'est initState qui permet d'envoyer entre deux reconstructions de l'arbre de widget des requêtes server/http etc...
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
   print("didUpdateWidget()"); //permet de gérer les updates venant d'une database par exemple
    super.didUpdateWidget(oldWidget);
  }

 @override
  void dispose() {
    print("dispose()"); // bien pour nettoyer les data
    super.dispose();
  }


  
  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    /* widget.quelqueChose permet d'accéder aux information dans le widget */
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    /* Navigator.of(context).pop permet de fermer l'onglet NewTransaction une fois que les informations ont été entrées*/
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      // .then permet d'attendre un input de l'utilisateur sans pour autant bloquer la lecture du programme
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Titre'),
                controller: _titleController,
                /* enregistrement des données du clavier dans la propriété titleController, 
                                                 pas besoin de crééer une fonction sur onChanged ici */
                // onChanged: (value) {
                //   titleInput = value;
                // },
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Montant'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                /* subitData est une fonction demandant une argument en entrée, le fait de mettre "_", est une convention pour dire qu'on met quelque chose mais qu'on veut pas le nommer */
                onSubmitted: (_) => _submitData(),
                //  onChanged: (value) => amountInput = value,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Pas de date choisie!'
                            : 'Date Choisie : ${DateFormat.yMd().format(_selectedDate!)}',
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: const Text(
                        'Choisissez une date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button!.color,
                child: const Text('Ajouter Transaction'),
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
