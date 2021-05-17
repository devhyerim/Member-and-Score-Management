<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="css/MemberScore.css">
<style type="text/css">
	.center{ text-align: center; }
</style>

<script type="text/javascript">
	
	function memberSubmit()
	{
		//alert("호출");
		
		var memberForm = document.getElementById("memberForm");
		var uName = document.getElementById("uName");
		
		var nameMsg = document.getElementById("nameMsg");
		nameMsg.style.display="none";
		
		if(uName.value=="")
		{
			nameMsg.style.display = "inline";
			uName.focus();
			return;			// 함수를 종료해서 아래의 submit을 수행하지 않는다.
		}
		
		// form을 직접 지정하여 submit 액션 수행
		//-- form 객체를 직접 가져와서 submit 수행해준다.
		memberForm.submit();
	}
	
	function memberReset()
	{
		var memberForm = document.getElementById("memberForm");
		var uName = document.getElementById("uName");
		var nameMsg = document.getElementById("nameMsg");
		
		nameMsg.style.display = "none";
		
		// form을 직접 지정하여 reset 액션 수행
		memberForm.reset();
		
		uName.focus();
	}

</script>

</head>
<body>

<!-- http://localhost:8090/WebApp12/MemberInsertForm.jsp -->
<div>
	<h1>회원 명단 관리 및 <span style="color: green;">입력</span> 페이지</h1>
	<hr>
</div>
<br>
<div>
	<a href="MemberSelect.jsp"><button type="button">회원 명단 관리</button></a>
</div>
<br>

<div>
	<!-- 회원 정보 입력 폼 구성 -->
	<form action="MemberInsert.jsp" method="post" id="memberForm">
		<table class='table'>
			<tr>
				<th>이름(*)</th>
				<td>
					<input type="text" id="uName" name="uName">
				</td>
				<td>
					<span class="errMsg" id="nameMsg">이름을 입력해야 합니다.</span>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type="text" id="uTel" name="uTel">
				</td>
			</tr>
		</table>
		<br>
		
		<a href="javascript:memberSubmit()"><button type="button">입력하기</button></a>
		<a href="javascript:memberReset()"><button type="button">취소하기</button></a>
		<a href="MemberSelect.jsp"><button type="button">목록으로</button></a>
	</form>
</div>

</body>
</html>