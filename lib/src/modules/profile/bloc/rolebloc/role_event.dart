
abstract class RoleEvent {}

class FetchRoles extends RoleEvent {
  final String siteId;

  FetchRoles({required this.siteId});
}