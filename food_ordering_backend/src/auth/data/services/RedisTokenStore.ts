import ITokenStore from "../../services/ITokenStore";
import redis, { createClient } from "redis";
import { promisify } from "util";

export default class RedisTokenStore implements ITokenStore {
  //private readonly client = redis.createClient();
  constructor(private readonly client: ReturnType<typeof createClient>) {}
  save(token: string): void {
    this.client.set(token, token);
  }
  async get(token: string): Promise<string> {
    const getAsync = promisify(this.client.get).bind(this.client);
    const res = await getAsync(token);
    return res ?? "";
  }
}
