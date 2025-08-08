class AppKeys {
  //backend keys :
  //_______________________________________________________________________
  static const String supabaseUrl = 'https://kgyorpamyevmmjjcztwl.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtneW9ycGFteWV2bW1qamN6dHdsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk5MzQ5OTcsImV4cCI6MjA2NTUxMDk5N30.KYSWQm8SzA8dqiXfAK43U_4-xDyhKAl6YT41tD2Mrp4';
  static const String webUrl = 'http://www.tech-sauce.com/vision/';
  static const String microboostAdminKey = 'microboost_admin';
  static const String studentKey = 'student';
  static const String pending = 'pending';
  //_______________________________________________________________________

  //tables name :
  //getAllAcademics:
  static const String academicDepartmentsKey = 'academic_departments';
  //getRequestedResources:
  static const String requestedResourcesKey = 'requested_resources';
  static const String academicDepartmentIdKey = 'academic_department_id';
  //submitResourceRequest:  //getUsersResourcesRequest:
  static const String resourcesRequestKey = 'resources_request';
  //getAllProjectDomains:
  static const String projectDomainsKey = 'project_domains';
  // createProject:
  static const String createProjectKey = 'create_project';
  //upload_file :
  static const String projectattachmentsKey = 'project-attachments';
  //getProjectsByUserId :
  static const String projectsKey = 'projects';
  static const String createdByKey = 'created_by';
  //
  static const String idKey = 'id';
  //getTopCompletedProjects:
  static const String isPublicKey = 'is_public';
  static const String percentageCompletedKey = 'percentage_completed';
  //tools :
  static const String toolsKey = 'tools';
  //  static const String  = 'created_by';
}


//! shall i separate the AppKeys that responsible for the backend , form those (page navigation )?