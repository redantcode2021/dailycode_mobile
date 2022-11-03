import { use } from "chai";
import IAuthRepository from "../../../src/auth/domain/IAuthRepository";
import User from "../../../src/auth/domain/User";

export default class FakeRepository implements IAuthRepository {
  public users = [
    {
      email: "test@test.com",
      id: "1234",
      name: "John",
      password: "$2a$12$WnEEJmY4Z1jZqDw6xaM3qO32vBTv6Wg/AoYXvM445/uXLUqYHVPRW",
      type: "email",
    },
    {
      email: "test@gmail.com",
      id: "1556",
      name: "Ren",
      password: "",
      type: "google",
    },
  ];

  public async find(email: string): Promise<User> {
    const user = this.users.find((x) => x.email == email);

    if (!user) return Promise.reject("User not found");

    return new User(
      user?.id,
      user?.name,
      user?.email,
      user?.password,
      user?.type
    );
  }

  public async add(
    name: string,
    email: string,
    password: string,
    type: string
  ): Promise<string> {
    const max = 9999;
    const min = 1000;
    const id = (Math.floor(Math.random() * (+max - +min)) + +min).toString();

    this.users.push({
      email: email,
      id: id,
      name: name,
      password: password,
      type: type,
    });

    return id;
  }
}
