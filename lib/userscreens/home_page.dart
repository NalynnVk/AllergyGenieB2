import 'package:calendar/userscreens/medication_page.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:calendar/userscreens/log_symptom.dart';
import 'package:calendar/userscreens/insight_page.dart';
import 'package:calendar/userscreens/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Allergy Genie'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime today = DateTime.now();
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  Map<DateTime, List<Event>> events = {};
  TextEditingController _eventController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _symptomCategoryController = TextEditingController();
  TextEditingController _severityController = TextEditingController();

  late final ValueNotifier<List<Event>> _selectedEvents;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedEvents.value = _getEventsForDay(selectedDay);
    });
  }

  List<Event> _getEventsForDay(DateTime? day) {
    return events[day ?? DateTime(2000)] ?? [];
  }

  Future<void> _openEventDetails(Event event) async {
    final updatedEvent = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailsPage(event: event),
      ),
    );

    if (updatedEvent != null) {
      _updateEvent(updatedEvent);
    }
  }

  void _createEvent() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: const Text("Symptom Details"),
          content: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextField(
                  controller: _eventController,
                  decoration: const InputDecoration(
                    labelText: 'Food and/or Medication',
                  ),
                ),
                TextField(
                  controller: _symptomCategoryController,
                  decoration: const InputDecoration(
                    labelText: 'Symptom Category',
                  ),
                ),
                TextField(
                  controller: _severityController,
                  decoration: const InputDecoration(
                    labelText: 'Severity (0-10)',
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_selectedDay != null &&
                    _eventController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty &&
                    _symptomCategoryController.text.isNotEmpty) {
                  int severityValue = 0;
                  try {
                    severityValue = int.parse(_severityController.text);
                    if (severityValue < 0 || severityValue > 10) {
                      throw const FormatException(
                          "Severity must be between 0 and 10");
                    }
                  } catch (e) {
                    print("Error parsing severity: $e");
                    return;
                  }

                  final Event newEvent = Event(
                    foodOrMedication: _eventController.text,
                    notes: _descriptionController.text,
                    severity: severityValue,
                    timestamp: DateTime.now(),
                    symptomCategory: _symptomCategoryController.text,
                  );

                  _addEvent(newEvent);
                  Navigator.of(context).pop();
                  _selectedEvents.value = _getEventsForDay(_selectedDay);
                }
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  void _addEvent(Event event) {
    setState(() {
      events[_selectedDay!] = [...(events[_selectedDay!] ?? []), event];
    });
  }

  void _updateEvent(Event updatedEvent) {
    setState(() {
      final List<Event>? dayEvents = events[_selectedDay!];
      if (dayEvents != null) {
        final index = dayEvents.indexWhere((event) =>
            event.timestamp == updatedEvent.timestamp &&
            event.foodOrMedication == updatedEvent.foodOrMedication);

        if (index != -1) {
          dayEvents[index] = updatedEvent;
          events[_selectedDay!] = dayEvents;
        }
      }
    });
  }

  void _deleteEvent(Event event) {
    print('Deleting event: ${event.foodOrMedication}'); // Debug line
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Event"),
          content: const Text("Are you sure you want to delete this event?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                print('Cancel delete'); // Debug line
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                print('Confirm delete'); // Debug line
                _removeEvent(event);
                Navigator.of(context).pop();
                _selectedEvents.value = _getEventsForDay(_selectedDay);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _removeEvent(Event event) {
    final List<Event>? dayEvents = events[_selectedDay!];
    if (dayEvents != null) {
      dayEvents.removeWhere(
        (e) =>
            e.timestamp == event.timestamp &&
            e.foodOrMedication == event.foodOrMedication,
      );
      events[_selectedDay!] = dayEvents;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          bottom: TabBar(
            tabs: const [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.medical_information), text: 'Med Info'),
              Tab(icon: Icon(Icons.insights), text: 'Insight'),
              Tab(icon: Icon(Icons.person), text: 'Profile'),
            ],
            onTap: (index) {
              setState(() {
                _currentTabIndex = index;
              });
            },
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TableCalendar(
                      calendarFormat: _calendarFormat,
                      focusedDay: _focusedDay,
                      firstDay: DateTime.utc(2000, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: _onDaySelected,
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(fontSize: 24),
                      ),
                      calendarStyle: const CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          shape: BoxShape.circle,
                        ),
                        markersMaxCount: 1,
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        weekendStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 104, 139),
                        ),
                      ),
                      eventLoader: (day) {
                        final eventsOnDay = _getEventsForDay(day);
                        return eventsOnDay.map((event) {
                          return Container(
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            width: 4,
                            height: 4,
                          );
                        }).toList();
                      },
                      onPageChanged: (focusedDay) {
                        setState(() {
                          _focusedDay = focusedDay;
                        });
                      },
                    ),
                  ),
                  ValueListenableBuilder<List<Event>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return Column(
                        children: value.map((event) {
                          return ListTile(
                            title: Text(event.foodOrMedication),
                            subtitle: Text(
                              'Severity: ${event.severity}, Symptom Category: ${event.symptomCategory}',
                            ),
                            onTap: () async {
                              await _openEventDetails(event);
                            },
                            onLongPress: () {
                              _deleteEvent(event);
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
            MedPage(),
            const InsightPage(),
            ProfilePage(),
          ],
        ),
        floatingActionButton: _currentTabIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  _createEvent();
                },
                child: const Icon(Icons.add),
              )
            : null,
        bottomNavigationBar:
            _currentTabIndex == 0 ? _buildBottomNavigationBar() : null,
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Handle emergency call action here
          },
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 255, 104, 139),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          child: const Text(
            'EMERGENCY CALL',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
