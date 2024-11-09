<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.json.JSONArray, org.json.JSONObject" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data List</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <table class="table table-striped">
        <thead class="thead-dark">
        <tr>
            <th scope="col">#</th>
            <th scope="col">Name</th>
            <th scope="col">Country</th>
            <th scope="col">Interest</th>
            <th scope="col">Gender</th>
            <th scope="col">Created Date</th>
            <th scope="col">Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            JSONArray jsonArray = (JSONArray) request.getAttribute("data");
            if (jsonArray != null) {
                for (int i = 0; i < jsonArray.length(); i++) {
                    JSONObject jsonObject = jsonArray.getJSONObject(i);
                    String name = jsonObject.optString("name", "No Name");
                    String country = jsonObject.optString("country", "No Country");
                    String interest = jsonObject.optString("interest", "No Interest");
                    String gender = jsonObject.optString("gender", "No Gender");
                    String createdDate = jsonObject.optString("createdAt", "No Date");
        %>
        <tr>
            <th scope="row"><%= (i + 1) %></th>
            <td><%= name %></td>
            <td><%= country %></td>
            <td><%= interest %></td>
            <td><%= gender %></td>
            <td><%= createdDate %></td>
            <td>
                <!-- Edit 버튼 -->
                <button class="btn btn-outline-primary" onclick="editRow('<%= jsonObject.optString("id", "") %>')">Edit</button>
                <!-- Delete 버튼 -->
                <button class="btn btn-outline-danger" onclick="confirmDelete('<%= jsonObject.optString("id", "") %>')">Delete</button>
            </td>
        </tr>

        <script>
            function editRow(id) {
                window.location.href = 'edit.html?id=' + encodeURIComponent(id);
            }

            function confirmDelete(id) {
                if (confirm('Are you sure you want to delete?')) {
                    window.location.href = 'delete_ok.jsp?id=' + encodeURIComponent(id);
                }
            }
        </script>


        <%
            }
        } else {
        %>
        <tr>
            <td colspan="6" class="text-center">No data available</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
