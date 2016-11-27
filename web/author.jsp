<%-- 
    Document   : author
    Created on : Nov 25, 2016, 8:04:30 PM
    Author     : Nuboih
--%>

<%@page import = "java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Author Page</title>
    </head>
    <body>
        <%! // Create an Author class

            public class Author
            {

                String URL = "jdbc:mysql://localhost:3306/test";
                String USERNAME = "root";
                String PASSWORD = "1234";

                Connection connection = null;
                PreparedStatement insertStatement = null;
                PreparedStatement viewStatement = null;
                ResultSet resultSet = null;

                public Author()
                {
                    try
                    {
                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        insertStatement = connection.prepareStatement(
                                "INSERT INTO Author (authorNum, authorLast, authorFirst)"
                                + " VALUES (?, ?, ?)");
                        viewStatement = connection.prepareStatement("SELECT * FROM Author");
                    }
                    catch (SQLException e)
                    {
                        e.printStackTrace();
                    }
                }

                public ResultSet getAllAuthors()
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

                public int insertAuthor(int num, String last, String first)
                {
                    int result = 0;

                    try
                    {
                        insertStatement.setInt(1, num);
                        insertStatement.setString(2, last);
                        insertStatement.setString(3, first);
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
            Author author = new Author();
        %>

        <% // if the submit form is viewAll
            if (request.getParameter("submitViewAll") != null)
            {
                ResultSet authors = author.getAllAuthors();%>
        <table border="1">
            <tbody>
                <tr>
                    <td>Author Number</td>
                    <td>Last Name</td>
                    <td>First Name</td>
                </tr>

                <% while (authors.next())
                    {%>
                <tr>
                    <td><%= authors.getInt("authorNum")%></td>
                    <td><%= authors.getString("authorLast")%></td>
                    <td><%= authors.getString("authorFirst")%></td>
                </tr>
                <% };%>
            </tbody>
        </table>
        <% }%>

        <%// if the submit form is subit data, fill the form
            if (request.getParameter("submitData") != null)
            {
        %>
        <form name="myForm" action="author.jsp" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Author Number : </td>
                        <td><input type="text" name="num" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Last Name : </td>
                        <td><input type="text" name="last" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>First Name : </td>
                        <td><input type="text" name="first" value="" size="50" /></td>
                    </tr>
                </tbody>
            </table>
            <input type="reset" value="Clear" name="clear" />
            <input type="submit" value="Submit" name="submitAuthor" />
        </form>
        <% } // end of if statement for filling the form%>

        <% // submit author
            if (request.getParameter("submitAuthor") != null)
            {
                int result = 0;
                int authorNumber = 0;
                String firstName = new String();
                String lastName = new String();

                if (request.getParameter("num") != null)
                {
                    authorNumber = Integer.parseInt(request.getParameter("num"));
                }
                if (request.getParameter("last") != null)
                {
                    lastName = request.getParameter("last");
                }
                if (request.getParameter("first") != null)
                {
                    firstName = request.getParameter("first");
                }

                result = author.insertAuthor(authorNumber, lastName, firstName);
            } // end of if statement for inserting the author
        %>

    </body>
</html>