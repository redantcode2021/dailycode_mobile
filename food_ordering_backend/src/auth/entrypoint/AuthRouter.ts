import IAuthRepository from "../domain/IAuthRepository";
import IPasswordService from "../services/IPasswordService";
import ITokenService from "../services/ITokenService";
import * as express from "express";
import AuthController from "./AuthController";
import SignInUseCase from "../usecases/SignInUseCase";
import SignUpUseCase from "../usecases/SignUpUseCase";
import { signupValidationRules, validate } from "../helpers/Validators";

export default class AuthRouter {
  public static configure(
    authRepository: IAuthRepository,
    tokenService: ITokenService,
    passwordService: IPasswordService
  ): express.Router {
    const router = express.Router();
    let controller = AuthRouter.composeController(
      authRepository,
      tokenService,
      passwordService
    );
    router.post("/signin", (req, res) => controller.signin(req, res));
    router.post(
      "/signup",
      signupValidationRules(),
      validate,
      (req: express.Request, res: express.Response) =>
        controller.signup(req, res)
    );
    return router;
  }

  private static composeController(
    authRepository: IAuthRepository,
    tokenService: ITokenService,
    passwordService: IPasswordService
  ): AuthController {
    const singinUseCase = new SignInUseCase(authRepository, passwordService);
    const signUpUseCase = new SignUpUseCase(authRepository, passwordService);
    const controller = new AuthController(
      singinUseCase,
      signUpUseCase,
      tokenService
    );
    return controller;
  }
}
