<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>드롭다운 메뉴</title>
<style>
    ul, ol, li { list-style:none; margin:0; padding:0; }
   
    ul.myMenu {}
    ul.myMenu > li { display:inline-block; width:80px; padding:5px 10px; background:#eee; border:1px solid #eee; text-align:center; position:relative; }
    ul.myMenu > li:hover { background:#fff; }
    ul.myMenu > li ul.submenu { display:none; position:absolute; top:30px; left:0; }
    ul.myMenu > li:hover ul.submenu { display:block; }
    ul.myMenu > li ul.submenu > li { display:inline-block; width:80px; padding:5px 10px; background:#eee; border:1px solid #eee; text-align:center; }
    ul.myMenu > li ul.submenu > li:hover { background:#fff; }
</style>
</head>
<body>

<div id="container">
<ul class="myMenu">
    <li class="menu1">메뉴 1</li>
    <li class="menu2">
        메뉴 2
        <ul class="menu2_s submenu">
            <li>메뉴 2-1</li>
            <li>메뉴 2-2</li>
            <li>메뉴 2-3</li>
        </ul>   
    </li>
    <li class="menu3">
        메뉴 3
        <ul class="menu3_s submenu">
            <li>메뉴 3-1</li>
            <li>메뉴 3-2</li>
            <li>메뉴 3-3</li>
        </ul>   
    </li>
    <li class="menu4">메뉴 4</li>
    <li class="menu5">메뉴 5</li>   
</ul>
</div>
</body>
</html>