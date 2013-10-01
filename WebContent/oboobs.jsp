<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
    href="resources/styles/oboobs.css"
/>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script
	src="http://jashkenas.github.com/coffee-script/extras/coffee-script.js"></script>

<script type="text/coffeescript">
    $('#galleryName').ready ->
        #$('#galleryName').attr('name', window.dialogArguments)
        $('#galleryName').attr('value', window.dialogArguments)
        $('#galleryName').show()
    apiPrefix = 'http://api.oboobs.ru/boobs/'
    mediaPrefix = 'http://media.oboobs.ru/boobs/'
    $('#getBoobs').click ->
        $("#setBoobs").empty()
        rank = $('#rank').val()
        count = $('#count').val()
        url = apiPrefix + rank + '/' + count + '/' + 'rank/'
        $.get(url, (data) ->
            len = data.length
            for i in [0...len]
                #alert '!'
                src = data[i]['preview'].replace('boobs_preview/','')
                url = mediaPrefix + src
                #$('#setBoobs').add('img').attr('src', url)
                tag = $("<img class ='icon' src='" + url + "' />")
                imgClick(tag)
                $("#setBoobs").append(tag)
        )

    imgClick = (imgTag) ->
        $(imgTag).click -> 
            uploadImg = $('#uploadImg')
            uploadImg.show()
            imgUrl = $(@).attr('src')
            uploadImg.attr('src', imgUrl)
            $('#urlImg').attr('value', imgUrl)
            $('#urlImg').show()
            $('#loadImg').show()

</script>

</head>
<body>
    <div>
        Rank: <input type='text' id='rank' value='1' /><br />
        Count: <input type='text' id='count' value='5' /><br />
        <input type='button' id='getBoobs' value='get' /><br />        
    </div>
    <img id="uploadImg" style="height: 40px;"" alt="The image is not selected." hidden='true'>
    <form action='getUploadImgUrl' method='post' >
        Load in: <input type="text" id="galleryName" name="galleryName" value="url" readonly="true" hidden="true" >
         image <input type="text" id="urlImg" name="url" value="url" readonly="true" hidden="true" > 
        <input id="loadImg" type="submit" value="Upload" hidden="true" >
    </form>
    <div id="setBoobs"></div>
</body>
</html>