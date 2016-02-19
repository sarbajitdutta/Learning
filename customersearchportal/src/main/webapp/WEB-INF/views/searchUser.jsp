<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<base href="https://www.psegliny.com/" />
<meta http-equiv="X-UA-Compatible" content="IE=8, IE=9, IE=10" >
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="PRAGMA" CONTENT="no-cache">
<title>Search User</title>
			<link rel="STYLESHEET" type="text/css" href="https://www.psegliny.com/style/style.css" media="all">
			<link rel="STYLESHEET" type="text/css" href="https://www.psegliny.com/style/EOCWeather.css">
			<link rel="STYLESHEET" type="text/css" href="https://www.psegliny.com/style/messages.css">
			<link rel="STYLESHEET" type="text/css" href="https://www.psegliny.com/style/PSEGLI/style.css" /> 
        	<link rel="stylesheet" href="https://www.psegliny.com/style/PSEGLI/CMSContent.css">		
			<link rel="stylesheet" href="https://myaccountqa.dev.psegliny/customermanagement/general/style/common.css" type="text/css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">



<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<script src="http://localhost:8080/customersearchportal/resources/js/userManage.js"></script>

<style>
.box{
    display: none;
    width: 100%;
}

a:hover + .box,.box:hover{
    display: block;
    position: relative;
    z-index: 100;
}

</style>


</head>
<body ng-app="myApp" ng-controller="userCtrl" >

<center>
	<div id="messageElm"></div>
		<div class="header">
        	<div id="logoDiv">
                <a href="./"><img border="0" src="https://www.psegliny.com/appImages/PSEGLI/PSEGLI_Logo.jpg"></a>
            </div>
            <div class="rightHeaderSection">
             	<div class="outageBtn" onClick="window.location.href='https://www.psegliny.com/page.cfm/CustomerService/ReportOutage';">
					<img id="OutageIcon" src="https://www.psegliny.com/appImages/PSEGLI/Exclaim.png">
                    <div>Report an Outage</div>
                </div>
            	<div class="contactTab" onClick="window.location.href='https://www.psegliny.com/page.cfm/Home/CustomerService/ContactUs';">
                	<div><span id="contactUsBtn">Contact Us&nbsp;&nbsp;</span>(800) 490-0025</div>
                </div>
                <div class="HeaderSearchBox">
                    <gcse:searchbox-only resultsUrl="pageAction.cfm/Search"></gcse:searchbox-only>            
                </div>
            </div>
		</div>
		<div class="menuWrapper">
			<div class="TopMenu">				
			
            	<span class="LinkList">
                <a class="dropDownActivator" dropDownName="menu_1" href="https://www.psegliny.com/page.cfm/Home" parent="0">For Home&nbsp;</a></span>
            
            	<span class="LinkList">
                <a class="dropDownActivator" dropDownName="menu_2" href="https://www.psegliny.com/page.cfm/Commercial" parent="0">For Business&nbsp;</a></span>
            
            	<span class="LinkList">
                <a class="dropDownActivator" dropDownName="menu_3" href="https://www.psegliny.com/page.cfm/AboutUs" parent="0">About Us&nbsp;</a></span>
            
            	<span class="LinkList">
                <a class="dropDownActivator" dropDownName="menu_4" href="https://www.psegliny.com/page.cfm/Home/CustomerService" parent="0">Customer Service&nbsp;</a></span>
            
		</div>
        
	</div>
	
	<div class="PageContent">
	
<form ng-submit="searchUser()">
    <input class="w3-input w3-border" type="text" ng-model="user.username" ng-disabled="!edit" placeholder="Search for user">
        <button type="submit" class="btn btn-primary">Submit</button>
    
</form>

<div class="w3-container">
<div class="tablecontents" ng-hide="tabledata" >
<h3> Users</h3>
<table class="w3-table w3-bordered w3-striped" ng-table="tables" >

  <tr>
  
    <th>User ID</th>
    <th>Given Name</th>
    <th>E-mail</th>
    <th> Migration Flag </th>
      <th>Edit</th>
    <th> Delete </th>
    <th> Change Migration Status </th>
  </tr>
  <tr ng-repeat="user in users ">
    
    <td>{{ user.userId }}</td>
    <td>{{ user.givenName }} </td>
    <td>{{ user.mail}} </td>
    <td ng-model="user.preMigrationFlag" ng-switch="user.preMigrationFlag">
    <p ng-switch-when="true">Pre Migration</p> <p ng-switch-when="false"> Post Migration </p> </td>
    <td>
      <button class="w3-btn w3-ripple" ng-click="editUser(user.id)">&#9998; Edit</button>
    </td>
     <td>
      <button class="w3-btn w3-ripple" ng-click="removeRow(user.id)" > Delete</button>
    </td>
        <td ng-model="user.preMigrationFlag" ng-switch="user.preMigrationFlag">
      <p ng-switch-when="false"> <button class="w3-btn w3-ripple" ng-click="changeFlag(user.id)" > Change</button> </p>
    </td>
  </tr>
</table>
<br>

</div>

<form ng-hide="hideform" ng-submit=editUserSave()>
  <h3 ng-hide="edit">Edit User:</h3>
   <label>User ID</label>
    <input class="w3-input w3-border" type="text" ng-model="user.useridedit" ng-disabled="edit" placeholder="New Email ID">
  <br>
   <label>Given Name</label>
    <input class="w3-input w3-border" type="text" ng-model="user.nameedit" ng-disabled="edit" placeholder="New Email ID">
  <br>
    <label>Email ID</label>
    <input class="w3-input w3-border" type="text" ng-model="user.emailedit" ng-disabled="!edit" placeholder="New Email ID">
  <br>
   
<button type="submit" class="w3-btn w3-green w3-ripple" ng-disabled="error || incomplete">&#10004; Save Changes</button>
</form>

</div>

<div class="FooterBottom" >
   	  <div style="text-align:left;margin-top:10px;">
        	<ul style="list-style:none;padding:0px; margin:0px;">
                <li style="padding:0px 4px 0px 5px;float:left;"><img title="PSEG Long Island on Facebook" src="appImages/PSEGLI/facebookIcon.png" height="32" onclick="window.parent.open('http://www.facebook.com/psegli', '_top');"></li>
                <li style="padding:0px 4px 0px 5px;float:left;"><img title="PSEG Long Island on Twitter" src="appImages/PSEGLI/footericon-twitter.png" height="32" onclick="window.parent.open('http://www.twitter.com/psegli', '_top');"></li>
                <li style="padding:0px 4px 0px 5px;float:left;"><img title="PSEG Long Island on YouTube" src="appImages/PSEGLI/YouTube-social-square-red.png" height="32" onclick="window.parent.open('http://www.youtube.com/psegli', '_top');"></li>
                <li style="padding:0px 12px 0px 5px;float:left;border-right:1px solid #b1a5c0;"><img title="PSEG Long Island on Flickr" src="appImages/PSEGLI/white-large-chiclet_32.png" height="32" onclick="window.parent.open('https://www.flickr.com/photos/psegli', '_top');"></li>
                <li style="padding:0px 4px 0px 12px;float:left;"><img title="PSEG Long Island on Your Mobile Phone" src="appImages/PSEGLI/footericon-text.png" onclick="window.parent.open('page.cfm/CustomerService/ReportOutage/TextIn', '_top');"></li>
                <li style="padding:2px 4px 0px 5px;float:left;"><img title="Sign up for eNews from PSEG Long Island" src="appImages/PSEGLI/footericon-email.png" onclick="window.parent.open('https://www.psegliny.com/eNews', '_top');"></li>
            </ul>
    </div>
    	<div style="padding-top:10px;">&copy; Copyright PSEG Long Island
            	
        </div>
    	<div style="text-align:right;padding-top:10px;">
        	<a href="https://www.psegliny.com/pageAction.cfm/SiteIndex" alt="Site Index Link">site index</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
        	<a href="https://www.psegliny.com/page.cfm/Disclaimer" alt="Disclaimer Link">disclaimer</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
        	<a href="https://www.psegliny.com/page.cfm/PrivacyPolicy" alt="Privacy Policy Link">privacy policy</a>
        </div>
    </div>
    
</div>
</center>

</body>
</html>