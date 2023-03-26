import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/event.dart';
import 'package:flutter_application_1/provider/flags_provider.dart';
import 'package:flutter_application_1/settings/styles_settings.dart';
import 'package:flutter_application_1/database/database_help.dart';
import 'package:provider/provider.dart';

DateTime get _now => DateTime.now();

class EventForm extends StatefulWidget {
  Event? event;

  EventForm({Key? key}) : super(key: key);

  EventForm.withData(Event this.event, {super.key});

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  DatabaseHelper? database = DatabaseHelper();

  DateTime selectedDate = DateTime(
    _now.year,
    _now.month,
    _now.day,
  );
  DateTime selectedEndDate = DateTime(_now.year, _now.month, _now.day);
  TimeOfDay initHour =
      TimeOfDay(hour: _now.add(const Duration(hours: 1)).hour, minute: 00);
  TimeOfDay endHour =
      TimeOfDay(hour: _now.add(const Duration(hours: 2)).hour, minute: 00);

  late TextEditingController date = TextEditingController(
      text: "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}");
  late TextEditingController date2 = TextEditingController(
      text:
          "${selectedEndDate.year}-${selectedEndDate.month}-${selectedEndDate.day}");
  late TextEditingController time =
      TextEditingController(text: initHour.format(context));
  late TextEditingController time2 =
      TextEditingController(text: endHour.format(context));
  TextEditingController title = TextEditingController(text: "Evento nuevo");
  TextEditingController desc = TextEditingController(text: "Cumpleaños...");
  bool simpleDate = true;

  late Event created;

  Future<void> _selectInitDate(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null &&
        (picked.day >= _now.day ||
            picked.month >= _now.month ||
            picked.year >= _now.year)) {
      setState(() {
        if (simpleDate) {
          selectedDate = DateTime(
              picked.year, picked.month, picked.day, _now.hour, _now.minute);
        } else {
          selectedDate = DateTime(picked.year, picked.month, picked.day);
        }
        date.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectEndDate(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedEndDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null &&
        (picked.day >= selectedDate.day ||
            picked.month >= selectedDate.month ||
            picked.year >= selectedDate.year)) {
      setState(() {
        selectedEndDate = DateTime(picked.year, picked.month, picked.day);
        date2.text = "${selectedEndDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectHour(BuildContext context) async {
    final TimeOfDay? picked2 = await showTimePicker(
      context: context,
      initialTime: initHour,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked2 != null &&
        (picked2.minute > TimeOfDay.now().minute ||
            picked2.hour > TimeOfDay.now().hour)) {
      setState(() {
        //initHour = TimeOfDay(hour: picked2.hour, minute: picked2.minute);
        //time.text = initHour.format(context);
        selectedDate = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, picked2.hour, picked2.minute);
        time.text = TimeOfDay.fromDateTime(selectedDate).format(context);
      });
    }
  }

  Future<void> _selectEndHour(BuildContext context) async {
    final TimeOfDay? picked2 = await showTimePicker(
      context: context,
      initialTime: endHour,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked2 != null &&
        (picked2.minute > initHour.minute || picked2.hour > initHour.hour)) {
      setState(() {
        //endHour = TimeOfDay(hour: picked2.hour, minute: picked2.minute);
        //time2.text = endHour.format(context);
        selectedEndDate = DateTime(selectedEndDate.year, selectedEndDate.month,
            selectedEndDate.day, picked2.hour, picked2.minute);
        time2.text = TimeOfDay.fromDateTime(selectedEndDate).format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: const FractionallySizedBox(
                widthFactor: 0.95,
                heightFactor: 0.6,
                child:
                    Padding(padding: EdgeInsets.all(12.0), child: EventForm()),
              ));
        });
    return ListView(
      children: <Widget>[
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nuevo evento',
              style: TextStyle(
                color: darkGrey,
                fontSize: 20,
              ),
            ),
            CloseButton()
          ],
        ),
        TextField(
          controller: title,
          readOnly: false,
          decoration:
              const InputDecoration(constraints: BoxConstraints(maxWidth: 180)),
        ),
        const SizedBox(
          height: 20.0,
        ),
        const Text(
          "Fecha del evento",
          style: TextStyle(
            color: darkGrey,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            const Text(
              "Todo el día: ",
              style: TextStyle(
                color: darkGrey,
                fontSize: 15,
              ),
            ),
            Switch(
                value: simpleDate,
                activeColor: Colors.green,
                onChanged: (bool value) {
                  setState(() {
                    simpleDate = value;
                  });
                })
          ],
        ),
        Row(
          children: [
            TextField(
              controller: date,
              readOnly: true,
              decoration: const InputDecoration(
                  constraints: BoxConstraints(maxWidth: 150)),
              style: const TextStyle(
                fontSize: 15.0,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.calendar_month,
              ),
              onPressed: () {
                _selectInitDate(context);
              },
            ),
          ],
        ),
        !simpleDate
            ? Column(
                children: [
                  Row(
                    children: [
                      TextField(
                        controller: time,
                        readOnly: true,
                        decoration: const InputDecoration(
                            constraints: BoxConstraints(maxWidth: 150)),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.timer,
                        ),
                        onPressed: () {
                          _selectHour(context);
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextField(
                        controller: date2,
                        readOnly: true,
                        decoration: const InputDecoration(
                            constraints: BoxConstraints(maxWidth: 150)),
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.calendar_month,
                        ),
                        onPressed: () {
                          _selectEndDate(context);
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextField(
                        controller: time2,
                        readOnly: true,
                        decoration: const InputDecoration(
                            constraints: BoxConstraints(maxWidth: 150)),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.timer,
                        ),
                        onPressed: () {
                          _selectEndHour(context);
                        },
                      ),
                    ],
                  ),
                ],
              )
            : const SizedBox(
                height: 1.0,
              ),
        const SizedBox(
          height: 20.0,
        ),
        const Text(
          "Descripción del evento",
          style: TextStyle(
            color: darkGrey,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextField(
          controller: desc,
          readOnly: false,
          decoration: const InputDecoration(
              constraints: BoxConstraints(maxWidth: 180, minHeight: 60)),
        ),
        ElevatedButton(
          onPressed: () => {
            created = Event(
                title: title.text,
                initDate: selectedDate,
                endDate: simpleDate
                    ? DateTime(selectedDate.year, selectedDate.month,
                        selectedDate.day, 23, 59, 59)
                    : selectedEndDate,
                status: 0),
            database?.INSERT('tblEvent', {
              'title': created.title,
              'dscEvent': created.dscEvent,
              'initDate': created.initDate.toIso8601String(),
              'endDate': created.endDate.toIso8601String(),
              'status': 0
            }).then((value) {
              var msg = value > 0 ? 'Evento guardado' : 'Error';
              var snackBar = SnackBar(content: Text(msg));
              flag.setFlag_eventList();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            })
          },
          child: const Text('Guardar'),
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
