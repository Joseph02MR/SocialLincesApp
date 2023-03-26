import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_help.dart';
import 'package:flutter_application_1/models/event.dart';
import 'package:flutter_application_1/provider/flags_provider.dart';
import 'package:flutter_application_1/widgets/event_form.dart';
import 'package:provider/provider.dart';

class EventData extends StatefulWidget {
  const EventData({super.key, required this.event});
  final Event? event;

  @override
  State<EventData> createState() => _EventDataState();
  Event getevent() {
    return event!;
  }
}

class _EventDataState extends State<EventData> {
  DatabaseHelper? database;
  late Event event;
  @override
  void initState() {
    super.initState();
    event = widget.event!;
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    return Column(
      children: [
        Row(
          children: [const Text('Titulo: '), Text(event.title)],
        ),
        Row(
          children: [
            const Text('Fecha inicio: '),
            Text(event.initDate.toString())
          ],
        ),
        Row(
          children: [const Text('Fecha fin: '), Text(event.endDate.toString())],
        ),
        const Text('Descripción: '),
        Text(event.dscEvent ?? "Sin descripción"),
        Row(
          children: [
            const Text('Completado: '),
            Checkbox(
              value: event.status == 1,
              onChanged: (value) {
                event.status = value! ? 1 : 0;
              },
            )
          ],
        ),
        Row(
          children: [
            const Text('Completado: '),
            Checkbox(
              value: event.status == 1,
              onChanged: (value) {
                event.status = value! ? 1 : 0;
              },
            )
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: const FractionallySizedBox(
                                widthFactor: 0.95,
                                heightFactor: 0.6,
                                child: EventForm()));
                      });
                },
                icon: const Icon(Icons.edit)),
            IconButton(
              icon: const Icon(
                Icons.delete,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('confirmar borrado'),
                          content: const Text('¿Deseas borrar el post?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  database
                                      ?.DEL_EVENT('tblEvent', event.idEvent!)
                                      .then(
                                        (value) => flag.setFlag_postList(),
                                      );
                                  Navigator.pop(context);
                                },
                                child: const Text('Sí')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No'))
                          ],
                        ));
              },
            )
          ],
        )
      ],
    );
  }
}
