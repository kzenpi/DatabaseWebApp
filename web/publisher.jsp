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
                PreparedStatement insertStatement = null;
                PreparedStatement viewStatement = null;
                ResultSet resultSet = null;

                public Publisher()
                {
                    try
                    {
                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        insertStatement = connection.prepareStatement(
                                "INSERT INTO Publisher (publisherCode, publisherName, city)"
                                + " VALUES (?, ?, ?)");
                        viewStatement = connection.prepareStatement("SELECT * FROM Publisher");
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
                        resultSet = viewStatement.executeQuery();
                    }
                    catch (SQLException e)
                    {
                        e.printStackTrace();
                    }
                    return resultSet;
                }

                public int insertPublisher(String pubCode, String pubName, String city)
                {
                    int result = 0;

                    try
                    {
                        insertStatement.setString(1, pubCode);
                        insertStatement.setString(2, pubName);
                        insertStatement.setString(3, city);
                        result = insertStatement.executeUpdate();
                    }
                    catch (SQLException e)
                    {
                        e.printStackTrace();
                    }

                    return result;
                }
            }
        %>

        <%
            Publisher publisher = new Publisher();
        %>

        <% // if the submit form is viewAll
            if (request.getParameter("submitViewAll") != null)
            {
                ResultSet publishers = publisher.getAllPublishers();%>
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
        <% } // end of if statement for view all publishers%>

        <%// Submit Data Button, fill the form
            if (request.getParameter("submitData") != null)
            {
        %>
        <form name="myForm" action="publisher.jsp" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Publisher Code : </td>
                        <td><input type="text" name="formPubCode" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Publisher Name : </td>
                        <td><input type="text" name="formPubName" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>City : </td>
                        <td><input type="text" name="formCity" value="" size="50" /></td>
                    </tr>
                </tbody>
            </table>
            <input type="reset" value="Clear" name="clear" />
            <input type="submit" value="Submit" name="submitPublisher" />
        </form>
        <% } // end of if statement, for filling the form%>

        <% // Submit Publisher button, Insert publisher into database
            if (request.getParameter("submitPublisher") != null)
            {
                int result = 0;
                String pubCode = new String();
                String pubName = new String();
                String city = new String();

                if (request.getParameter("formPubCode") != null)
                {
                    pubCode = request.getParameter("formPubCode");
                }
                if (request.getParameter("formPubName") != null)
                {
                    pubName = request.getParameter("formPubName");
                }
                if (request.getParameter("formCity") != null)
                {
                    city = request.getParameter("formCity");
                }

                result = publisher.insertPublisher(pubCode, pubName, city);
            } // end of if statement, for inserting publisher
%>
    </body>
</html>
