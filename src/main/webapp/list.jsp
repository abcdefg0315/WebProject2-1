<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL" %>
<%@ page import="org.json.JSONArray" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Main Page</title>
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="top.jsp" />
<div class="container mt-5">
  <button class="btn btn-success mb-3" onclick="window.location.href='write.html'">Add</button>
  <%
    String apiUrl = "https://66ff4a592b9aac9c997ed456.mockapi.io/users";
    StringBuilder result = new StringBuilder();

    try {
      URL url = new URL(apiUrl);
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestMethod("GET");

      int responseCode = conn.getResponseCode();
      if (responseCode == HttpURLConnection.HTTP_OK) {
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        while ((inputLine = in.readLine()) != null) {
          result.append(inputLine);
        }
        in.close();

        // JSON 데이터 생성 및 view.jsp로 전달
        JSONArray jsonArray = new JSONArray(result.toString());
        request.setAttribute("data", jsonArray);
  %>

  <jsp:include page="view.jsp" />

  <%
  } else {
  %>
  <div class="alert alert-danger" role="alert">
    API 응답 에러: <%= responseCode %>
  </div>
  <%
    }
  } catch (Exception e) {
  %>
  <div class="alert alert-danger" role="alert">
    데이터 가져오기 실패: <%= e.getMessage() %>
  </div>
  <%
    }
  %>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<jsp:include page="footer.jsp" />
</body>
</html>
