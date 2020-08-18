<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!--JSTL -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>08Json/login</title>

<!--jquery와 부트스트랩 CDN 추가함 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	//로그인 버튼 클릭
	$('#loginBtn').click(function(){
		//폼의 빈값 체크
		var f = document.loginFrm;
		if(f.id.value==""){
			alert('아이디를 입력하세요');
			f.id.focus();
			return;
		}
		if(f.pass.value==""){
			alert('비번를 입력하세요');
			f.pass.focus();
			return;
		}
		$.ajax({
			url:"./loginAction.do", //요청경로
			type:"post", //전송방식
			contentType:"application/x-www-form-urlencoded;charset:utf-8;",
			data:{//서버로 전송할 파라미터(항상 JSON타입으로 기술)
				id: $('#id').val(),
				pass: $('#pass').val()
			},
			dataType:"json",//콜백 데이터 타입
			success:function(d){//콜백메소드
				if(d.loginResult==0){
					alert(d.loginMessage);
				}else{
					alert(d.loginMessage);
					location.href="list.do";
				}
			},
			error:function(e){
				alert('실패:'+e);
			}
		});
		
	});
});
</script>
</head>
<body>
<div class="container"> 
	<h3>방명록(로그인)</h3> 
	<!--로그인 된 경우에는 회원의 이름과 로그아웃 버튼을 출력  -->
	<c:choose>
		<c:when test="${not empty sessionScope.siteUserInfo }">
			<div class="row" style="border:2px solid #cccccc;padding:10px;">			
				<h4>아이디:${sessionScope.siteUserInfo.id }</h4>
				<h4>이름:${sessionScope.siteUserInfo.name }</h4>
				<br /><br />
				<button class="btn btn-danger" 
					onclick="location.href='logout.do';">
					로그아웃</button>
				&nbsp;&nbsp;
				<button class="btn btn-primary" 
					onclick="location.href='list.do';">
					방명록리스트</button>
			</div>
		</c:when>
		<c:otherwise>
			<span style="font-size:1.5em; color:red;">${LoginNG }</span>
			<form name="loginFrm" method="post" action="./loginAction.do" 
				onsubmit="return loginValidate(this);">
			
				
				
				<!--로그인에 성공할 경우 이동할 페이지의 경로를 폼값으로 전송-->
				<input type="hidden" name="backUrl" value="${param.backUrl }"/>
				
				
				
				<table class="table-bordered" style="width:50%;">
					<tr>
						<td><input type="text" class="form-control" id="id" name="id" placeholder="아이디" tabindex="1"></td>
						<td rowspan="2" style="width:80px;">
							<button type="button" id="loginBtn" class="btn btn-primary" style="height:77px;width:77px;" tabindex="3">로그인</button>
						</td>
					</tr>
					<tr>
						<td><input type="password" class="form-control" id="pass" name="pass" placeholder="패스워드" tabindex="2"></td>
					</tr>
				</table>
			</form>
		</c:otherwise>
	</c:choose>
</div>

</body>
</html>



















