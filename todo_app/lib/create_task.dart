import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateTask extends StatelessWidget {
  CreateTask({Key? key}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Create To-do',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: const Color.fromRGBO(37, 43, 103, 1),
        ),
        body: Form(
          key: _formKey,
          child: ListView(padding: const EdgeInsets.all(16), children: [
            TextFormField(
                controller: _titleController,
                maxLines: 1,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(37, 43, 103, 1))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(37, 43, 103, 1))),
                    hintText: 'Enter the title of your task',
                    labelText: 'Title',
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(37, 43, 103, 1),
                        fontWeight: FontWeight.w600),
                    floatingLabelBehavior: FloatingLabelBehavior.never),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title field is required';
                  }
                }),
            const SizedBox(height: 15.0),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(37, 43, 103, 1))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(37, 43, 103, 1))),
                  hintText: 'Enter the description of the task',
                  labelText: 'Description',
                  labelStyle: TextStyle(
                      color: Color.fromRGBO(37, 43, 103, 1),
                      fontWeight: FontWeight.w600),
                  floatingLabelBehavior: FloatingLabelBehavior.never),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Description field is required';
                }
              },
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)))
                          .then((selectedDate) {
                        final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
                        _dateController.text =
                            _dateFormat.format(selectedDate!);
                      });
                    },
                    controller: _dateController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(37, 43, 103, 1))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(37, 43, 103, 1))),
                        // hintText: 'Enter the description of the task',
                        labelText: 'Date',
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(37, 43, 103, 1),
                            fontWeight: FontWeight.w600),
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Date field is required';
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    onTap: () {
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((selectedTime) {
                        _timeController.text = selectedTime!.format(context);
                      });
                    },
                    controller: _timeController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(37, 43, 103, 1))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(37, 43, 103, 1))),
                        // hintText: 'Enter the description of the task',
                        labelText: 'Time',
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(37, 43, 103, 1),
                            fontWeight: FontWeight.w600),
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Time field is required';
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(37, 43, 103, 1),
                    padding: const EdgeInsets.all(20)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // send data to backend
                    // yes, I'm aware print statements shouldn't be included in production code
                    print('---Success---');
                    print(_titleController.text);
                    print(_descriptionController.text);
                    print(_dateController.text + ' ' + _timeController.text);
                  } else {
                    // validation failed
                  }
                },
                child: const Text('Create',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)))
          ]),
        ));
  }
}
