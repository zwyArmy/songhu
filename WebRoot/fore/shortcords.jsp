<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="500kb" %>
<%@page import="songhu.common.pojo.Column"%>
<%@page import="com.weixin.core.util.StringUtil"%>
<jsp:useBean id="com" scope="page" class="songhu.common.bean.ArticleBean"
	type="songhu.common.bean.ArticleBean"></jsp:useBean>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String cumd = request.getParameter("cumd");
List<Column> listColumn = com.listColumnByParent("0");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>核心业务</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="js/jquery-1.11.0.min.js"></script>
<!-- Custom Theme files -->
<link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
<!-- Custom Theme files -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Civil Engineer Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!--Google Fonts-->


<!-- start-smoth-scrolling -->
<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>
	<script type="text/javascript">
			jQuery(document).ready(function($) {
				$(".scroll").click(function(event){		
					event.preventDefault();
					$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
				});
			});
	</script>
<!-- //end-smoth-scrolling -->
</head>
<body>
<!--banner start here-->
<div class="banner-two">
  <div class="header">
	<div class="container">
		 <div class="header-main">
				<div class="logo">
					<h1><a href="index.html">嵩湖环保</a></h1>
				</div>
				<div class="top-nav">
					<span class="menu"> <img src="images/icon.png" alt=""/></span>
				<nav class="cl-effect-1">
					<ul class="res">
					  <%for(int i=0;i<listColumn.size();i++){ %>
					   <li>
					   <a href="<%=listColumn.get(i).getLink() %>" <%if(listColumn.get(i).getId().equals(cumd)) {%>class="active"<%} %>><%=listColumn.get(i).getColName() %></a>
					   </li> 
					<%} %>
				   </ul>
				 </nav>
					<!-- script-for-menu -->
						 <script>
						   $( "span.menu" ).click(function() {
							 $( "ul.res" ).slideToggle( 300, function() {
							 // Animation complete.
							  });
							 });
						</script>
		        <!-- /script-for-menu -->
				</div>
			 <div class="clearfix"> </div>
		 </div>
	  </div>
	 </div>
 </div>
<!--banner end here-->
<!--typo start here-->
<div class="typrography">
	<div class="container">
	<div class="page">
		<h3 class="typo1">Short Codes</h3>
		<!--button-->
		<div class="grid_3 grid_4">
			<div class="page-header">
       	<h3>Headings</h3>
      </div>
  
  <div class="bs-example">
    <table class="table">
      <tbody>
        <tr>
          <td><h1 id="h1-bootstrap-heading">h1. Bootstrap heading<a class="anchorjs-link" href="#h1.-bootstrap-heading"><span class="anchorjs-icon"></span></a></h1></td>
          <td class="type-info">Semibold 36px</td>
        </tr>
        <tr>
          <td><h2 id="h2-bootstrap-heading">h2. Bootstrap heading<a class="anchorjs-link" href="#h2.-bootstrap-heading"><span class="anchorjs-icon"></span></a></h2></td>
          <td class="type-info">Semibold 30px</td>
        </tr>
        <tr>
          <td><h3 id="h3-bootstrap-heading">h3. Bootstrap heading<a class="anchorjs-link" href="#h3.-bootstrap-heading"><span class="anchorjs-icon"></span></a></h3></td>
          <td class="type-info">Semibold 24px</td>
        </tr>
        <tr>
          <td><h4 id="h4.-bootstrap-heading">h4. Bootstrap heading<a class="anchorjs-link" href="#h4.-bootstrap-heading"><span class="anchorjs-icon"></span></a></h4></td>
          <td class="type-info">Semibold 18px</td>
        </tr>
        <tr>
          <td><h5 id="h5-bootstrap-heading">h5. Bootstrap heading<a class="anchorjs-link" href="#h5.-bootstrap-heading"><span class="anchorjs-icon"></span></a></h5></td>
          <td class="type-info">Semibold 14px</td>
        </tr>
        <tr>
          <td><h6  id="h6-bootstrap-heading">h6. Bootstrap heading</h6></td>
          <td class="type-info">Semibold 12px</td>
        </tr>
      </tbody>
    </table>
    </div>
  </div>
  <!--buttons-->
	<div class="page-header">
        <h3>Buttons</h3>
      </div>
      <p class="grid1">
        <button type="button" class="btn btn-lg btn-default">Default</button>
        <button type="button" class="btn btn-lg btn-primary">Primary</button>
        <button type="button" class="btn btn-lg btn-success">Success</button>
        <button type="button" class="btn btn-lg btn-info">Info</button>
        <button type="button" class="btn btn-lg btn-warning">Warning</button>
        <button type="button" class="btn btn-lg btn-danger">Danger</button>
        <button type="button" class="btn btn-lg btn-link">Link</button>
      </p>
      <p class="grid1 ">
        <button type="button" class="btn btn-1 btn-default">Default</button>
        <button type="button" class="btn btn-1 btn-primary">Primary</button>
        <button type="button" class="btn btn-1 btn-success">Success</button>
        <button type="button" class="btn btn-1 btn-info">Info</button>
        <button type="button" class="btn btn-1 btn-warning">Warning</button>
        <button type="button" class="btn btn-1 btn-danger">Danger</button>
        <button type="button" class="btn btn-1 btn-link">Link</button>
      </p>
      <p class="grid1">
        <button type="button" class="btn btn-sm btn-default">Default</button>
        <button type="button" class="btn btn-sm btn-primary">Primary</button>
        <button type="button" class="btn btn-sm btn-success">Success</button>
        <button type="button" class="btn btn-sm btn-info">Info</button>
        <button type="button" class="btn btn-sm btn-warning">Warning</button>
        <button type="button" class="btn btn-sm btn-danger">Danger</button>
        <button type="button" class="btn btn-sm btn-link">Link</button>
      </p>
      <p class="grid1">
        <button type="button" class="btn btn-xs btn-default">Default</button>
        <button type="button" class="btn btn-xs btn-primary">Primary</button>
        <button type="button" class="btn btn-xs btn-success">Success</button>
        <button type="button" class="btn btn-xs btn-info">Info</button>
        <button type="button" class="btn btn-xs btn-warning">Warning</button>
        <button type="button" class="btn btn-xs btn-danger">Danger</button>
        <button type="button" class="btn btn-xs btn-link">Link</button>
      </p>
      <!--//button-->
      <!--bages-->
      <div class="page-header">
        <h3>Badges</h3>
      </div>
      <p>
        <a href="#">Inbox <span class="badge">42</span></a>
      </p>
      <ul class="nav nav-pills" role="tablist">
        <li role="presentation" class="active"><a href="#">Home <span class="badge">42</span></a></li>
        <li role="presentation"><a href="#">Profile</a></li>
        <li role="presentation"><a href="#">Messages <span class="badge">3</span></a></li>
      </ul>
       <!--//bages-->
       <!--alerts-->
       <div class="page-header">
        <h1>Alerts</h1>
      </div>
      <div class="alert alert-success" role="alert">
        <strong>Well done!</strong> You successfully read this important alert message.
      </div>
      <div class="alert alert-info" role="alert">
        <strong>Heads up!</strong> This alert needs your attention, but it's not super important.
      </div>
      <div class="alert alert-warning" role="alert">
        <strong>Warning!</strong> Best check yo self, you're not looking too good.
      </div>
      <div class="alert alert-danger" role="alert">
        <strong>Oh snap!</strong> Change a few things up and try submitting again.
      </div>
      <!--//alerts-->
        <!--nav-->
       <div class="page-header">
        <h3>Navs</h3>
        <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#">Home</a></li>
        <li role="presentation"><a href="#">Profile</a></li>
        <li role="presentation"><a href="#">Messages</a></li>
      </ul>
      <ul class="nav nav-pills" role="tablist">
        <li role="presentation" class="active"><a href="#">Home</a></li>
        <li role="presentation"><a href="#">Profile</a></li>
        <li role="presentation"><a href="#">Messages</a></li>
      </ul>
      </div>
        <!--//nav-->   
        <!--Progress bars-->
        <div class="page-header">
        <h3>Progress bars</h3>
      </div>
      <div class="progress">
        <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;"><span class="sr-only">60% Complete</span></div>
      </div>
      <div class="progress">
        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%"><span class="sr-only">40% Complete (success)</span></div>
      </div>
      <div class="progress">
        <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%"><span class="sr-only">20% Complete</span></div>
      </div>
      <div class="progress">
        <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%"><span class="sr-only">60% Complete (warning)</span></div>
      </div>
      <div class="progress">
        <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%"><span class="sr-only">80% Complete (danger)</span></div>
      </div>
      <div class="progress">
        <div class="progress-bar progress-bar-striped" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%"><span class="sr-only">60% Complete</span></div>
      </div>
      <div class="progress">
        <div class="progress-bar progress-bar-success" style="width: 35%"><span class="sr-only">35% Complete (success)</span></div>
        <div class="progress-bar progress-bar-warning" style="width: 20%"><span class="sr-only">20% Complete (warning)</span></div>
        <div class="progress-bar progress-bar-danger" style="width: 10%"><span class="sr-only">10% Complete (danger)</span></div>
      </div>
      <!--//Progress bars-->
        <!--Panels-->
      <div class="page-header">
        <h3>Panels</h3>
      </div>
      <div class="row">
        <div class="col-sm-4">
          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title">Panel title</h3>
            </div>
            <div class="panel-body">
              Panel content
            </div>
          </div>
          <div class="panel panel-primary">
            <div class="panel-heading">
              <h3 class="panel-title">Panel title</h3>
            </div>
            <div class="panel-body">
              Panel content
            </div>
          </div>
        </div><!-- /.col-sm-4 -->
        <div class="col-sm-4">
          <div class="panel panel-success">
            <div class="panel-heading">
              <h3 class="panel-title">Panel title</h3>
            </div>
            <div class="panel-body">
              Panel content
            </div>
          </div>
          <div class="panel panel-info">
            <div class="panel-heading">
              <h3 class="panel-title">Panel title</h3>
            </div>
            <div class="panel-body">
              Panel content
            </div>
          </div>
        </div><!-- /.col-sm-4 -->
        <div class="col-sm-4">
          <div class="panel panel-warning">
            <div class="panel-heading">
              <h3 class="panel-title">Panel title</h3>
            </div>
            <div class="panel-body">
              Panel content
            </div>
          </div>
          <div class="panel panel-danger">
            <div class="panel-heading">
              <h3 class="panel-title">Panel title</h3>
            </div>
            <div class="panel-body">
              Panel content
            </div>
          </div>
        </div><!-- /.col-sm-4 -->
      </div>
       <!--//Panels-->
        <!--labels-->
       <div class="page-header">
        <h3>Labels</h3>
      </div>
      <h1 class="grid2">
        <span class="label label-default">Default</span>
        <span class="label label-primary">Primary</span>
        <span class="label label-success">Success</span>
        <span class="label label-info">Info</span>
        <span class="label label-warning">Warning</span>
        <span class="label label-danger">Danger</span>
      </h1>
      <h2 class="grid2">
        <span class="label label-default">Default</span>
        <span class="label label-primary">Primary</span>
        <span class="label label-success">Success</span>
        <span class="label label-info">Info</span>
        <span class="label label-warning">Warning</span>
        <span class="label label-danger">Danger</span>
      </h2>
      <h3 class="grid2">
        <span class="label label-default">Default</span>
        <span class="label label-primary">Primary</span>
        <span class="label label-success">Success</span>
        <span class="label label-info">Info</span>
        <span class="label label-warning">Warning</span>
        <span class="label label-danger">Danger</span>
      </h3>
      <h4 class="grid2">
        <span class="label label-default">Default</span>
        <span class="label label-primary">Primary</span>
        <span class="label label-success">Success</span>
        <span class="label label-info">Info</span>
        <span class="label label-warning">Warning</span>
        <span class="label label-danger">Danger</span>
      </h4>
      <h5 class="grid2">
        <span class="label label-default">Default</span>
        <span class="label label-primary">Primary</span>
        <span class="label label-success">Success</span>
        <span class="label label-info">Info</span>
        <span class="label label-warning">Warning</span>
        <span class="label label-danger">Danger</span>
      </h5>
      <h6 class="grid2">
        <span class="label label-default">Default</span>
        <span class="label label-primary">Primary</span>
        <span class="label label-success">Success</span>
        <span class="label label-info">Info</span>
        <span class="label label-warning">Warning</span>
        <span class="label label-danger">Danger</span>
      </h6>
      <p class="grid2">
        <span class="label label-default">Default</span>
        <span class="label label-primary">Primary</span>
        <span class="label label-success">Success</span>
        <span class="label label-info">Info</span>
        <span class="label label-warning">Warning</span>
        <span class="label label-danger">Danger</span>
      </p>
       <!--//labels-->
	
	<!--table-->
	 <div class="page-header">
        <h3>Tables</h3>
      </div>
  
  <div class="bs-example" data-example-id="simple-table">
    <table class="table">
      <caption>Optional table caption.</caption>
      <thead>
        <tr>
          <th>#</th>
          <th>First Name</th>
          <th>Last Name</th>
          <th>Username</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th scope="row">1</th>
          <td>Mark</td>
          <td>Otto</td>
          <td>@mdo</td>
        </tr>
        <tr>
          <th scope="row">2</th>
          <td>Jacob</td>
          <td>Thornton</td>
          <td>@fat</td>
        </tr>
        <tr>
          <th scope="row">3</th>
          <td>Larry</td>
          <td>the Bird</td>
          <td>@twitter</td>
        </tr>
      </tbody>
    </table>
  </div><!-- /example -->
	<!--//table-->
	<!--Contextual classes-->
	 <div class="page-header">
        <h3>Contextual classes</h3>
      </div>
      <div class="table-responsive">
    <table class="table table-bordered table-striped">
      <colgroup>
        <col class="col-xs-1">
        <col class="col-xs-7">
      </colgroup>
      <thead>
        <tr>
          <th>Class</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th scope="row">
            <code>.active</code>
          </th>
          <td>Applies the hover color to a particular row or cell</td>
        </tr>
        <tr>
          <th scope="row">
            <code>.success</code>
          </th>
          <td>Indicates a successful or positive action</td>
        </tr>
        <tr>
          <th scope="row">
            <code>.info</code>
          </th>
          <td>Indicates a neutral informative change or action</td>
        </tr>
        <tr>
          <th scope="row">
            <code>.warning</code>
          </th>
          <td>Indicates a warning that might need attention</td>
        </tr>
        <tr>
          <th scope="row">
            <code>.danger</code>
          </th>
          <td>Indicates a dangerous or potentially negative action</td>
        </tr>
      </tbody>
    </table>
  </div>
  <div class="bs-example" data-example-id="contextual-table" style="border: 1px solid #eee">
    <table class="table">
      <thead>
        <tr>
          <th>#</th>
          <th>Column heading</th>
          <th>Column heading</th>
          <th>Column heading</th>
        </tr>
      </thead>
      <tbody>
        <tr class="active">
          <th scope="row">1</th>
          <td>Column content</td>
          <td>Column content</td>
          <td>Column content</td>
        </tr>
        <tr>
          <th scope="row">2</th>
          <td>Column content</td>
          <td>Column content</td>
          <td>Column content</td>
        </tr>
        <tr class="success">
          <th scope="row">3</th>
          <td>Column content</td>
          <td>Column content</td>
          <td>Column content</td>
        </tr>
        <tr>
          <th scope="row">4</th>
          <td>Column content</td>
          <td>Column content</td>
          <td>Column content</td>
        </tr>
        <tr class="info">
          <th scope="row">5</th>
          <td>Column content</td>
          <td>Column content</td>
          <td>Column content</td>
        </tr>
        <tr>
          <th scope="row">6</th>
          <td>Column content</td>
          <td>Column content</td>
          <td>Column content</td>
        </tr>
        <tr class="warning">
          <th scope="row">7</th>
          <td>Column content</td>
          <td>Column content</td>
          <td>Column content</td>
        </tr>
        <tr>
          <th scope="row">8</th>
          <td>Column content</td>
          <td>Column content</td>
          <td>Column content</td>
        </tr>
        <tr class="danger">
          <th scope="row">9</th>
          <td>Column content</td>
          <td>Column content</td>
          <td>Column content</td>
        </tr>
      </tbody>
    </table>
  </div>
	<!--//Contextual classes-->
	<!--Forms-->
	<div class="page-header">
        <h3>Forms</h3>
      </div>
   <div class="bs-example" data-example-id="simple-form-inline">
    <form class="form-inline">
      <div class="form-group">
        <label class="sr-only" for="exampleInputEmail3">Email address</label>
        <input type="email" class="form-control" id="exampleInputEmail3" placeholder="Email">
      </div>
      <div class="form-group">
        <label class="sr-only" for="exampleInputPassword3">Password</label>
        <input type="password" class="form-control" id="exampleInputPassword3" placeholder="Password">
      </div>
      <div class="checkbox">
        <label>
          <input type="checkbox"> Remember me
        </label>
      </div>
      <button type="submit" class="btn btn-default">Sign in</button>
    </form>
  </div>
  <div class="bs-example" data-example-id="simple-horizontal-form">
    <form class="form-horizontal">
      <div class="form-group">
        <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
        <div class="col-sm-10">
          <input type="email" class="form-control" id="inputEmail3" placeholder="Email">
        </div>
      </div>
      <div class="form-group">
        <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
        <div class="col-sm-10">
          <input type="password" class="form-control" id="inputPassword3" placeholder="Password">
        </div>
      </div>
      <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
          <div class="checkbox">
            <label>
              <input type="checkbox"> Remember me
            </label>
          </div>
        </div>
      </div>
      <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
          <button type="submit" class="btn btn-default">Sign in</button>
        </div>
      </div>
    </form>
  </div>
  <div class="bs-example" data-example-id="disabled-fieldset">
    <form>
      <fieldset disabled>
        <div class="form-group">
          <label for="disabledTextInput">Disabled input</label>
          <input type="text" id="disabledTextInput" class="form-control" placeholder="Disabled input">
        </div>
        <div class="form-group">
          <label for="disabledSelect">Disabled select menu</label>
          <select id="disabledSelect" class="form-control">
            <option>Disabled select</option>
          </select>
        </div>
        <div class="checkbox">
          <label>
            <input type="checkbox"> Can't check this
          </label>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
      </fieldset>
    </form>
  </div>
	<!--//forms-->
	</div>
</div>
</div>
<!--typo end here-->
<!--footer start here-->
<div class="footer">
	<div class="container">
		<div class="footer-main">
				<div class="col-md-4 ftr-gd">
					<h3>å å¥æä»¬</h3>
					<ul>
						<li><a href="#" class="fa"> </a></li>
						<li><a href="#" class="tw"> </a></li>
						<li><a href="#" class="g"> </a></li>
					</ul>
				</div>
				<div class="col-md-4 ftr-gd">
					<h3>é®ç®±</h3>
					<form>
						<input  type="text" value="è¾å¥æ¨çé®ç®±" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'è¾å¥æ¨çé®ç®±';}">
						<input type="submit" value="åé">
					</form>
				</div>
				<div class="col-md-4 ftr-gd">
					<h3>èç³»æ¹å¼</h3>
					<p>å°åï¼å¦é¨æ¹éåºäºé¡¶ä¸­è·¯2777å·å¸æ¿å¤§å¦24å±</p>
					<p>çµè¯:0592-5172555</p>
				</div>
			<div class="clearfix"> </div>
		</div>
		<div class="copyright">
			   <p>Â© 2016 å¦é¨åµ©æ¹ç¯ä¿è¡ä»½æéå¬å¸ä¿çæææå| è®¾è®¡äºï¼  <a href="http://user.qzone.qq.com/75742471/infocenter?ptsig=BzgxE7qGKt9LwgRZZ--koWI-EOgR8Hi9XciUf3RwCWc_" target="_blank">  Woody </a></p>
		</div>
		<script type="text/javascript">
										$(document).ready(function() {
											/*
											var defaults = {
									  			containerID: 'toTop', // fading element id
												containerHoverID: 'toTopHover', // fading element hover id
												scrollSpeed: 1200,
												easingType: 'linear' 
									 		};
											*/
											
											$().UItoTop({ easingType: 'easeOutQuart' });
											
										});
									</script>
						<a href="#" id="toTop" style="display: block;"> <span id="toTopHover" style="opacity: 1;"> </span></a>

	</div>
</div>
<!--footer end here-->
</body>
</html>