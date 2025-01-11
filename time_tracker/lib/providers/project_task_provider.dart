// Step 3: Add a provider
import 'package:flutter/foundation.dart';
import '../models/project.dart';
import '../models/task.dart';
import '../models/time_entry.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';




class TimeEntryProvider with ChangeNotifier {


  final LocalStorage storage;

  // List of TimeEntry
  List<TimeEntry> _entries = [];

  // List of Task
  List<Task> _tasks = [

    Task(id: '1', name: 'A'),
    Task(id: '2', name: 'B'),
    Task(id: '3', name: 'C'),

  ];


//   // List of Projects
  List<Project> _projects = [

    Project(id: '1', name: 'Alpha'),
    Project(id: '2', name: 'Beta'),
    Project(id: '3', name: 'Gamma'),

  ];


  // Getters
  List<TimeEntry> get entries => _entries;
  List<Task> get tasks => _tasks;
  List<Project> get projects => _projects;

//   List<Task> get entries => _entries;
//   List<Project> get entries => _entries;
//   List<TimeEntry> get time_entries => _time_entries;



  TimeEntryProvider(this.storage) {
    _loadTimeEntryFromStorage();
  }

  void _loadTimeEntryFromStorage() async {
    // await storage.ready;
    var storedTimeEntry = storage.getItem('entries');
    if (storedTimeEntry != null) {
      _entries = List<TimeEntries>.from(
        (storedTimeEntry as List).map((item) => TimeEntry.fromJson(item)),
      );
      notifyListeners();
    }
  }

// Add Time entry to storage
  void addTimeEntry(TimeEntry entry) {
    _entries.add(entry);
    _saveTimeEntryToStorage();
    notifyListeners();
  }

  // Save timeEntry to storage
  void _saveTimeEntryToStorage() {
    storage.setItem(
      'entries', jsonEncode(_entries.map((e) => e.toJson()).toList()));
  }

  // Add or Update time entry
  void addOrUpdateTimeEntry(TimeEntry entry) {
    int index = _entries.indexWhere((e) => e.id == entry.id);
    if (index != -1) {
      // Update existing entry
      _entries[index] = entry;
    } else {
      // Add new entry
      _entries.add(entry);
    }
    _saveTimeEntryToStorage(); // Save the updated list to local storage
    notifyListeners();
  }


  // Delete timeEntry
  void deleteTimeEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    _saveTimeEntryToStorage();
    notifyListeners();
  }


  // Add a task
  void addTask(Task task) {
    if (!_tasks.any((t) => t.name == task.name)) {
      _tasks.add(task);
      notifyListeners();
    }
  }

  // Delete a task
  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }


  // Add a project
  void addProject(Project project) {
    if (!_projects.any((p) => p.name == project.name)) {
      _projects.add(project);
      notifyListeners();
    }
  }

  // Delete a task
  void deleteTask(String id) {
    _projects.removeWhere((project) => project.id == id);
    notifyListeners();
  }


}
