class RegisterEvents {
  static final List<Event> _events = [];

  void register(Event event) {
    _events.add(event);
  }

  static List<Event> get events => _events;
}

class Event {
  final String name;
  final Map<String, dynamic> data;

  Event({required this.name, required this.data});
}
