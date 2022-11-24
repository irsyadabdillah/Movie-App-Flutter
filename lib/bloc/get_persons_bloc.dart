import 'package:movie_app_flutter/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../models/person_response.dart';

class PersonsBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<PersonResponse> _subject =
      BehaviorSubject<PersonResponse>();

  getPersons() async {
    PersonResponse response = await _repository.getPersons();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject => _subject;
}

final personsBloc = PersonsBloc();
