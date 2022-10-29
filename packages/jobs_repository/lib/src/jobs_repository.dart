import 'package:geolocator/geolocator.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as Location;

/// {@template jobs_repository}
/// A repository that handles job related requests.
/// {@endtemplate}
class JobsRepository {
  /// {@macro jobs_repository}
  const JobsRepository({
    required JobsApi jobsApi,
  }) : _jobsApi = jobsApi;

  final JobsApi _jobsApi;

  /// Provides a [Stream] of all jobs.
  Stream<List<Job>> getJobs(String group) => _jobsApi.getJobs(group);

  /// Saves a [job].
  ///
  /// If a [job] with the same id already exists, it will be replaced.
  Future<void> saveJob(Job job) => _jobsApi.saveJob(job);

  /// Deletes the job with the given id.
  ///
  /// If no job with the given id exists, a [JobNotFoundException] error is
  /// thrown.
  Future<void> deleteJob(String id) => _jobsApi.deleteJob(id);

  /// Deletes all completed jobs.
  ///
  /// Returns the number of deleted jobs.
  Future<int> clearCompleted() => _jobsApi.clearCompleted();

  /// Sets the `isCompleted` state of all jobs to the given value.
  ///
  /// Returns the number of updated jobs.
  Future<int> completeAll({required bool isCompleted}) =>
      _jobsApi.completeAll(isCompleted: isCompleted);

  Future<String> getLocation() async {
    bool _serviceEnabled;
    LocationPermission permission;

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      final location = Location.Location();
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw LocationPermissionNotGrantedException(
            'Location services are permanently denied, we cannot request services.');
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionNotGrantedException(
            'Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionNotGrantedException(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final places =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final place = places[0];
    return '${place.locality}, ${place.postalCode}, ${place.country}, lat: ${position.latitude}, lon: ${position.longitude}';
  }
}
