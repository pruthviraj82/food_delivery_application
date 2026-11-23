package com.pru.ai;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

import org.json.JSONArray;
import org.json.JSONObject;

public class LLMClient {

    private static final String URL = "https://openrouter.ai/api/v1/chat/completions";
    private static final HttpClient HTTP = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(10)).build();

    public static String chat(String systemPrompt, String userPrompt) throws Exception {
        String apiKey = System.getenv("OPENROUTER_API_KEY");
        if (apiKey == null || apiKey.isBlank()) {
            throw new IllegalStateException("OPENROUTER_API_KEY is not set");
        }
        String model = System.getenv().getOrDefault("OPENROUTER_MODEL", "openrouter/free");

        JSONObject body = new JSONObject()
                .put("model", model)
                .put("temperature", 0.7)
                .put("max_tokens", 800)
                .put("messages", new JSONArray()
                        .put(new JSONObject().put("role", "system").put("content", systemPrompt))
                        .put(new JSONObject().put("role", "user").put("content", userPrompt)));

        HttpRequest req = HttpRequest.newBuilder(URI.create(URL))
                .timeout(Duration.ofSeconds(30))
                .header("Authorization", "Bearer " + apiKey)
                .header("Content-Type", "application/json")
                .header("X-Title", "Tomor")
                .POST(HttpRequest.BodyPublishers.ofString(body.toString()))
                .build();

        Exception last = null;
        for (int attempt = 1; attempt <= 2; attempt++) {      // one retry (free models are flaky)
            try {
                HttpResponse<String> res = HTTP.send(req, HttpResponse.BodyHandlers.ofString());
                if (res.statusCode() == 200) {
                    JSONObject json = new JSONObject(res.body());
                    String content = json.getJSONArray("choices").getJSONObject(0)
                            .getJSONObject("message").optString("content", "");
                    if (!content.isBlank()) return content;
                    last = new RuntimeException("Empty response from model");
                } else {
                    last = new RuntimeException("LLM HTTP " + res.statusCode() + ": " + res.body());
                }
            } catch (Exception e) {
                last = e;
            }
            Thread.sleep(1500);
        }
        throw last;
    }
}