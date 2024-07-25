import 'dart:io';

import 'package:logeen_target_backend/app/models/user.dart';
import 'package:logeen_target_backend/model_backend/user_model.dart';
import 'package:vania/src/exception/validation_exception.dart';
import 'package:vania/vania.dart';

class UserController extends Controller {
  Future<Response> createUser(Request request) async {
    final name = request.input('name');
    final email = request.input('email');
    var password = request.input('password').toString();
    try {
      request.validate({
        'name': 'required|string',
        'email': 'required|email',
        'password': 'required',
      }, {
        'name.required': 'Name is required',
        'name.string': 'Name must be a string',
        'email.required': 'Email is required',
        'email.email': 'Invalid email format'
      });
    } catch (e) {
      if (e is ValidationException) {
        var errorMsg = e.message;
        print(errorMsg);
        return Response.json(
          {
            'msg': errorMsg,
          },
          HttpStatus.unauthorized,
        );
      } else {
        return Response.json(
          {
            'msg': 'Error in the serve !!!',
          },
          HttpStatus.internalServerError,
        );
      }
    }
    try {
      var user = await User().query().where('email', '=', email).first();
      if (user != null) {
        return Response.json(
          {'msg': 'user already exist !!👍'},
          HttpStatus.conflict,
        );
      }
      password = Hash().make(password);
      UserModel userModel = UserModel(
        name: name,
        email: email,
        password: password,
        createdAt: DateTime.now().toString(),
      );
      await User().query().insert(userModel.toJson());
      return Response.json(
        {'msg': 'create user success !!👍'},
        HttpStatus.ok,
      );
    } catch (e) {
      print('Error in the serve !!! \n$e');
      return Response.json(
        {
          'msg': 'Error in the serve !!! $e',
        },
        HttpStatus.internalServerError,
      );
    }
  }

  Future<Response> getUsers(Request request) async {
    var user = await User().query().get();

    return Response.json(
      {
        "data": user,
        "count": user.length,
      },
      HttpStatus.ok,
    );
  }

  Future<Response> getUserById(int id) async {
    var user = await User().query().find(id);
    if (user != null) {
      return Response.json(
        {
          "data": user,
        },
        HttpStatus.ok,
      );
    }
    return Response.json(
      {
        "data": 'this user id is not found',
      },
      HttpStatus.notFound,
    );
  }

  Future<Response> updateUser(Request request, int id) async {
    final name = request.input('name');
    final email = request.input('email');
    try {
      request.validate({
        'name': 'required|string|alpha',
        'email': 'required|email',
      }, {
        'name.required': 'Name is required',
        'name.string': 'Name must be a string',
        'email.required': 'Email is required',
        'email.email': 'Invalid email format'
      });
      var user = await User().query().where("id", '=', id).first();
      if (user != null) {
        try {
          UserModel userModel = UserModel(
            id: user['id'],
            name: name,
            email: email,
            password: user['password'],
            createdAt: user['created_at'],
          );
          await User().query().where("id", '=', id).update(userModel.toJson());

          return Response.json(
            {'msg': 'update user success !👍'},
            HttpStatus.ok,
          );
        } catch (e) {
          print('Error in the serve !!! \n$e');
          return Response.json(
            {
              'msg': 'Error in the serve !!! $e',
            },
            HttpStatus.internalServerError,
          );
        }
      }
      return Response.json(
        {
          "data": 'this user id is not found',
        },
        HttpStatus.notFound,
      );
    } catch (e) {
      if (e is ValidationException) {
        var errorMsg = e.message;
        print(errorMsg);
        return Response.json(
          {
            'msg': errorMsg,
          },
          HttpStatus.badRequest,
        );
      } else {
        return Response.json(
          {
            'msg': 'Error in the serve !!!',
          },
          HttpStatus.internalServerError,
        );
      }
    }
  }

  Future<Response> deleteUser(int id) async {
    var user = await User().query().find(id);
    if (user != null) {
      await User().query().delete(id);
      return Response.json(
        {
          "data": 'this user id (${user['id']}) is deleted success',
        },
        HttpStatus.ok,
      );
    }
    return Response.json(
      {
        "data": 'this user id is not found',
      },
      HttpStatus.notFound,
    );
  }
}

final UserController userController = UserController();
