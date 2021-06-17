import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData(){
    final enteredTitle = titleController.text;
    final enteredAmount =  double.parse(amountController.text);
    
    
    if(enteredTitle.isEmpty || enteredAmount <=0){
      return;
    }

    /* widget.quelqueChose permet d'accéder aux information dans le widget */
    widget.addTx(
          enteredTitle,
          enteredAmount,
                );

    /* Navigator.of(context).pop permet de fermer l'onglet NewTransaction une fois que les informations ont été entrées*/
    Navigator.of(context).pop();
    
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Titre'),
              controller:
                  titleController, /* enregistrement des données du clavier dans la propriété titleController, 
                                               pas besoin de crééer une fonction sur onChanged ici */
              // onChanged: (value) {
              //   titleInput = value;
              // },
              onSubmitted: (_) => submitData(),
              ),
            TextField(
              decoration: InputDecoration(labelText: 'Montant'),
              controller: amountController,
              keyboardType: TextInputType.number,
              /* subitData est une fonction demandant une argument en entrée, le fait de mettre "_", est une convention pour dire qu'on met quelque chose mais qu'on veut pas le nommer */
              onSubmitted: (_) => submitData(),
              //  onChanged: (value) => amountInput = value,
            ),
            FlatButton(
              textColor: Colors.purple,
              child: Text('Ajouter Transaction'),
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
