var outfitApp = angular.module('outfit-app', ['ngResource']).config(
    ['$httpProvider', function($httpProvider) {
    var authToken = angular.element("meta[name=\"csrf-token\"]").attr("content");
    var defaults = $httpProvider.defaults.headers;

    defaults.common["X-CSRF-TOKEN"] = authToken;
    defaults.patch = defaults.patch || {};
    defaults.patch['Content-Type'] = 'application/json';
    defaults.common['Accept'] = 'application/json';
}]);

outfitApp.factory('Outfit', ['$resource', function($resource) {
  return $resource('/outfits/:id',
     {id: '@id'},
     {update: { method: 'PATCH'}});
}]);


outfitApp.controller('OutfitCtrl', ['$scope','Outfit', function($scope, Outfit) {

    $scope.outfits= [];

    $scope.newOutfit = new Outfit();

    Outfit.query(function(outfits) {
      $scope.outfits = outfits;
    });

    $scope.saveOutfit = function () {
      $scope.newOutfit.$save(function(outfit) {
        $scope.outfits.unshift(outfit)
        $scope.newOutfit = new Outfit();
      });
    }

    $scope.deleteOutfit = function(outfit) {
      outfit.$delete(function() {
        position = $scope.outfits.indexOf(outfit);
        $scope.outfits.splice(position, 1);
      });
    }

    $scope.showOutfit = function(outfit) {
      outfit.details = true;
      // outfit.editing = false;
    }

    $scope.hideOutfit = function(outfit) {
      outfit.details = false;
    }

    $scope.editOutfit = function(outfit) {
      outfit.editing = true;
      outfit.details = false;
    }

    $scope.backOutfit = function(outfit) {
      outfit.details = true;
      outfit.editing = false;
      location.reload();
    }

    $scope.updateOutfit = function(outfit) {
      outfit.$update(function() {
        outfit.details = true;
        outfit.editing = false;
      // }, function(errors) {
      //   $scope.errors = errors.data
      });
    };

    // $scope.clearErrors = function() {
    //   $scope.errors = null;
    // }
}]);