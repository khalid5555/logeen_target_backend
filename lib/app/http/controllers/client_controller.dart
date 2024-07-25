import 'dart:io';

import 'package:vania/src/exception/validation_exception.dart';
import 'package:vania/vania.dart';

import '../../../model_backend/client_model.dart';
import '../../models/client.dart';

class ClientController extends Controller {
  Future<Response> createClient(Request request) async {
    final name = request.input('name');
    final phone = request.input('phone').toString();
    final description = request.input('description');
    final city = request.input('city');
    final category = request.input('category');
    final employeeId = request.input('employeeId').toString();
    try {
      request.validate({
        'name': 'required|string',
        'phone': 'required|string',
        'category': 'required',
      }, {
        'name.required': 'Name is required',
        'phone.required': 'Phone is required',
        'category.required': 'Category is required'
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
      var client = await Client().query().where('phone', '=', phone).first();
      if (client != null) {
        return Response.json(
          {'msg': 'client already exist !!👍'},
          HttpStatus.conflict,
        );
      }
      ClientModel clientModel = ClientModel(
        name: name,
        phone: phone,
        description: description,
        category: category,
        employeeId: employeeId,
        city: city,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await Client().query().insert(clientModel.toJson());
      return Response.json(
        {'msg': 'create Client success 👍'},
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

  Future<Response> getClient(Request request) async {
    var client = await Client().query().get();

    return Response.json(
      {
        "data": client,
        "count": client.length,
      },
      HttpStatus.ok,
    );
  }

  Future<Response> getClientById(int id) async {
    var client = await Client().query().find(id);
    if (client != null) {
      return Response.json(
        {
          "data": client,
        },
        HttpStatus.ok,
      );
    }
    return Response.json(
      {
        "data": 'this client id is not found',
      },
      HttpStatus.notFound,
    );
  }

  Future<Response> updateClient(Request request, int id) async {
    final name = request.input('name');
    final phone = request.input('phone').toString();
    final description = request.input('description');
    final city = request.input('city');
    final category = request.input('category');
    try {
      request.validate({
        'name': 'required|string',
        'phone': 'required',
        'category': 'required',
      }, {
        'name.required': 'Name is required',
        'phone.required': 'Phone is required',
        'category.required': 'Category is required'
      });
      var client = await Client().query().where("id", '=', id).first();
      if (client != null) {
        try {
          ClientModel clientModel = ClientModel(
            id: client['id'],
            name: name,
            phone: phone,
            description: description,
            category: category,
            city: city,
            employeeId: client['employeeId'],
            createdAt: DateTime.tryParse(client['created_at']),
            updatedAt: DateTime.now(),
          );
          await Client()
              .query()
              .where("id", '=', id)
              .update(clientModel.toJson());

          return Response.json(
            {'msg': 'update Client success !👍'},
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
          "data": 'this Client id is not found',
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

  Future<Response> deleteClient(int id) async {
    var client = await Client().query().find(id);
    if (client != null) {
      await Client().query().delete(id);
      return Response.json(
        {
          "data": 'this Client id (${client['id']}) is deleted success',
        },
        HttpStatus.ok,
      );
    }
    return Response.json(
      {
        "data": 'this Client id is not found',
      },
      HttpStatus.notFound,
    );
  }
}

final ClientController clientController = ClientController();
