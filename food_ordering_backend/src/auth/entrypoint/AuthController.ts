import * as express from "express";
import ITokenService from "../services/ITokenService";
import SignInUseCase from "../usecases/SignInUseCase";
import SignUpUseCase from "../usecases/SignUpUseCase";

export default class AuthController {
  private readonly signInUseCase: SignInUseCase;
  private readonly signUpUseCase: SignUpUseCase;
  private readonly tokenService: ITokenService;

  constructor(
    signInUseCase: SignInUseCase,
    signUpUseCase: SignUpUseCase,
    tokenService: ITokenService
  ) {
    this.signInUseCase = signInUseCase;
    this.signUpUseCase = signUpUseCase;
    this.tokenService = tokenService;
  }

  public async signin(req: express.Request, res: express.Response) {
    try {
      const { email, password } = req.body;
      return this.signInUseCase
        .execute(email, password)
        .then((id: string) =>
          res.status(200).json({ auth_token: this.tokenService.encode(id) })
        )
        .catch((err: Error) => res.status(404).json({ error: err.message }));
    } catch (error) {
      return res.status(400).json({ error: error });
    }
  }

  public async signup(req: express.Request, res: express.Response) {
    try {
      const { name, auth_type, email, password } = req.body;
      return this.signUpUseCase
        .execute(name, auth_type, email, password)
        .then((id: string) =>
          res.status(200).json({ auth_token: this.tokenService.encode(id) })
        )
        .catch((err: Error) => res.status(404).json({ error: err.message }));
    } catch (error) {
      return res.status(400).json({ error: error });
    }
  }
}
