<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>荣誉资质</title>
<link rel="stylesheet" type="text/css" href="css/style_common.css" />
<link rel="stylesheet" type="text/css" href="css/style7.css" />
</head>
<body>
<!--banner start here-->
<div class="banner-two">
<div class="header">
	<jsp:include  page="include/top.jsp" flush="true" /> 
	</div>
 </div>
<!--banner end here-->
<!--gallery start here-->
<div class="gallery">
	<div class="container">
		<div class="gallery-main">
			<div class="gallery-bottom">
			   <div class="view view-seventh">
                    <a href="images/g1.jpg" class="b-link-stripe b-animate-go  swipebox"  title="Image Title"><img src="images/g1.jpg" alt="" class="img-responsive">
                    <div class="mask">
                        <h2>gallery</h2>
                        <p>A wonderful serenity has taken possession of my entire soul.</p>
                        <span class="gall">More</span>
                    </div></a>
                </div>
               <div class="view view-seventh">
                     <a href="images/g2.jpg" class="b-link-stripe b-animate-go  swipebox"  title="Image Title"><img src="images/g2.jpg" alt="" class="img-responsive">
                    <div class="mask">
                        <h2>gallery</h2>
                        <p>A wonderful serenity has taken possession of my entire soul.</p>
                         <span class="gall">More</span>
                    </div></a>
                </div>
                <div class="view view-seventh">
                     <a href="images/g3.jpg" class="b-link-stripe b-animate-go  swipebox"  title="Image Title"><img src="images/g3.jpg" alt="" class="img-responsive">
                    <div class="mask">
                        <h2>gallery</h2>
                        <p>A wonderful serenity has taken possession of my entire soul.</p>
                         <span class="gall">More</span>
                    </div></a>
                </div>
                <div class="view view-seventh">
                     <a href="images/g4.jpg" class="b-link-stripe b-animate-go  swipebox"  title="Image Title"><img src="images/g4.jpg" alt="" class="img-responsive">
                    <div class="mask">
                        <h2>gallery</h2>
                        <p>A wonderful serenity has taken possession of my entire soul.</p>
                         <span class="gall">More</span>
                    </div></a>
                </div>
               <div class="view view-seventh">
                      <a href="images/g5.jpg" class="b-link-stripe b-animate-go  swipebox"  title="Image Title"><img src="images/g5.jpg" alt="" class="img-responsive">
                    <div class="mask">
                        <h2>gallery</h2>
                        <p>A wonderful serenity has taken possession of my entire soul.</p>
                         <span class="gall">More</span>
                    </div></a>
                </div>
                <div class="view view-seventh">
                    <a href="images/g6.jpg" class="b-link-stripe b-animate-go  swipebox"  title="Image Title"><img src="images/g6.jpg" alt="" class="img-responsive">
                    <div class="mask">
                        <h2>gallery</h2>
                        <p>A wonderful serenity has taken possession of my entire soul.</p>
                        <span class="gall">More</span>
                    </div></a>
                </div>             
             <div class="clearfix"> </div>
             </div>
		</div>
	</div>
</div>
<link rel="stylesheet" href="css/swipebox.css">
	<script src="js/jquery.swipebox.min.js"></script> 
	    <script type="text/javascript">
			jQuery(function($) {
				$(".swipebox").swipebox();
			});
</script>

<!--gallery end here-->
<!--footer start here-->
<jsp:include  page="include/footer.jsp" flush="true" /> 
<!--footer end here-->
</body>
</html>