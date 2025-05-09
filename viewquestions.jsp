<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gson.JsonObject, java.util.List" %>
<%@ page import="com.google.gson.JsonArray" %>
<html>
<head>
    <title>View Questions</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <h2 class="text-center">View Questions</h2>

    <table class="table table-bordered table-hover mt-3">
        <thead class="table-dark">
            <tr>
                <th>#</th>
                <th>Question</th>
                <th>Options</th>
                <th>Correct Answer</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<JsonObject> questions = (List<JsonObject>) request.getAttribute("questions");

                if (questions == null || questions.isEmpty()) {
                    out.println("<tr><td colspan='5' class='text-center'>No questions available</td></tr>");
                } else {
                    int index = 0;
                    for (JsonObject question : questions) {
                        if (question != null) {
                            JsonArray options = question.getAsJsonArray("options");
                            int correctAnswer = question.get("correctAnswer").getAsInt();
            %>
            <tr>
                <td><%= index++ %></td>
                <td><%= question.get("question").getAsString() %></td>
                <td>
                    <ul>
                        <% for (int i = 0; i < options.size(); i++) { %>
                            <li><%= options.get(i).getAsString() %></li>
                        <% } %>
                    </ul>
                </td>
                <td><%= options.get(correctAnswer - 1).getAsString() %></td>
                <td>
                    <!-- Edit and Delete Buttons -->
                    <a href="editquestion.jsp?index=<%= index - 1 %>" class="btn btn-warning btn-sm">Edit</a>
                    <form action="ViewQuestionsServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="index" value="<%= index - 1 %>">
                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                    </form>
                </td>
            </tr>
            <%  
                        }
                    } 
                }
            %>
        </tbody>
    </table>

    <a href="Create.jsp" class="btn btn-primary">Add New Question</a>
</body>
</html>
