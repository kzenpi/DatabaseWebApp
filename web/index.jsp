
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Henry Book Manager</title>
    </head>
    <body>
        <h1>Add</h1>
        <form method="get" name="addData" action="this_value_should_change">
            <fieldset>
                <input type="radio" id="addAuthor" name="addData" onclick="document.addData.action = 'author.jsp';" />
                <label for="addAuthor">Author</label>
                <input type="radio" id="addBook" name="addData" onclick="document.addData.action = 'book.jsp';" />
                <label for="addBook">Book</label>
            </fieldset>
            <fieldset>
                <input type="radio" id="addPublisher" name="addData" onclick="document.addData.action = 'publisher.jsp';" />
                <label for="addPublisher">Publisher</label>
                <input type="radio" id="addCopy" name="addData" onclick="document.addData.action = 'copy.jsp';" />
                <label for="addCopy">Copy</label>
            </fieldset>
            <input type="submit" name="submitData" value="Submit" />
        </form>

        <h1>Delete</h1>
        <form method="get" name="deleteData" action="this_value_should_change">
            <fieldset>
                <input type="radio" id="deleteAuthor" name="deleteData" onclick="document.deleteData.action = 'author.jsp';" />
                <label for="deleteAuthor">Author</label>
                <input type="radio" id="deleteBook" name="deleteData" onclick="document.deleteData.action = 'book.jsp';" />
                <label for="deleteBook">Book</label>
            </fieldset>
            <fieldset>
                <input type="radio" id="deletePublisher" name="deleteData" onclick="document.deleteData.action = 'publisher.jsp';" />
                <label for="deletePublisher">Publisher</label>
                <input type="radio" id="deleteCopy" name="deleteData" onclick="document.deleteData.action = 'copy.jsp';" />
                <label for="deleteCopy">Copy</label>
            </fieldset>
            <input type="submit" name="submitDelete" value="Submit" />
        </form>

        <h1>View All!</h1>
        <form method="get" name="viewAll" action="this_value_should_change">
            <fieldset>
                <input type="radio" id="radAuthors" name="viewAll" onclick="document.viewAll.action = 'author.jsp';" />
                <label for="radAuthors">View All Authors</label>
                <input type="radio" id="radBooks" name="viewAll" onclick="document.viewAll.action = 'book.jsp';" />
                <label for="radBooks">View All Books</label>
                <input type="radio" id="radWrote" name="viewAll" onclick="document.viewAll.action = 'wrote.jsp';" />
                <label for="radWrote">View All Wrote</label>
            </fieldset>
            <fieldset>
                <input type="radio" id="radBranches" name="viewAll" onclick="document.viewAll.action = 'branch.jsp';" />
                <label for="radBranches">View All Branches</label>
                <input type="radio" id="radCopies" name="viewAll" onclick="document.viewAll.action = 'copy.jsp';" />
                <label for="radCopies">View All Copies</label>
                <input type="radio" id="radPublishers" name="viewAll" onclick="document.viewAll.action = 'publisher.jsp';" />
                <label for="radPublishers">View All Publishers</label>
            </fieldset>
            <input type="submit" name="submitViewAll" value="Submit" />
        </form>
    </body>
</html>