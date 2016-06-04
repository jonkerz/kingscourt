angular.module "KingsCourt"

.config ($routeProvider) ->
  $routeProvider
    .when "/",
      title: "Generator"
      templateUrl: "generator/index.html"
      controller: "GeneratorCtrl"

    .when "/builder",
      title: "Builder"
      templateUrl: "builder/index.html"
      controller: "BuilderCtrl"

    # "kingdoms#show"
    .when "/kingdoms/:id",
      title: "Kingdoms"
      templateUrl: "kingdoms/show.html"
      controller: "KingdomCtrl"
    .when "/kingdoms/:id/:string",
      title: "A kingdom"
      templateUrl: "kingdoms/show.html"
      controller: "KingdomCtrl"

    # "kingdoms#index"
    .when "/kingdoms",
      title: "Browse Kingdoms"
      params: view: "all_kingdoms"
      controller: "KingdomsCtrl"
      templateUrl: "kingdoms/index.html"
      reloadOnSearch: false
    .when "/my_kingdoms",
      title: "My Kingdoms"
      params: view: "my_kingdoms"
      controller: "KingdomsCtrl"
      templateUrl: "kingdoms/index.html"
      reloadOnSearch: false
    .when "/:username/kingdoms",
      title: "User Kingdoms"
      params: view: "user_kingdoms"
      controller: "KingdomsCtrl"
      templateUrl: "kingdoms/index.html"
      reloadOnSearch: false
    .when "/my_favorites",
      title: "My Favorites"
      params: view: "my_favorites"
      controller: "KingdomsCtrl"
      templateUrl: "kingdoms/index.html"
      reloadOnSearch: false
    .when "/:username/favorites",
      title: "User Favorites"
      params: view: "user_favorites"
      controller: "KingdomsCtrl"
      templateUrl: "kingdoms/index.html"
      reloadOnSearch: false


    .when "/cards",
      title: "Browse Cards"
      templateUrl: "cards/index.html"
      controller: "CardCtrl"

    .when "/import",
      title: "Import"
      templateUrl: "importer/index.html"
      controller: "ImportCtrl"

    .otherwise templateUrl: "404.html"
