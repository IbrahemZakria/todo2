import 'package:flutter/material.dart';
import 'package:todoapp2/shared/component/UserMessage.dart';
import 'package:todoapp2/shared/component/custome_button.dart';
import 'package:todoapp2/shared/component/custome_text_form_field.dart';
import 'package:todoapp2/shared/local_data_base/sqflite.dart';

class ShowBottomSheet extends StatelessWidget {
  const ShowBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Task',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CustomeTextFormField.CustomeTextformField(
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Title must not be empty';
                }
                return null;
              },
              onSaved: (p0) {
                titleController.text = p0;
              },
              hintText: 'Task Title',
              prefixIcon: Icons.title,
              controller: titleController,
            ),
            const SizedBox(height: 20),
            CustomeTextFormField.CustomeTextformField(
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Date must not be empty';
                }
                return null;
              },
              onTap: () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2028),
                  initialDate: DateTime.now(),
                ).then((value) {
                  if (value != null) {
                    dateController.text = value.toString().substring(0, 10);
                  }
                });
              },
              hintText: 'Task Date',
              onSaved: (p0) => dateController.text = p0,

              prefixIcon: Icons.calendar_today,
              controller: dateController,
            ),
            const SizedBox(height: 20),
            CustomeTextFormField.CustomeTextformField(
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Time must not be empty';
                }
                return null;
              },
              onSaved: (p0) {
                timeController.text = p0;
              },
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  if (value != null) {
                    timeController.text = value.format(context).toString();
                  }
                });
              },
              hintText: 'Task Time',
              prefixIcon: Icons.access_time,
              controller: timeController,
            ),
            const SizedBox(height: 20),
            CustomeButton(
              textbutton: 'Add Task',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Sqflite.insertToDatabase(
                    title: titleController.text,
                    date: dateController.text,
                    time: timeController.text,
                  );

                  Navigator.pop(context);
                  Usermessage.show(
                    message: 'Task added successfully',
                    backgroundColor: Colors.green,
                  );
                } else {
                  print('Form is not valid');
                }
                // Add your task adding logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
