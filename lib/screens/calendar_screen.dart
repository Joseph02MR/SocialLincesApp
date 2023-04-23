import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_help.dart';
import 'package:flutter_application_1/models/event.dart';
import 'package:flutter_application_1/provider/flags_provider.dart';
import 'package:flutter_application_1/widgets/event_data.dart';
import 'package:flutter_application_1/widgets/event_form.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DatabaseHelper? database;
  bool view = true;
  late List<CalendarEventData> events;

  @override
  void initState() {
    super.initState();
    database = DatabaseHelper();
  }

  void event_modal() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: const FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 0.7,
                child: EventForm(),
              ));
        });
  }

  void aux(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Scaffold(
      body: FutureBuilder(
        future: flag.getFlag_eventList() == true
            ? database!.GETALLEVENTS()
            : database!.GETALLEVENTS(),
        builder: (context, AsyncSnapshot<List<Event>> snapshot) {
          if (snapshot.hasData) {
            List<CalendarEventData> events =
                Event.getEventList(snapshot.data as List<Event>);
            return CalendarControllerProvider(
              controller: EventController()..addAll(events),
              child: MaterialApp(
                home: Scaffold(
                  floatingActionButton: FloatingActionButton.extended(
                      onPressed: () {
                        event_modal();
                      },
                      label: const Text('Agregar evento'),
                      icon: const Icon(Icons.event_note_rounded)),
                  appBar: AppBar(title: const Text('Eventos'), actions: [
                    IconButton(
                      icon: view
                          ? const Icon(
                              Icons.calendar_month,
                            )
                          : const Icon(
                              Icons.event,
                            ),
                      onPressed: () {
                        view = view ? false : true;
                        setState(() {});
                      },
                    )
                  ]),
                  body: view
                      ? const MonthView()
                      : ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var event = snapshot.data![index];
                            return EventData(
                              event: event,
                            );
                          },
                        ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Error al cargar eventos")));
          } else {
            return const CircularProgressIndicator.adaptive();
          }
          throw '';
        },
      ),
    );
  }
}
