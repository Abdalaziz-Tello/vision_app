/*
? shared features :
* auth : signUpWithEmailAndPassword , signInWithEmailAndPassword , getCurrentUser
// project realated : same modle :
* get project details :
   - getProjectById
* get top 3 projects :
   - getTopCompletedProjects

?___________________________________________________________________
? Microbots features :
* get all Projects :
   - getProjects
* get resources requests :
   - getUsersResourcesRequest
* getAllTools :
   - getAllTools


?____________________________________________________________________
? user features :
* create poject :
   - uploadFile
   - getAllProjectDomains
   -createProject
* get projects by user id :
   - getProjectsByUserId
* create resource request:
   - getAllAcademics
   - getRequestedResources
   - submitResourceRequest

?__________________________________________________________________
 note : I kept the 'AuthService' separate from the 'SupabaseService'
?__________________________________________________________________






*/

//** remember:
// >Supabase Uses a Direct Client SDK,that allows to connect and interact directly:
//add:
  //  await Supabase.instance.client.from('rooms').insert([
  //                           {
  //                             'table_num': _tableNumController.text,
  //                             'table_category': _tableCategoryController.text,
  //                             'char_num': _charNumController.text,
  //                             'emty': true
  //                           }
  //                         ]);
//-------------------------------------------------------------------------------

//update :
  // await Supabase.instance.client
  //       .from('rooms')
  //       .update({'emty': emty}).eq('table_num', id);
//-------------------------------------------------------------------------------
//delete :
  // Supabase.instance.client
  //                                   .from('rooms')
  //                                   .delete()
  //                                   .eq('${table['table_num']}', table)
  //                                   .select();


/*
//flutter pub add webview_flutter
------------------------------------------------------------------
<!--Start of Tawk.to Script-->
<script type="text/javascript">
var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
(function(){
var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
s1.async=true;
s1.src='https://embed.tawk.to/686c02ebe27303190bc1358c/1iviumqrk';
s1.charset='UTF-8';
s1.setAttribute('crossorigin','*');
s0.parentNode.insertBefore(s1,s0);
})();
</script>
<!--End of Tawk.to Script-->
----------------------------------------------------------------
*/

/*



//! to ask :
- how the user went back into the homePage , if he is in the project details ?!



TODO:
-fix the exeption when choosing file !!(done)
-slove this error : 10_Another exception was thrown: Incorrect use of ParentDataWidget// already why its 10 times ?!
to save the role after get it
-extrac the button and make it the same for the hole buttons(done)
-handle no newtork will opining it //<<<can't handle this case >>>>
-! know more about this : This uses the HTML renderer instead of CanvasKit — no internet needed to load it.
-! fix the DI
-? handle if projct id in the project details page null(in the call )


TODO :
//important :
      - add search to the porjects(done)
      - make sure form the models and remove the extends<<
      - opimize the microbots page
      - make the keys of the data table in the key files<<
      - change the text of attachements if not exist and he is a vistor
____________________________________________________________
      - the logOut functionality (shall we do it ?)
      - in resources to change the changenotifier into cubit<<
      - to change this discription : "vision_platform_intro" with share <<
      - fix the attachements widgets !! (important to do this )
      - handle not to change any thing in the options when loading (project details page )
      - fix this widget "ProjectCard" <<<<<<
      - need to make the updates project details page , if the user is the creator
      - fix the ui of the projects and notification (done )




____________________________________________________________________

? done :
- complete the refactoring for the user and shared features remote layer

____________________________________________________________________

context.push(
  NavigationKeys.projectDetailsPageKey,
  extra: {
    'projectId': someId,
    'toolType': someToolType,
  },
);

_____________________________________________________
GoRoute(
  path: NavigationKeys.projectDetailsPageKey,
  pageBuilder: (context, state) {
    final extra = state.extra as Map<String, dynamic>? ?? {};
    final projectId = extra['projectId'] as String;
    final toolType = extra['toolType'] as String?;

    return CustomTransitionPage(
      key: state.pageKey,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<ProjectDetailsBloc>()),
          BlocProvider(
            create: (_) => sl<CurrentUserBloc>()..add(LoadCurrentUser()),
          ),
          BlocProvider(create: (_) => sl<ProjectAttachmentsCubit>()),
        ],
        child: ProjectDetailsPage(
          projectId: projectId,
          toolType: toolType,
        ),
      ),
      transitionsBuilder: _fadeTransition,
    );
  },
),



*/


