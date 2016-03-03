<!DOCTYPE html>
<html ng-app="searchusers">

  <head>
    <meta charset="utf-8" />
    <title>PSEG LI User Management</title>
    
    <link rel="stylesheet" href="http://localhost:8001/customersearchportal/resources/css/w3.css">
  	<link rel="STYLESHEET" type="text/css" href="https://www.psegliny.com/style/style.css" media="all">
			<link rel="STYLESHEET" type="text/css" href="https://www.psegliny.com/style/EOCWeather.css">
			<link rel="STYLESHEET" type="text/css" href="https://www.psegliny.com/style/messages.css">
			<link rel="STYLESHEET" type="text/css" href="https://www.psegliny.com/style/PSEGLI/style.css" /> 
        	<link rel="stylesheet" href="https://www.psegliny.com/style/PSEGLI/CMSContent.css">		
			<link rel="stylesheet" href="https://myaccountqa.dev.psegliny/customermanagement/general/style/common.css" type="text/css">  
  <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/angular_material/1.0.0/angular-material.min.css">

<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular-route.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular-cookies.js"></script>
<script src="http://localhost:8001/customersearchportal/resources/js/searchuser.js"></script>
  <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular-messages.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/angular_material/1.0.0/angular-material.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular-animate.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular-aria.min.js"></script>
  

  </head>

  <body ng-controller="indexCtrl" >
<center>
	<div id="messageElm"></div>
		<div class="header">
        	<div id="logoDiv">
                <a href="./"><img border="0" src="https://www.psegliny.com/appImages/PSEGLI/PSEGLI_Logo.jpg"></a>
            </div>
            <div class="rightHeaderSection">
             	<div class="outageBtn" style="width:220px" >
                    <div>Customer Management Portal</div>
                </div>
            	
            </div>
		</div>
		<div class="menuWrapper">
			<div class="TopMenu">				
			
            	<span class="LinkList">
                <a class="dropDownActivator" dropDownName="menu_1" href="#"  parent="0">Home&nbsp;</a></span>
            	
            	
            	<span class="LinkList" ng-switch="loggedIn">
            	 <p ng-switch-when="true">
                <a class="dropDownActivator" dropDownName="menu_2" href="#" ng-show="loggedIn" ng-click="logOut()" parent="0">Logout&nbsp;</a></span>
            	</p>
            	</span>
            
            
		</div>
        
	</div>
	</center>
    <div ng-include="template.url"></div>
   <!--   <div ng-include="template.url"></div> -->
   
   <div class="FooterBottom" style="position:fixed; bottom:0px;" >
   	  <div style="text-align:left;margin-top:10px;">
        	<ul style="list-style:none;padding:0px; margin:0px;">
                <li style="padding:0px 4px 0px 5px;float:left;"><img title="PSEG Long Island on Facebook" src="https://www.psegliny.com/appImages/PSEGLI/facebookIcon.png" height="32" onclick="window.parent.open('http://www.facebook.com/psegli', '_top');"></li>
                <li style="padding:0px 4px 0px 5px;float:left;"><img title="PSEG Long Island on Twitter" src="https://www.psegliny.com/appImages/PSEGLI/footericon-twitter.png" height="32" onclick="window.parent.open('http://www.twitter.com/psegli', '_top');"></li>
                <li style="padding:0px 4px 0px 5px;float:left;"><img title="PSEG Long Island on YouTube" src="https://www.psegliny.com/appImages/PSEGLI/YouTube-social-square-red.png" height="32" onclick="window.parent.open('http://www.youtube.com/psegli', '_top');"></li>
                <li style="padding:0px 12px 0px 5px;float:left;border-right:1px solid #b1a5c0;"><img title="PSEG Long Island on Flickr" src="https://www.psegliny.com/appImages/PSEGLI/white-large-chiclet_32.png" height="32" onclick="window.parent.open('https://www.flickr.com/photos/psegli', '_top');"></li>
                <li style="padding:0px 4px 0px 12px;float:left;"><img title="PSEG Long Island on Your Mobile Phone" src="https://www.psegliny.com/appImages/PSEGLI/footericon-text.png" onclick="window.parent.open('page.cfm/CustomerService/ReportOutage/TextIn', '_top');"></li>
                <li style="padding:2px 4px 0px 5px;float:left;"><img title="Sign up for eNews from PSEG Long Island" src="https://www.psegliny.com/appImages/PSEGLI/footericon-email.png" onclick="window.parent.open('https://www.psegliny.com/eNews', '_top');"></li>
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
  </body>

</html>
