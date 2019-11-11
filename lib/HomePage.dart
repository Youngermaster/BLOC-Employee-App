import 'package:flutter/material.dart';
import 'EmployeeBlock.dart';
import 'Employee.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLOC Employee App"),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          Stream: _employeeBloc.employeeListStream,
          builder: (BuildContext context, AsyncSnapshot<List<Employee>> snapshot)
          {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5.0,
                  child: Row(
                    mainAxisAligment: MainAxisAligment.spaceAround,
                    children: <Widget> [
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "${snapshot.data[index].id}.",
                          style: Text(fontSize: 20.0),

                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAligment: CrossAxisAligment.start,
                          children: <Widget>[
                            Text(
                              "${snapshot.data[index].name}.",
                              style: Text(fontSize: 18.0),
                            ),
                            Text(
                              "\$ ${snapshot.data[index].salary}.",
                              style: Text(fontSize: 16.0),
                            )
                          ]
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icon.thumb_up),
                          color: Color.green,
                          onPressed: () {
                            _employeeBloc.employeeSalaryIncrement.add(snapshot.data[index]);
                          },
                        )
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icon.thumb_down),
                          color: Color.red,
                          onPressed: () {
                            _employeeBloc.employeeSalaryDecrement.add(snapshot.data[index]);
                          },
                        )
                      )
                    ],
                  ),
                );
              }
            );
          },
        ),
      )
    );
  }
}