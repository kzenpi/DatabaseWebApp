<%-- 
    Document   : publisher
    Created on : Nov 25, 2016, 8:05:02 PM
    Author     : Nuboih
--%>

<%@page import = "java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Publisher Page</title>
    </head>
    <body>
        <%!
            public class Publisher
            {

                String URL = "jdbc:mysql://localhost:3306/test";
                String USERNAME = "root";
                String PASSWORD = "1234";

                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                public Publisher()
                {
                    try
                    {
                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        statement = connection.createStatement();
                    }
                    catch (SQLException e)
                    {
                        e.printStackTrace();
                    }
                }

                public ResultSet getAllPublishers()
                {
                    try
                    {
                        resultSet = statement.executeQuery("SELECT * FROM Publisher");
                    }
                    catch (SQLException e)
                    {
                        e.printStackTrace();
                    }
                    return resultSet;
                }
            }
        %>

        <%
            Publisher publisher = new Publisher();
            ResultSet publishers = publisher.getAllPublishers();
        %>

        <table border="1">
            <tbody>
                <tr>
                    <td>Publisher Code</td>
                    <td>Publisher Name</td>
                    <td>City</td>
                </tr>

                <% while (publishers.next())
                    {%>
                <tr>
                    <td><%= publishers.getString("publisherCode")%></td>
                    <td><%= publishers.getString("publisherName")%></td> 
                    <td><%= publishers.getString("city")%></td>
                </tr>
                <% };%>
            </tbody>
        </table>
    </body>
</html>
