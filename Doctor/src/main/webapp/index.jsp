<%@page import="ma.youcode.doctor.entity.Date"%>
<%@page import="ma.youcode.doctor.dao.impl.DateDaoImpl"%>
<%@page import="org.hibernate.query.sqm.tree.expression.SqmRestrictedSubQueryExpression"%>
<%@page import="java.util.List"%>
<%@page import="ma.youcode.doctor.dao.impl.CommentDaoImpl"%>
<%@page import="ma.youcode.doctor.entity.Comment"%>
<%@ page language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<!DOCTYPE html>
<html>
   <title>Doctor</title>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
   <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
   <link rel="stylesheet" href="./css/home.css">
   <body class="w3-black">
      <!-- Icon Bar (Sidebar - hidden on small screens) -->
      <nav class="w3-sidebar w3-bar-block w3-small w3-hide-small w3-center">
         <a href="#" class="w3-bar-item w3-button w3-padding-large w3-black">
            <i class="fa fa-home w3-xxlarge"></i>
            <p>HOME</p>
         </a>
         <a href="#about" class="w3-bar-item w3-button w3-padding-large w3-hover-black">
            <i class="fa fa-user w3-xxlarge"></i>
            <p>ABOUT</p>
         </a>
         <a href="#login-signup-section" class="w3-bar-item w3-button w3-padding-large w3-hover-black">
            <i class="fa fa-sign-in w3-xxlarge"></i>
            <p>Signup & Login</p>
         </a>
         <a href="#q-a-page" class="w3-bar-item w3-button w3-padding-large w3-hover-black">
            <i class="fa fa-eye w3-xxlarge"></i>
            <p>Q/A Page</p>
         </a>
         <a href="#ask-for-appointment" class="w3-bar-item w3-button w3-padding-large w3-hover-black">
            <i class="fa fa-envelope w3-xxlarge"></i>
            <p>Ask for appointment</p>
         </a>
      </nav>
      <!-- Navbar on small screens (Hidden on medium and large screens) -->
      <div class="w3-top w3-hide-large w3-hide-medium" id="myNavbar">
         <div class="w3-bar w3-black w3-opacity w3-hover-opacity-off w3-center w3-small">
            <a href="#" class="w3-bar-item w3-button" style="width:25% !important">HOME</a>
            <a href="#about" class="w3-bar-item w3-button" style="width:20% !important">ABOUT</a>
            <a href="#login-signup-section" class="w3-bar-item w3-button" style="width:20% !important">Signup & Login</a>
            <a href="#q-a-page" class="w3-bar-item w3-button" style="width:20% !important">Q/A Page</a>
            <a href="#ask-for-appointment" class="w3-bar-item w3-button" style="width:20% !important">Appointment</a>
         </div>
      </div>
      <!-- Page Content -->
      <div class="w3-padding-large" id="main">
      <!-- Header/Home -->
      <header class="w3-container w3-padding-32 w3-center w3-black" id="home">
         <h1 class="w3-jumbo"><span class="w3-hide-small">I'm</span> Sofia Tancredy.</h1>
         <p>Doctor and Neurologist.</p>
         <img src="./img/soc.jpg" alt="boy" class="w3-image" width="992" height="1108">
      </header>
      <div class=" w3-button w3-white w3-padding-large" style="position: absolute;right:0;top:0;">
         <a href="<%=request.getContextPath() + "/logout"%>" class="w3-button">Logout</a>
      </div>
      <!-- About Section -->
      <div class="w3-content w3-justify w3-text-grey w3-padding-64" id="about">
         <h2 class="w3-text-light-grey">Sofia Tancredy</h2>
         <hr style="width:200px" class="w3-opacity">
         <p>
            Hello, My name is sofia and i am neurologist, which mean i usually treats disorders that affect the brain, 
            spinal cord, and nerves, such as :
         <p>- Cerebrovascular disease, such as stroke
         <p>
         <p>- Demyelinating diseases of the central nervous system, such as multiple sclerosis
         <p>
         <p>- Headache disorders
         <p>
         <p>-Infections of the brain and peripheral nervous system
         <p>
         </p>
      </div>
      <!-- Signup & Login Section -->
      <div class="w3-content w3-justify w3-text-grey w3-padding-64" id="login-signup-section">
         <!-- Grid for pricing tables -->
         <h3 class="w3-padding-16 w3-text-light-grey">Login & Sign Up</h3>
         <div class="w3-row-padding" style="margin:0 -16px">
            <div class="w3-half w3-margin-bottom">
               <ul class="w3-ul w3-white w3-center w3-opacity w3-hover-opacity-off">
                  <form method="POST" action=<%=request.getContextPath() + "/signup"%>>
                     <li class="w3-dark-grey w3-xlarge w3-padding-16">Sign Up</li>
                     <!-- When user signed up successfully -->				  
                     <c:if test = "${isUserSingedUp}">
                        <li class="w3-green w3-xlarge w3-padding-16">You signed up successfully</li>
                     </c:if>
                     <!-- When user fail to sign up -->
                     <c:if test = "${!isUserSingedUp && isUserSingedUp != null}">
                        <li class="w3-red w3-xlarge w3-padding-16">Failed to sign up</li>
                     </c:if>
                     <input class="w3-input w3-padding-16" placeholder="Enter your firstname" name="firstname" autocomplete="off" type="text">
                     <input class="w3-input w3-padding-16" placeholder="Enter your lastname" name="lastname" autocomplete="off" type="text">
                     <input class="w3-input w3-padding-16" placeholder="Enter your email" name="email" autocomplete="off" type="text">
                     <input class="w3-input w3-padding-16" placeholder="Enter your password" name="password" type="password">
                     <li class="w3-light-grey w3-padding-24">
                        <button class="w3-button w3-white w3-padding-large w3-hover-black">Sign Up</button>
                     </li>
                  </form>
               </ul>
            </div>
            <div class="w3-half">
               <ul class="w3-ul w3-white w3-center w3-opacity w3-hover-opacity-off">
                  <form method="POST" action=<%=request.getContextPath() + "/login"%>>
                     <li class="w3-dark-grey w3-xlarge w3-padding-16">Login</li>
                     <!-- Check if user logged in successfully -->				  
                     <%
				                       if (session != null && session.getAttribute("isLoggedIn") != null && session.getAttribute("isLoggedIn").equals(true)) {
				                       %>
                     <li class="w3-green w3-xlarge w3-padding-16">You logged in successfully</li>
                     <%
                     } else if (session != null && session.getAttribute("isLoggedIn") != null && session.getAttribute("isLoggedIn").equals(false)) {
                     %>
                     <li class="w3-red w3-xlarge w3-padding-16">Failed to login</li>
                     <%
                     }
                     %>
                     <p class="w3-left-align w3-block label-email">Email</p>
                     <input class="w3-input w3-padding-16" placeholder="Enter your email" autocomplete="off" type="text" name="email" >
                     <p class="w3-left-align w3-block label-password">Password</p>
                     <input class="w3-input w3-padding-16" placeholder="Enter your password" type="password" name="password">
                     <li class="w1-padding-16" style="text-align: left;margin: 7px;border: none;">
                        <span class="w3-opacity">Your info will be securitised</span>
                     </li>
                     <li class="w3-light-grey w3-padding-24">
                        <button class="w3-button w3-white w3-padding-large w3-hover-black" type="submit">Login</button>
                     </li>
                  </form>
               </ul>
            </div>
         </div>
         <!-- Q/A Section -->
         <div class="w3-content" id="q-a-page">
            <h2 class="w3-text-light-grey">Q/A Section</h2>
            <hr style="width:200px" class="w3-opacity">
            <%
            if (session.getAttribute("cantComment") != null && session.getAttribute("cantComment").equals(false)) {
            %>
            <li class="w3-red w3-padding-16">You are not logged in</li>
            <%
            }
            %>
            <%
            if (session.getAttribute("isLoggedIn") != null && session.getAttribute("isLoggedIn").equals(true)) {
            %>
            <form action="<%=request.getContextPath() + "/comment"%>" method="POST" style="display: flex;flex-direction: row;align-items: flex-end;">
               <input style="width: 70%;" class="w3-input w3-padding-16" name="commentContent" placeholder="Write something" autocomplete="off" type="text">
               <button style="width: 30%;height: 56px;" class=" w3-button w3-white w3-padding-large" type="submit">
               <i class="fa fa-paper-plane" style="margin-right:14px"></i>
               comment
               </button>
            </form>
            <%
            }
            %>
            <div class="q-a-page-content">
               <%
               CommentDaoImpl commentDaoImpl = new CommentDaoImpl();
                                 	                  
                                 	                  List<Object[]> comments = commentDaoImpl.getAllComments();
                                                   
                                                   // check if there are some comments
                                                   if (comments.size() > 0) {
                                                   
                                 	                  for (Object[] comment : comments) { 
                                 	                  	String firstLetter = comment[4].toString().substring(0, 1).toUpperCase();
                                 	                  	String firstName = comment[4].toString();
                                 	                  	String lastName = comment[5].toString().toUpperCase();
                                 	                  	String commentContent = comment[2].toString();
                                 	                  	
                                 	                  	String CapitalizeFirstName = firstName.substring(0, 1).toUpperCase() + firstName.substring(1).toLowerCase();
                                 	                  	String CapitalizeLastName = lastName.substring(0, 1).toUpperCase() + lastName.substring(1).toLowerCase();
                                 	                	
                                 	                  	pageContext.setAttribute("commentContent", commentContent);
                                 	                  	pageContext.setAttribute("CapitalizeFirstName", CapitalizeFirstName);
                                 	                  	pageContext.setAttribute("CapitalizeLastName", CapitalizeLastName);
                                 	                  	pageContext.setAttribute("firstLetter", firstLetter);
               %>
               <div class="w3-panel w3-padding-16">
                  <div class="name-container">
                     <div class="circle">
                        <span>
                           <c:out value="${firstLetter}"></c:out>
                        </span>
                     </div>
                     <div class="name">
                        <span>
                           <c:out value="${CapitalizeFirstName} ${CapitalizeLastName}"></c:out>
                        </span>
                     </div>
                  </div>
                  <p class="content">
                     <c:out value="${commentContent}"></c:out>
                  </p>
               </div>
               <%
               }
               %>
               <%
               } else {
               %>
               <div class="w3-dark-grey w3-panel w3-padding-16" style="opacity: 0.5">
                  <span>There are no comments right now</span>
               </div>
               <%
               }
               %>
            </div>
         </div>
         <!-- Appointment Section -->
         <div class="w3-padding-64 w3-content w3-text-grey" id="ask-for-appointment" style="margin-top: 200px">
            <h2 class="w3-text-light-grey">Appointment</h2>
            <hr style="width:200px" class="w3-opacity">
            <%
            if (session != null && session.getAttribute("isBooked") != null && session.getAttribute("isBooked").equals(true)) {
            %>
            <div class="w3-panel w3-green w3-padding-16">
               Your appointment booked successfully
            </div>
            <%
            } else if (session != null && session.getAttribute("isBooked") != null && session.getAttribute("isBooked").equals(false) ) {
            %>
            <div class="w3-panel w3-red w3-padding-16">
               You can't make an appointment
            </div>
            <%
            }
            %>
            <!-- Get next day: LocalDate.parse("2021-02-20").plusDays(1).toString() -->
            <form action="<%=request.getContextPath() + "/appointment"%>" method="POST">
               <div class="w3-padding-16" style="display:flex">
                  <select class="w3-select w3-padding-16" name="petsNumber">
                     <option class="w3-padding-16" value="default" disabled selected>Number of pets</option>
                     <option class="w3-padding-16" value="1">1</option>
                     <option class="w3-padding-16" value="2">2</option>
                     <option class="w3-padding-16" value="3">3</option>
                     <option class="w3-padding-16" value="4">4</option>
                  </select>
                  <select class="w3-select w3-padding-16" name="petType">
                     <option class="w3-padding-16" value="default" disabled selected>Pet type</option>
                     <option class="w3-padding-16" value="Dog">Dog</option>
                     <option class="w3-padding-16" value="Cat">Cat</option>
                     <option class="w3-padding-16" value="Rabbit">Rabbit</option>
                     <option class="w3-padding-16" value="Ferret">Ferret</option>
                     <option class="w3-padding-16" value="Hamster">Hamster</option>
                     <option class="w3-padding-16" value="Rat">Rat</option>
                  </select>
               </div>
               <div class="w3-padding-16" style="display:flex">
                  <select class="w3-select w3-padding-16" name="dateAppointment">
                     <option class="w3-padding-16" value="" disabled selected>Choose date appointment</option>
                     <%
                     DateDaoImpl dateDaoImpl = new DateDaoImpl();
                      List<Date> dates = dateDaoImpl.getAllDates();
                      for (Date date : dates) {
                      	if (!date.isTaken()){
                     %>
                     <option class="w3-padding-16" value="<%=date.getDate()%>"> <%=date.getDate()%> </option>
                     <% } %>
                     <% } %>
                  </select>
                  <select class="w3-select w3-padding-16" name="timeAppointment">
                     <option class="w3-padding-16" value="" disabled selected>Choose time appointment</option>
                     <%
                     for (Date date : dates) { 
                       if (!date.isTaken()) {
                     %>
                     <option class="w3-padding-16" value="<%= date.getTime() %>;<%= date.getID() %>">
                     	<%=  date.getTime() %>
                     </option>
                     <% } %>
            
                     <% } %>
                  </select>
               </div>
               <button class="w3-margin-top w3-block w3-button w3-light-grey w3-padding-large" type="submit">
               CONFIRM APPOINTMENT
               </button>
            </form>
            <!-- End Appointment Section -->
         </div>
      </div>
   </body>
</html>