<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>드롭다운 메뉴</title>
<style>
#menu2 {
   border-left: 10px solidblack;
}

#menu2 a {
   display: block;
   color: #fff;
}

.M01 {
   margin-left: 20px;
   width: 100px;
   background: #000;
}

.M01>li, .M02>li, .M03>li {
   position: relative;
   width: 100%; height : 50px;
   background: #000;
   text-align: center;
   line-height: 50px;
}

.M01>li:hover .M02 {
   left: 100px;
}

.M01>li a:hover {
   display: block;
   background: #AB06AD;
}

.M02, .M03 {
   width: 100px;
   background: black;
   position: absolute; top : 0;
   left: -9999px;
}

.M02>li:hover .M03 {
   left: 100px;
}

.M02>li a:hover {
   display: block;
   background: red;
}

.M03>li a:hover {
   display: block;
   background: blue;
}
</style>
</head>
<body>
   <div id="menu2">
      <ul class="M01">
         <li><a href="#">대메뉴1</a>
            <ul class="M02">
               <li><a href="#">소메뉴1</a>                   
                  <ul class="M03">
                     <li><a href="#">2단소메뉴1</a></li>
                     <li><a href="#">2단소메뉴2</a></li>
                     <li><a href="#">2단소메뉴3</a></li>
                  </ul></li>
               <li><a href="#">소메뉴2</a>                   
                  <ul class="M03">
                     <li><a href="#">2단소메뉴1</a></li>
                     <li><a href="#">2단소메뉴2</a></li>
                     <li><a href="#">2단소메뉴3</a></li>
                  </ul></li>
               <li><a href="#">소메뉴3</a>                   
                  <ul class="M03">
                     <li><a href="#">2단소메뉴1</a></li>
                     <li><a href="#">2단소메뉴2</a></li>
                     <li><a href="#">2단소메뉴3</a></li>
                  </ul></li>
            </ul>  </li>
         <li><a href="#">대메뉴2</a>           
            <ul class="M02">
               <li><a href="#">소메뉴1</a>                   
                  <ul class="M03">
                     <li><a href="#">2단소메뉴1</a></li>
                     <li><a href="#">2단소메뉴2</a></li>
                     <li><a href="#">2단소메뉴3</a></li>
                  </ul>  </li>
               <li><a href="#">소메뉴2</a>                   
                  <ul class="M03">
                     <li><a href="#">2단소메뉴1</a></li>
                     <li><a href="#">2단소메뉴2</a></li>
                     <li><a href="#">2단소메뉴3</a></li>
                     <li><a href="#">2단소메뉴1</a></li>
                     <li><a href="#">2단소메뉴2</a></li>
                     <li><a href="#">2단소메뉴3</a></li>
                  </ul>               </li>
               <li><a href="#">소메뉴3</a>                   
                  <ul class="M03">
                     <li><a href="#">2단소메뉴1</a></li>
                     <li><a href="#">2단소메뉴2</a></li>
                     <li><a href="#">2단소메뉴3</a></li>
                  </ul>  </li>
            </ul></li>
         <li><a href="#">대메뉴3</a>           
            <ul class="M02">
               <li><a href="#">소메뉴1</a>                   
                  <ul class="M03">
                     <li><a href="#">2단소메뉴1</a></li>
                     <li><a href="#">2단소메뉴2</a></li>
                     <li><a href="#">2단소메뉴3</a></li>
                  </ul></li>
               <li><a href="#">소메뉴2</a>                   
                  <ul class="M03">
                     <li><a href="#">2단소메뉴1</a></li>
                     <li><a href="#">2단소메뉴2</a></li>
                     <li><a href="#">2단소메뉴3</a></li>
                  </ul></li>
               <li><a href="#">소메뉴3</a>                   
                  <ul class="M03">
                     <li><a href="#">2단소메뉴1</a></li>
                     <li><a href="#">2단소메뉴2</a></li>
                     <li><a href="#">2단소메뉴3</a></li>
                  </ul>  </li>
            </ul></li>
         <li><a href="#">대메뉴4</a>           
            <ul class="M02">
               <li><a href="#">소메뉴1</a>                   
                  <ul class="M03">
                     <li><a href="#">2단소메뉴1</a></li>
                     <li><a href="#">2단소메뉴2</a></li>
                     <li><a href="#">2단소메뉴3</a></li>
                  </ul>  </li>
               <li><a href="#">소메뉴2</a>                   
                  <ul class="M03">
                     <li><a href="#">2단소메뉴1</a></li>
                     <li><a href="#">2단소메뉴2</a></li>
                     <li><a href="#">2단소메뉴3</a></li>
                  </ul></li>
               <li><a href="#">소메뉴3</a>                   
                  <ul class="M03">
                     <li><a href="#">2단소메뉴1</a></li>
                     <li><a href="#">2단소메뉴2</a></li>
                     <li><a href="#">2단소메뉴3</a></li>
                  </ul></li>
            </ul>  </li>
      </ul>
   </div>
</body>
</html>