<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>联系我们</title>
</head>
<body>
<!--banner start here-->
<div class="banner-two">
<div class="header">
<jsp:include  page="include/top.jsp" flush="true" /> 
</div>
 </div>
<!--banner end here-->
<!--content-->
<div class="container">
   <div class="contact">
	 <div class="contact-md">
			 <h3>Contact</h3>
			 <p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born</p>
		 </div>
				<div class="col-md-6 contact-top">
					<h3>Want to work with me?</h3>
					<form>
						<div>
							<span>Your Name </span>		
							<input type="text" placeholder="">					
						</div>
						<div>
							<span>Your Email </span>		
							<input type="text" placeholder="">						
						</div>
						<div>
							<span>Subject</span>		
							<input type="text" placeholder="">	
						</div>
						<div>
							<span>Your Message</span>		
							<textarea placeholder="" required></textarea>		
						</div>
						<input type="submit" value="Submit">	
				  </form>
				</div>
				<div class="col-md-6 contact-top">
					<h3>Info</h3>
					
					<p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas </p>
					<p>Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id </p>				
					<div class="map">
					<jsp:include  page="include/map.jsp" flush="true" /> 
					</div>
				</div>
			<div class="clearfix"> </div>
	</div>
</div>
<!--contact end here-->
<!--footer start here-->
<jsp:include  page="include/footer.jsp" flush="true" /> 
<!--footer end here-->
</body>
</html>