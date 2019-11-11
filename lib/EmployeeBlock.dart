import 'dart:async';

/**
 * Seven Steps to make a BLOC pattern.
 * 
 * 1. Imports
 * 2. List of employees
 * 3. Stream Controllers
 * 4. Stream Sink getter
 * 5. Constructor - Add data; Listen to changes.
 * 6. Core functions
 * 7. dispose
 * 
 */

// Step 1
import 'package:async';
import 'Employee.dart';

class EmployeeBloc {

  /**
   * Note:
   * Sink is to add data,
   * Stream is to get data from pipe,
   * by pipe I mean data flow.
   */

  // Step 2
  List<Employee> _employeeList = [
    Employee(1, "EmployeeOne", 10000.0),
    Employee(2, "EmployeeTwo", 20000.0),
    Employee(3, "EmployeeThree", 30000.0),
    Employee(4, "EmployeeFour", 40000.0),
    Employee(5, "EmployeeFive", 50000.0),
  ];

  // Step 3
  final _employeeListStreamController = StreamController<List<Employee>>();

  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  // Step 4
  Stream<List<Employee>> get employeeListStream => _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink => _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement => _employeeSalaryIncrementStreamController.sink;
  StreamSink<Employee> get employeeSalaryDecrement => _employeeSalaryDecrementStreamController.sink;

  // Step 5
  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);
    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary());
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary());
  }
  
  // Step 6
  _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double incrementedSalary = salary * 0.20;

    _employeeList[employee.id - 1].salary = salary + incrementedSalary;

    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double decrementedSalary = salary * 0.20;

    _employeeList[employee.id - 1].salary = salary - decrementedSalary;

    employeeListSink.add(_employeeList);
  }

  // Step 7
  void dispose() {
    _employeeListStreamController.close();
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
  }
}