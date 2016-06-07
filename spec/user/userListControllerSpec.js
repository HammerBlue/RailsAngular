describe('Controller: UserListController Test', function() {
  var userListController, mockUserService, mockLocationService, $httpBackend, scope;
  var user1 = {
    BelongsToOrganization_ID: 2,
    CanAccessTools: true,
    Disability: "None",
    FirstLoginDateTime: "2008-06-05T19:32:18.000Z",
    ID: 1,
    Individual_Contact_ID: 1,
    LoginCount: 158,
    LoginName: "JoeSmoe",
    NewestLoginDateTime: "2015-02-11T18:50:38.000Z",
    ToolScopeOrganization_ID: null,
    ToolScopeTrainingField_ID: null
  };
  var user2 = {
    BelongsToOrganization_ID: 1,
    CanAccessTools: true,
    Disability: "None",
    FirstLoginDateTime: "2010-03-02T09:30:18.000Z",
    ID: 2,
    Individual_Contact_ID: 2,
    LoginCount: 8142,
    LoginName: "JohnDoe",
    NewestLoginDateTime: "2015-12-31T19:51:27.001Z",
    ToolScopeOrganization_ID: null,
    ToolScopeTrainingField_ID: null
  };
  var user3 = {
    BelongsToOrganization_ID: 2,
    CanAccessTools: false,
    Disability: "None",
    FirstLoginDateTime: "2011-08-15T09:12:52.000Z",
    ID: 3,
    Individual_Contact_ID: 3,
    LoginCount: 19,
    LoginName: "JaneDoe",
    NewestLoginDateTime: "2016-01-04T10:31:28.000Z",
    ToolScopeOrganization_ID: null,
    ToolScopeTrainingField_ID: null
  };

  beforeEach(module('welcomeApp'));

  beforeEach(function() {
    angular.mock.inject(function ($injector) {
      $httpBackend = $injector.get('$httpBackend');
      mockUserService = $injector.get('UserService');
      mockLocationService = $injector.get('$location');
    });
  });

  beforeEach(inject(function($rootScope, $controller) {
    scope = $rootScope.$new();
    userListController = $controller('UserListController', {
      UserService: mockUserService,
      $location: mockLocationService,
      $scope: scope
    });
    $httpBackend.whenGET('/D2/api/users').respond([user1,user2,user3]);
  }));

  describe('userList', function() {
    it('should have an empty userList when the app first loads', function() {
      expect(userListController.userList.length).toBe(0);
    });

    it('should not be loading when the app first loads', function() {
      expect(userListController.loadingData).toBe(false);
    });

    it('should populate userList after calling loadUsers()', function() {
      userListController.loadUsers();
      $httpBackend.flush();
      expect(userListController.userList.length).toBe(3);
    });
  });

});
