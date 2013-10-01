<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="courses.alex.data.DataProvider"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<html>
<head>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script
    src="http://jashkenas.github.com/coffee-script/extras/coffee-script.js">
    
</script>
<link rel="stylesheet" type="text/css" href="resources/styles/main.css" />
</head>
<body>
    <div class='heading'>
        <h2 align="center">Greeting! It's Simple CoffeScript
            Presentation.</h2>
        <p>
            Now is:
            <%=new java.util.Date()%>
        </p>
    </div>
    <%
        List<String> galleryNames = DataProvider.GetNamesOfGalleries();
        Iterator<String> itGN = galleryNames.iterator();
    %>
    <div id="select-gallery" class='decorMidle'>
        <p>Load gallery:</p>
        <%
            while (itGN.hasNext()) {
                String name = itGN.next();
        %>
        <form action='getGalleryContents' method='post'>
            &bull;&nbsp;&nbsp;<input type='submit' value='<%=name%>'
                name='galleryName' class='modern' />
        </form>
        <%
            }
        %>

    </div>
</body>
</html>