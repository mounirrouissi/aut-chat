import axios from "axios";

const api = axios.create({
  baseURL: "http://localhost:8080",
  timeout: 10000,
});

export async function parseScript(script: string) {
  const res = await api.post("/api/parse", script, {
    headers: { "Content-Type": "text/plain" },
  });
  return res.data;
}


export default api;