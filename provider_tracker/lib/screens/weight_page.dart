import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:provider_tracker/models/weight.dart';
import 'package:provider_tracker/state/weight_state.dart';

class WeightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Tracker Demo'),
      ),
      body: Consumer<WeightState>(
        builder: (context, state, widget){
          var weigths=state.weight;
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 100,
                  child: 
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: 
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Current weight', textScaleFactor: 1.2,),
                            Text(weigths.first.value.toString(), textScaleFactor: 1.2,)
                          ],
                        ),
                      )
                    ),
                ),
                Expanded(
                  child: 
                    ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        var weigth=weigths[index];
                        return ListTile(
                          title: Text('${weigth.time.day}.${weigth.time.month}.${weigth.time.year}'),
                          trailing: Text(
                            weigth.value.toString(),
                            textScaleFactor: 2,),
                        );
                      },
                      itemCount: weigths.length,
                    ),
                )
              ],
            ),
          );
        } 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          // listen: false -> Provider.of widget'ın re-build olmaması icin
          var state=Provider.of<WeightState>(context, listen: false);
          var result= await showDialog<double>(
            context: context,
            builder: (context)=> NumberPickerDialog.decimal(minValue: 1, maxValue: 200, initialDoubleValue: state.weight.first.value)
          );
          if(result != null && result > 0){
            state.add(Weight(value: result, time: DateTime.now()));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}