import mongoose from "mongoose";
import AuthRepository from "../../../../src/auth/data/repository/AuthRepository";
import dotenv from "dotenv";
import { expect } from "chai";

dotenv.config();

describe("AuthRepository", () => {
  let client: mongoose.Mongoose;
  let sut: AuthRepository;

  beforeEach(() => {
    client = new mongoose.Mongoose();
    const connectionStr = encodeURI(process.env.TEST_DB!);
    client
      .connect(connectionStr)
      .then(() => {
        console.log("conneciton succes");
      })
      .catch((e) => {
        console.log(e);
      });

    sut = new AuthRepository(client);
  });

  afterEach(() => {
    client.disconnect();
  });

  it("should return user when email is found", async () => {
    // arrange
    const email = "mail@mail.test";
    const password = "123456";

    // act
    const result = await sut.find(email);

    // assert
    expect(result).to.not.be.empty;
  });

  it("should return user id when added to db", async () => {
    // arrange
    const user = {
      name: "John Doe",
      email: "john.doe@contoso.com",
      password: "password.1",
      type: "email",
    };

    // act
    const result = await sut.add(
      user.name,
      user.email,
      user.type,
      user.password
    );

    // assert
    expect(result).to.be.not.empty;
  });
});
