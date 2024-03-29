import 'package:time_tracker/app/home/models/job.dart';
import 'package:time_tracker/services/api_path.dart';
import 'package:time_tracker/services/firestore_service.dart';

abstract class Database {
  Future<void> setJob(Job job);

  Stream<List<Job>> jobsStream();

  Future<void> deleteJob(Job job);
}
String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});

  final _service = FirestoreService.instance;
  final String uid;

  @override
  Future<void> setJob(Job job) async => await _service.setData(
      path: APIPath.job(uid, job.id), data: job.toMap());

  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
      path: APIPath.jobs(uid), builder: (data, documentId) => Job.fromMap(data, documentId));

  @override
  Future<void> deleteJob(Job job) async => await _service.deleteData(path: APIPath.job(uid, job.id));
}
