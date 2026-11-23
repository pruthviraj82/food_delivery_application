package com.pru.servelet;

import java.io.IOException;

import org.json.JSONArray;
import org.json.JSONObject;

import com.pru.ai.MoodSuggestionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/moodSuggest")
public class MoodSuggestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.setStatus(401);
            res.getWriter().print(new JSONObject().put("error", "Please login first").toString());
            return;
        }

        String mood = req.getParameter("mood");
        if (mood == null || mood.isBlank()) {
            res.setStatus(400);
            res.getWriter().print(new JSONObject().put("error", "Tell me your mood first").toString());
            return;
        }
        mood = mood.replaceAll("[\\r\\n]+", " ").trim();
        if (mood.length() > 100) mood = mood.substring(0, 100);

        try {
            JSONArray suggestions = new MoodSuggestionService().suggest(mood);
            res.getWriter().print(new JSONObject().put("suggestions", suggestions).toString());
        } catch (Exception e) {
            e.printStackTrace();
            res.setStatus(502);
            res.getWriter().print(new JSONObject()
                .put("error", "AI is busy right now. Please try again in a moment.").toString());
        }
    }
}