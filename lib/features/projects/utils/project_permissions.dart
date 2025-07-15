//this to check if the user is the creator of the poject
//> if yes , he could request orders
//> if no  ,this section wont appears

class ProjectPermissions {
  static bool isVisitor(String? currentUserId, String projectOwnerId) {
    if (currentUserId == null) return true;
    return currentUserId != projectOwnerId;
  }
}
