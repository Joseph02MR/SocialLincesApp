import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_help.dart';
import 'package:flutter_application_1/models/event.dart';
import 'package:flutter_application_1/provider/flags_provider.dart';
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 10,
          color: event.color,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Titulo: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(event.title)
            ],
          ),
          Row(
            children: [
              const Text('Fecha inicio: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(event.initDate.toString())
            ],
          ),
          Row(
            children: [
              const Text('Fecha fin: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(event.endDate.toString())
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Descripción: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(event.dscEvent ?? "Sin descripción"),
                ],
              )
            ],
          ),
          Row(
            children: [
              const Text('Completado: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                event.status == 1 ? "Completado" : "Pendiente",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: event.status == 1
                        ? Colors.blueAccent
                        : Colors.redAccent),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/edit_event', arguments: event);
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
                            content: const Text('¿Deseas borrar este evento?'),
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
          ),
        ],
      ),
    );
  }
}
