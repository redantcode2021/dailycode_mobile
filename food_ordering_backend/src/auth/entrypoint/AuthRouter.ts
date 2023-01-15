import IAuthRepository from "../domain/IAuthRepository";
import IPasswordService from "../services/IPasswordService";
import ITokenService from "../services/ITokenService";
import * as express from "express";
import AuthController from "./AuthController";
import SignInUseCase from "../usecases/SignInUseCase";
import SignUpUseCase from "../usecases/SignUpUseCase";
import {
  signinValidationRules,
  signupValidationRules,
  validate,
} from "../helpers/Validators";
import SignOutUseCase from "../usecases/SignOutUseCase";
import ITokenStore from "../services/ITokenStore";
import TokenValidator from "../helpers/TokenValidator";

export default class AuthRouter {
  public static configure(
    authRepository: IAuthRepository,
    tokenService: ITokenService,
    tokenStore: ITokenStore,
    tokenValidator: TokenValidator,
    passwordService: IPasswordService
  ): express.Router {
    const router = express.Router();
    let controller = AuthRouter.composeController(
      authRepository,
      tokenService,
      tokenStore,
      passwordService
    );
    router.post(
      "/signin",
      signinValidationRules(),
      validate,
      (req: express.Request, res: express.Response) =>
        controller.signin(req, res)
    );
    router.post(
      "/signup",
      signupValidationRules(),
      validate,
      (req: express.Request, res: express.Response) =>
        controller.signup(req, res)
    );
    router.post(
      "/signout",
      (res, req, next) => tokenValidator.validate(res, req, next),
      (req: express.Request, res: express.Response) =>
        controller.signup(req, res)
    );

    return router;
  }

  private static composeController(
    authRepository: IAuthRepository,
    tokenService: ITokenService,
    tokenStore: ITokenStore,
    passwordService: IPasswordService
  ): AuthController {
    const singinUseCase = new SignInUseCase(authRepository, passwordService);
    const signUpUseCase = new SignUpUseCase(authRepository, passwordService);
    const signOutUseCase = new SignOutUseCase(tokenStore);
    const controller = new AuthController(
      singinUseCase,
      signUpUseCase,
      signOutUseCase,
      tokenService
    );
    return controller;
  }
}
