<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<style>
	#random {
		text-align: center;
		margin-top: 100px;
	}
	
	#randomResult {
		margin: 20px auto;
		width: 400px;
		height: 200px;
		border-radius: 25px;
		background-color: #eeeeee;
	}
	
	#randomTitle {
		font-family: 'Gaegu',cursive;
		font-size: 20pt;
		font-weight: bold;
		color: #593196;
		margin-bottom: 10px;
	}
	
</style>

<div id="random">
	<p id="randomTitle">๐RANDOM GAME๐</p>
	<p style="margin:0px;">๋ฒํผ์ ํด๋ฆญํ๋ฉด ์ฆ๊ฒจ์ฐพ๊ธฐ ํด๋์ ์ฅ์ ์ค ๋๋ค์ผ๋ก ํ ๊ณณ์ด ๋ฝํ๋๋ค.</p>
	<input type="hidden" name="member_id" id="member_id" value="${sessionScope.member.id}">
	<div id="randomResult"><p style="padding-top:0px;line-height:200px;">์ค๋ ์ ์ฌ ๋ญ ๋จน์ง ?</p></div>
	<button type="button" id="randomBtn" class="btn btn-primary btn-lg"> C L I C K </button>
</div>

<script>
	$('#randomBtn').click(function() {

		var member_id = $('#member_id').val();
		var action = './random'; 
			
		$.post(
			action,
			{
				member_id : member_id
			},
			function(data) {
				if (data.size == null) {
					$('#randomResult').html('<p style="line-height:200px;">์ ์ฅํ ์ฆ๊ฒจ์ฐพ๊ธฐ๊ฐ ์์ต๋๋ค.</p>');
				} else {
					var num = Math.floor(Math.random()*data.size);
					$('#randomResult').html('<p style="padding-top:50px;">์ค๋ ์ ์ฌ์</p><p style="font-size:14pt;font-weight:bold;">' 
							+ data.mapDB[num].place_name + '</p><p>์ด๋์?</p>');
				}
			},
			'json'
		);
	});
</script>

</body>
</html>