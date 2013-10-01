<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="courses.alex.data.DataProvider"%>
<%@ page import="courses.alex.data.Image"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
    href="resources/styles/gallery.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script
    src="http://jashkenas.github.com/coffee-script/extras/coffee-script.js"></script>
<title>Insert title here</title>

</head>
<body>
    <%
        String galleryName = request.getAttribute("galleryName").toString();
        List<Image> images = DataProvider.getGalleryContents(galleryName);
        Iterator<Image> itImg = images.iterator();
    %>
    <div class='heading'>
        <a href='index.jsp' style='color: white;'>To home page.</a>
        <div style="display: inline;">
            <input type='button' id='editing' value='editing' class='button' />
            <input type='button' id='presentation' value='presentation'
                class='button' />
            <form action="saveGalleryData" method="post">
                <input type='submit' id='saveButton' value='SAVE' class='button' />
                <input type='text' name='galleryName' value='<%=galleryName%>' hidden='true' />
                <input type='text' id='saveArea' name='data' value='' hidden='true' />
            </form>
            <p align='center'>
                Gallery name:
                <%=galleryName%></p>
        </div>
    </div>
    <div id='setIcon' class='scrollIcon'>
        <%
            while (itImg.hasNext()) {
                Image img = itImg.next();
        %>
        <img src='<%=img.getSrc()%>' class='ui-widget-content' />
        <%
            }
        %>
    </div>
    <div id='mainImgDiv' class='imgPisplay'>
        <img id='mainImg' class='mainImg' src='<%=images.get(0).getSrc()%>' />
    </div>
    <div id='buttonsArea' align='center'>
        <input type='button' class='button' value='prev-slide' id='buttonPrev' />
        <input type='button' class='button' value='next-slide' id='buttonNext' />
    </div>
    <div id='setting'>
        Add from 'http://oboobs.ru/': <input type='button' class='button'
            value='button more' id='oboobs' /><br /> Scroll speed(in
        ms.): <input id="scrollSpeed" class="mac" type="text" value="1000"
            pattern="^[0-9]+$" /><br /> Effect:<br /> <input id='grayscale'
            type="radio" name="Effect" value="grayscale"> Grayscale<br />
        <input id='sepia' type="radio" name="Effect" value="sepia">
        Sepia<br /> <input id='none' type="radio" name="Effect" value="none"
            checked> None<br /> Contrast: <input id="contrast"
            class="mac" type="text" value="0" pattern="^[0-9]+$" /><br />
        Sharpness: <input id="sharpness" class="mac" type="text" value="0"
            pattern="^[0-9]+$" /><br /> <input id='deleteImg'
            type='button' value='Delete Image' class='button' /><br /> Moving:<br />
        <input id='blind' type="radio" name='typeHide' checked> blind<br />
        <input id='size' type="radio" name='typeHide'> size<br /> <input
            id='clip' type="radio" name='typeHide'> clip<br /> <input
            id='drop' type="radio" name='typeHide'> drop<br /> <input
            id='explode' type="radio" name='typeHide'> explode<br /> <input
            id='fold' type="radio" name='typeHide'> fold<br /> <input
            id='highlight' type="radio" name='typeHide'> highlight<br />
        <input id='puff' type="radio" name='typeHide'> puff<br /> <input
            id='pulsate' type="radio" name='typeHide'> pulsate<br /> <input
            id='scale' type="radio" name='typeHide'> scale<br />
    </div>
    <!-- <image src="test16.jpg" effect="" contrast="" sharpness="" /> -->
    <script type="text/coffeescript">

    galleryName = '<%=galleryName%>'

    class Img
        constructor: (@src, @effect, @contrast, @sharpness, @moving, @scrollSpeed) ->

    imgs = []
    <%itImg = images.iterator();
    while (itImg.hasNext()) {
        Image img = itImg.next();%>
    imgs.push new Img('<%=img.getSrc()%>',
        '<%=img.getEffect()%>',
        '<%=img.getContrast()%>',
        '<%=img.getSharpness()%>',
        '<%=img.getMoving()%>',
        '<%=img.getScrollSpeed()%>',
    )
    <%}%>

    class Gallery
        self = []
        constructor: (@imgs)->
            self = @
        getImgs: ->
            return @imgs
        swap: (firstSrc, secondSrc) ->
            firsIndex = 0
            secondIndex = 0
            i = 0
            for img in @imgs
                if img.src == firstSrc
                    firsIndex = i
                if img.src == secondSrc
                    secondIndex = i
                i += 1
            temp = @imgs[firsIndex]
            @imgs[firsIndex] = @imgs[secondIndex]
            @imgs[secondIndex] = temp
            #@imgs[firsIndex].src = secondSrc
            #@imgs[secondIndex].src = firstSrc
        delete: (src) ->            
            imgs = []
            for img in @imgs
                if img.src != src
                    imgs.push img
            @imgs = imgs
        iterator: ->
            return new IteratorImgs()
        class IteratorImgs
            @index: 0
            @max: 0
            constructor: ->
                @imgs = self.imgs
                @index = 0
                @max = (@imgs.length - 1)
            next: ->                
                if @index < @max
                    @index += 1
                src = @imgs[@index].src
                return src 
            prev: ->
                if @index > 0
                    @index -= 1
                src = @imgs[@index].src
                return src
            getCurrentImg: ->
                return @imgs[@index]

    gallery = new Gallery(imgs)
    mainImgIterator = gallery.iterator()

    getCurrentMoving = ->
        currentImg = mainImgIterator.getCurrentImg()
        moving = currentImg.moving
        if moving == ""
            return 'blind'
        return moving

    getCurrentscrollSpeed = ->
        currentImg = mainImgIterator.getCurrentImg()
        scrollSpeed = currentImg.scrollSpeed
        if scrollSpeed == ""
            return '1000'
        return scrollSpeed

    clickAllNeeded = ->
        $('#scrollSpeed').attr('value', getCurrentscrollSpeed())
        moving = "#" + getCurrentMoving()
        $(moving).click()

    setCurrentEffect = ->
        currentImg = mainImgIterator.getCurrentImg()
        currentEffect = currentImg.effect
        $('#mainImg').css('-webkit-filter', currentEffect)
        clickAllNeeded()

    setCurrentEffect()

    $('#blind').change ->
        setMoving('blind')
    $('#size').change ->
        setMoving('size')
    $('#clip').change ->
        setMoving('clip')
    $('#drop').change ->
        setMoving('drop')
    $('#explode').change ->
        setMoving('explode')
    $('#fold').change ->
        setMoving('fold')
    $('#highlight').change ->
        setMoving('highlight')
    $('#puff').change ->
        setMoving('puff')
    $('#pulsate').change ->
        setMoving('pulsate')
    $('#scale').change ->
        setMoving('scale')

    setMoving = (moving) ->
        currentImg = mainImgIterator.getCurrentImg()
        currentImg.moving = moving

    $('#buttonNext').click ->
        scrollSpeed = getCurrentscrollSpeed()
        scrollSpeed = parseInt(scrollSpeed)
        moving = getCurrentMoving()        
        src = mainImgIterator.next()
        $('#mainImg').hide(
            moving, 
            scrollSpeed,
            -> 
                $('#mainImg').attr('src', src)
                setCurrentEffect()
            ,
            );
        scrollSpeed = getCurrentscrollSpeed()
        scrollSpeed = parseInt(scrollSpeed)
        moving = getCurrentMoving()
        $('#mainImg').show(
            moving, 
            scrollSpeed,
        );

    $('#buttonPrev').click ->
        scrollSpeed = getCurrentscrollSpeed()
        scrollSpeed = parseInt(scrollSpeed)
        moving = getCurrentMoving()
        src = mainImgIterator.prev()
        $('#mainImg').hide(
            moving,
            scrollSpeed,
            -> 
                setCurrentEffect()
                $('#mainImg').attr('src', src)
        );
        scrollSpeed = getCurrentscrollSpeed()
        scrollSpeed = parseInt(scrollSpeed)
        moving = getCurrentMoving()
        $('#mainImg').show(
            moving, 
            scrollSpeed,
        );

    $('#scrollSpeed').change ->
        currentImg = mainImgIterator.getCurrentImg()
        currentImg.scrollSpeed = $(@).val()

    $("#setIcon").ready ->                
        setIcon = document.getElementById('setIcon').getElementsByTagName('img')
        for icon in setIcon
            $(icon).draggable({ revert: true });
            $(icon).droppable({
                drop: (event, ui) ->
                    swapImg(ui.draggable, $(@), gallery)
            });

    swapImg = (firs, second, gallery) ->
        firstUrl = firs.attr("src")
        secondUrl = second.attr("src")
        firs.attr("src", secondUrl)
        second.attr("src", firstUrl)
        gallery.swap(firstUrl, secondUrl)

    $('#grayscale').change ->
        #getEffect('grayscale')
        currentImg = mainImgIterator.getCurrentImg()
        currentImg.effect = 'grayscale(100%)'
        setCurrentEffect()
    $('#sepia').change ->
        #getEffect('sepia')
        currentImg = mainImgIterator.getCurrentImg()
        currentImg.effect = 'sepia(100%)'
        setCurrentEffect()
    $('#none').change ->
        #getEffect('none')
        currentImg = mainImgIterator.getCurrentImg()
        currentImg.effect = ''
        setCurrentEffect()
    $('#contrast').change ->
        val = $(@).val()
        contrast = 'contrast(' + parseInt(val) + '%)'
        currentImg = mainImgIterator.getCurrentImg()
        currentImg.effect = contrast
        setCurrentEffect()
    $('#sharpness').change ->
        val = $(@).val()
        sharpness = 'blur(' + parseInt(val) + 'px)'
        currentImg = mainImgIterator.getCurrentImg()
        currentImg.effect = sharpness
        setCurrentEffect()

    $('#deleteImg').click ->
        currentImg = mainImgIterator.getCurrentImg()
        src = currentImg.src
        gallery.delete(src)
        deleteIcon(src)
        setNextImg()
        setCurrentEffect()

    deleteIcon = (src) ->
        setIcon = document.getElementById('setIcon').getElementsByTagName('img')
        for icon in setIcon
            srcIcon = $(icon).attr('src')
            if srcIcon == src
                $(icon).remove()

    setNextImg = ->
        mainImgIterator = gallery.iterator()
        currentImg = mainImgIterator.getCurrentImg()
        src = currentImg.src
        $('#mainImg').attr('src', src)

    $('#editing').click ->
        $('#setting').show()
        $('#setIcon').show()
        $('#editing').hide()
        $('#presentation').show()
    $('#presentation').click ->
        
        $('#setting').hide()
        $('#setIcon').hide()
        $('#editing').show()
        $('#presentation').hide()

    $('#oboobs').click ->
        window.showModalDialog("oboobs.jsp", galleryName);

    $('#presentation').click()

    $('#saveButton').click ->
        imgs = gallery.getImgs()
        openingGalleryTag = "<?xml version='1.0' encoding='UTF-8'?>"
        openingGalleryTag += "<galleries><gallery name='" + galleryName + "'>"
        closingGalleryTag = "</gallery></galleries>"
        galleryXML = ""
        galleryXML += openingGalleryTag
        for img in imgs
            galleryXML += getDataImgInXml(img)
        galleryXML += closingGalleryTag
        $('#saveArea').attr('value', galleryXML)
    
    getDataImgInXml = (img) ->
        imgXml = "<image contrast=\"" + img.contrast + "\" "
        imgXml += "effect=\"" + img.effect + "\" "
        imgXml += "sharpness=\"" + img.sharpness + "\" "
        pattern = "resources/images/" + galleryName + "/"
        src = img.src
        src = src.replace(pattern,'')
        imgXml += "src=\"" + src + "\" "
        imgXml += "moving=\"" + img.moving + "\" "
        imgXml += "scrollSpeed=\"" + img.scrollSpeed + "\" />"
        return imgXml
    </script>
</body>
</html>
<!--     <gallery name="TestGallery2">
        <image contrast="" effect="" sharpness="" src="test1.jpg"
            moving="" scrollSpeed="" />
        <image contrast="" effect="" sharpness="" src="test2.jpg"
            moving="" scrollSpeed="" />
        <image contrast="" effect="" sharpness="" src="05817.jpg"
            moving="" scrollSpeed="" />
    </gallery> -->























