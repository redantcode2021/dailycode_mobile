import "mocha";
import "chai";
import chai, { expect } from "chai";
import SignInUseCase from "../../../src/auth/usecases/SignInUseCase";
import IAuthRepository from "../../../src/auth/domain/IAuthRepository";
import IPasswordService from "../../../src/auth/services/IPasswordService";
import FakeRepository from "../helpers/FakeRepository";
import FakePasswordService from "../helpers/FakePasswordService";
import chaiAsPromised from "chai-as-promised";
import { it } from "mocha";

chai.use(chaiAsPromised);

describe("SignInUseCase", () => {
  let sut: SignInUseCase;
  let repository: IAuthRepository;
  let passwordService: IPasswordService;

  const user = {
    email: "test@test.com",
    id: "1234",
    name: "John",
    password: "$2a$12$WnEEJmY4Z1jZqDw6xaM3qO32vBTv6Wg/AoYXvM445/uXLUqYHVPRW",
    type: "email",
  };

  beforeEach(() => {
    repository = new FakeRepository();
    passwordService = new FakePasswordService();
    sut = new SignInUseCase(repository, passwordService);
  });

  it("should throw error when user is not found", async () => {
    const user = {
      email: "wrongemail@email.com",
      password: "1234",
    };

    // assert
    await expect(sut.execute(user.email, user.password)).to.be.rejectedWith(
      "User not found"
    );
  });

  it("should return user id when email and password is correct", async () => {
    // act
    const id = await sut.execute(user.email, user.password);

    // assert
    expect(id).to.be.equal(user.id);
  });

  it("should return user id when email is correct and type is not email", async () => {
    // act
    const id = await sut.execute(user.email, "");

    // assert
    expect(id).to.be.equal(user.id);
  });
});
