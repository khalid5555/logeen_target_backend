import 'package:logeen_target_backend/app/http/controllers/user_controller.dart';
import 'package:logeen_target_backend/app/http/middleware/authenticate.dart';
import 'package:vania/vania.dart';

import '../app/http/controllers/client_controller.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    //! ============== userController api =================
    Router.group(() {
      Router.post("/create", userController.createUser);
      Router.get("/get", userController.getUsers);
      Router.get('/getById/{id}', userController.getUserById);
      Router.post('/update/{id}', userController.updateUser);
      Router.delete("/delete/{id}", userController.deleteUser);
    }, prefix: 'users');

    //! ============== clientController api =================
    Router.group(() {
      Router.post("/create", clientController.createClient);
      Router.get("/get", clientController.getClient);
      Router.get('/getById/{id}', clientController.getClientById);
      Router.post('/update/{id}', clientController.updateClient);
      Router.delete("/delete/{id}", clientController.deleteClient);
    }, prefix: 'clients');

    // Return Authenticated user data
    Router.get("/user", () {
      return Response.json(Auth().user());
    }).middleware([AuthenticateMiddleware()]);
  }
}
