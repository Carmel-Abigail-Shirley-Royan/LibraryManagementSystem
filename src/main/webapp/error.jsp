<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Error Page</title>
</head>
<body>
    <h2>An error occurred while adding the book</h2>
    <p><strong>Error Message:</strong> <%= request.getAttribute("errorMessage") %></p>
    <p><strong>Stack Trace:</strong></p>
    <pre><%= request.getAttribute("errorStackTrace") %></pre>
</body>
</html>
