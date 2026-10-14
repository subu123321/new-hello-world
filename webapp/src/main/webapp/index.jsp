<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.Greeter" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<%
  String today = LocalDate.now()
      .format(DateTimeFormatter.ofPattern("dd-MMMM-yyyy", Locale.ENGLISH))
      .toUpperCase(Locale.ENGLISH);
  String greeting = new Greeter().greet("K21 Academy");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Jenkins Docker DevOps Demo</title>
</head>
<body>
  <h1><%= greeting %> Welcome to K21 Academy Subramani's Jenkins Docker DevOps Demo !!</h1>
  <h2>Please subscribe to K21 Academy Channel
    <a href="https://www.youtube.com/user/k21technologies">https://www.youtube.com/user/k21technologies</a></h2>
  <h2>Thanks for following us on
    <a href="https://k21academy.com/my-courses/">https://k21academy.com/my-courses/</a></h2>
  <h1>THIS IS THE DEMO OF JENKINS WITH GITHUB AND TOMCAT SERVER IN THIS PARTICULAR DEMO</h1>
  <h2>TODAY'S DATE IS <%= today %></h2>
</body>
</html>
