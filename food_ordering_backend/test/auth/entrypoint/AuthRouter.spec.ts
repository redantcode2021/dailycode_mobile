import express from "express";
import BcryptPasswordService from "../../../src/auth/data/services/BcryptPasswordService";
import JwtTokenService from "../../../src/auth/data/services/JwtTokenService";
import IAuthRepository from "../../../src/auth/domain/IAuthRepository";
import AuthRouter from "../../../src/auth/entrypoint/AuthRouter";
import FakeRepository from "../helpers/FakeRepository";
import request from "supertest";
import { expect } from "chai";

describe("AuthRouter", () => {
  let repository: IAuthRepository;
  let app: express.Application;

  const user = {
    email: "test@gmail.com",
    id: "1556",
    name: "Ren",
    password: "",
    type: "google",
  };

  beforeEach(() => {
    repository = new FakeRepository();
    let tokenService = new JwtTokenService("privateKey");
    let passwordService = new BcryptPasswordService();

    app = express();
    app.use(express.json());
    app.use(express.urlencoded({ extended: true }));
    app.use(
      "/auth",
      AuthRouter.configure(repository, tokenService, passwordService)
    );
  });

  it("should return 404 when user is not found", async () => {
    await request(app).post("/auth/signin").send({}).expect(404);
  });

  it("should return 200 and token when user is found", async () => {
    await request(app)
      .post("/auth/signin")
      .send({ password: user.password, email: user.email })
      .set("Accept", "application/json")
      .expect("Content-type", /json/)
      .expect(200)
      .then((res) => {
        expect(res.body.auth_token).to.not.be.empty;
      });
  });

  it("should return errors", async () => {
    await request(app)
      .post("/auth/signup")
      .send({ email: "", password: user.password, auth_type: "email" })
      .set("Accept", "application/json")
      .expect("Content-type", /json/)
      .expect(422)
      .then((res) => {
        expect(res.body.errors).to.not.be.empty;
      });
  });

  it("should create user and return token", async () => {
    let name = "John Test";
    let email = "john_test@test.com";
    let password = "pas123";
    let type = "email";

    await request(app)
      .post("/auth/signup")
      .send({ name: name, email: email, password: password, auth_type: type })
      .set("Accept", "application/json")
      .expect("Content-type", /json/)
      .expect(200)
      .then((res) => {
        expect(res.body.auth_token).to.not.be.empty;
      });
  });
});
