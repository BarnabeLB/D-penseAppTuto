import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx);

  void submitData(){
    final enteredTitle = titleController.text;
    final enteredAmount =  double.parse(amountController.text);
    
    
    if(enteredTitle.isEmpty || enteredAmount <=0){
      return;
    }
    addTx(
          enteredTitle,
          enteredAmount,
                );
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
