<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=188651cfe552ee9b3c8c65f2d926eb55&libraries=services,clusterer,drawing"></script>
<style>
	#map {
		width: 100%;
		height: 100%;
		position: relative;
		overflow: hidden;
	}
	
	.map_wrap, .map_wrap * {
		margin: 0;
		/*padding: 0;*/
		font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	}
	
	.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
		color: #000;
		text-decoration: none;
	}
	
	.map_wrap {
		position:relative;
		width: 100%;
		height: 100%;
	}
	
	#menu_wrap {
		width: 350px;
		height: 100%;
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		z-index: 1;
		background-color: white;
		font-size: 12px;
		box-shadow: 1px 1px 10px 1px gray;
	}
	
	.bg_white {
		background: #fff;
	}
	
	#menu_wrap hr {
		display: block;
		height: 1px;
		border: 0;
		border-top: 2px solid #5F5F5F;
		margin: 3px 0;
	}
	
	#menu_wrap .option {
		/*text-align: center;*/
		background-color: white;
		border-bottom: 1px solid lightgray;
		width: 350px;
		height: 75px;
		padding: 20px 25px;
	}
	
	#menu_wrap .option button {
		width: 70px;
		height: 35px;
	}
	
	#placesList {
		padding: 0px;
		position: relative;
	}
	
	#placesList li {
		list-style: none;
	}
	
	#placesList .item {
		position: relative;
		border-bottom: 1px solid #888;
		overflow: hidden;
		cursor: pointer;
		min-height: 65px;
	}
	
	#placesList .item span {
		display: block;
		margin-top: 4px;
	}
	
	#placesList .item h5, #placesList .item .info {
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;
	}
	
	#placesList .item .info {
		padding: 10px 0 10px 55px;
	}
	
	#placesList .info .gray {
		color: #8a8a8a;
	}
	
	#placesList .info .jibun {
		padding-left: 26px;
		background:
			url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
			no-repeat;
	}
	
	#placesList .info .tel {
		color: #009900;
	}
	
	#placesList .item .markerbg {
		float: left;
		position: absolute;
		width: 36px;
		height: 37px;
		margin: 10px 0 0 10px;
		background:
			url(resource/images/marker_number_purple.png)
			no-repeat;
	}
	
	#placesList .item .marker_1 {
		background-position: 0 -10px;
	}
	
	#placesList .item .marker_2 {
		background-position: 0 -56px;
	}
	
	#placesList .item .marker_3 {
		background-position: 0 -102px
	}
	
	#placesList .item .marker_4 {
		background-position: 0 -148px;
	}
	
	#placesList .item .marker_5 {
		background-position: 0 -194px;
	}
	
	#placesList .item .marker_6 {
		background-position: 0 -240px;
	}
	
	#placesList .item .marker_7 {
		background-position: 0 -286px;
	}
	
	#placesList .item .marker_8 {
		background-position: 0 -332px;
	}
	
	#placesList .item .marker_9 {
		background-position: 0 -378px;
	}
	
	#placesList .item .marker_10 {
		background-position: 0 -423px;
	}
	
	#placesList .item .marker_11 {
		background-position: 0 -470px;
	}
	
	#placesList .item .marker_12 {
		background-position: 0 -516px;
	}
	
	#placesList .item .marker_13 {
		background-position: 0 -562px;
	}
	
	#placesList .item .marker_14 {
		background-position: 0 -608px;
	}
	
	#placesList .item .marker_15 {
		background-position: 0 -654px;
	}
	
	#pagination {
		margin: 10px auto;
		text-align: center;
	}
	
	#pagination a {
		display: inline-block;
		margin-right: 10px;
	}
	
	#pagination .on {
		font-weight: bold;
		cursor: default;
		color: #777;
	}
	
	#placesList li h5 {
		font-weight: bold;
	}
	
	#save {
		width: 350px;
		height: 200px;
		position: absolute;
		top: 0;
		left: 50%;
		bottom: 0;
		overflow-y: auto;
		z-index: 1;
		margin: 120px 0px 0px 50px;
		padding: 20px 20px 10px 20px;
		background-color: rgba(255, 255, 255, 0.9);
		border-radius: 15px;
		font-size: 12px;
	}
	

	.wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 112px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info2 {width: 286px;height: 100px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info2:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info2 .title {height: 40px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info2 .title2 {padding: 7px 0 0 10px;width: 250px; overflow:hidden; text-overflow:ellipsis;}
    
    .close {position: absolute;top: -140px;right: -130px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .close:hover {cursor: pointer;}
    .info2 .body {position: relative;overflow: hidden;}
    .info2 .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info2 .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info2:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info2 .link {color: #5085BB;}
    
    .info3 {
    	background-color: #fff;
    	padding: 0 5px;
    	border: 2px solid #593196;
    	border-radius: 30px;
   	}
   	
   	#star {
   		width: 25px;
   		height: 25px;
    	background: url('resource/images/unfavorite.png') no-repeat;
    	background-size: contain;
    	border: 0px;
    	vertical-align: top;
    	margin-right: 5px;
    }
    
    .btn-secondary {
    	width: 127px;
    	height: 42px;
    	border-radius: 5px;
    	margin: 16px 8px;
    }

</style>

<div class="map_wrap">
	<div id="map"></div>
	
	<div id="save">
		<label>장소명</label>
		<input type="text" id="place-name" name="place-name"> <br>
		
		<label>주소</label>		
		<input type="text" id="address" name="address"> <br>
		
		<input type="text" id="lat" name="lat">
		<input type="text" id="lon" name="lon"> <br>
		
		<input type="submit" value="저장하기">
	</div>
	
	<div id="menu_wrap">
        <div class="option" id="top">
                <form onsubmit="searchPlaces(); return false;">
                    <div class="form-group">
  						<input type="text" class="form-control" id="keyword" placeholder="검색어를 입력해주세요." style="width:220px;float:left;">
					</div>
					<button type="submit" class="btn btn-primary" style="float:left;margin-left:10px;">Search</button>
                </form>
        </div>
			<div id="content" style="position:absolute;overflow:auto;width:350px;top:75px;">
	        	<ul id="placesList"></ul>
	        	<div id="pagination"></div>
	        </div>
        
    </div>
	    
</div>
    
    
<script>
	$(document).ready(function() {
		resizeContent();
	});
	
	$(window).resize(function() {
		resizeContent();
	});
	
	function resizeContent() {
		var totalHeight = $("#menu_wrap").height();
		<%--var topHeight = $("#top").height();--%>
		$('#content').css({'height':(totalHeight-75)+'px'});
	}
	<%--
	// --사이드 바 따라다니게--
	//follow quick menu
	$(window).scroll(function(){
		var scrollTop = $(document).scrollTop();
		if (scrollTop < 1) {
		 scrollTop = 0;
		}
		$("#menu_wrap").stop();
		$("#menu_wrap").animate( { "top" : scrollTop });
	});
	--%>
	
	// --지도 시작 현재 위치--
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 2 // 지도의 확대 레벨 
	}; 
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	//HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	if (navigator.geolocation) {
	
	// GeoLocation을 이용해서 접속 위치를 얻어옵니다
	navigator.geolocation.getCurrentPosition(function(position) {
	    
	    var lat = position.coords.latitude, // 위도
	        lon = position.coords.longitude; // 경도
	    
	    var locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다.

	    map.setCenter(locPosition); // 지도 중심좌표를 접속위치로 변경합니다
	    
	  });
	
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
	
	var locPosition = new kakao.maps.LatLng(33.450701, 126.570667);  
	
	map.setCenter(locPosition); // 지도 중심좌표를 접속위치로 변경합니다
	
	}

	// --키워드로 장소검색하고 목록으로 표출하기--
	var markers = []; // 마커를 담을 배열입니다

    var selectedMarker = null; 
    var selectOverlay = null;

	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();  
	
	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	// 키워드로 장소를 검색합니다
	searchPlaces();
	
	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {
	
	    var keyword = document.getElementById('keyword').value;
	
	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	    ps.keywordSearch( keyword, placesSearchCB); 
	}
	
	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {
	
	        // 정상적으로 검색이 완료됐으면
	        // 검색 목록과 마커를 표출합니다
	        displayPlaces(data);
	
	        // 페이지 번호를 표출합니다
	        displayPagination(pagination);
	
	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	
	        alert('검색 결과가 존재하지 않습니다.');
	        return;
	
	    } else if (status === kakao.maps.services.Status.ERROR) {
	
	        alert('검색 결과 중 오류가 발생했습니다.');
	        return;
	
	    }
	}

	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {
	
	    var listEl = document.getElementById('placesList'), 
	    menuEl = document.getElementById('menu_wrap'),
	    fragment = document.createDocumentFragment(), 
	    bounds = new kakao.maps.LatLngBounds(), 
	    listStr = '';
	    
	    // 검색 결과 목록에 추가된 항목들을 제거합니다
	    removeAllChildNods(listEl);
	
	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    for ( var i=0; i<places.length; i++ ) {
		    
			// 마커를 생성하고 지도에 표시합니다
	        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	            marker = addMarker(placePosition, i), 
	            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        bounds.extend(placePosition);

	        // 마커와 검색결과 항목에 mouseover 했을때
	        // 해당 장소에 인포윈도우에 장소명을 표시합니다
	        // mouseout 했을 때는 인포윈도우를 닫습니다
	        (function(marker, title) {
	        	// 커스텀 오버레이를 생성합니다
		        var customOverlay = new kakao.maps.CustomOverlay({
		            content: '<div class="info3">' + title + '</div>',
		            position: marker.getPosition(),
		            xAnchor: 0.5, // 컨텐츠의 x 위치
		            yAnchor: 2.7 // 컨텐츠의 y 위치
		        });

		        var customOverlay2 = new kakao.maps.CustomOverlay({
		            position: marker.getPosition(),
		            xAnchor: 0.5, // 컨텐츠의 x 위치
		            yAnchor: 1 // 컨텐츠의 y 위치
		        });
		        
		        var content = document.createElement('div'),
		       		contentStr = '<div class="wrap">' + 
			        	'<div class="info2">' + 
			        		'<div class="title">' +
			        			'<div class="title2">' + 
			        				'<button type="button" id="star">' + '</button>' + title + 
			        			'</div>' +
			        			'<div>' + 
			        				'<button type="button" class="btn btn-secondary">' + '상세보기' + '</button>' +
			        				'<button type="button" class="btn btn-secondary">' + '리뷰보기' + '</button>' +
			        			'</div>' + 
			        		'</div>' + 
			        	'</div>' +
			        '</div>';
			        content.innerHTML = contentStr;

		        var closeBtn = document.createElement('div'),
					closeStr = '<div class="close">' + '</div>';
	        		closeBtn.innerHTML = closeStr;
		        
		        closeBtn.onclick = function () {
		        	customOverlay2.setMap(null);
		        };

				<%--
		    	var content = '<div class="wrap">' + 
		        '    <div class="info2">' + 
		        '        <div class="title">' + 
		        title + 
		        '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
		        '        </div>' + 
		        '        <div class="body">' + 
		        '            <div class="img">' +
		        '                <img src="https://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
		        '           </div>' + 
		        '            <div class="desc">' + 
		        '                <div class="ellipsis">제주특별자치도 제주시 첨단로 242</div>' + 
		        '                <div class="jibun ellipsis">(우) 63309 (지번) 영평동 2181</div>' + 
		        '                <div><a href="https://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a></div>' + 
		        '            </div>' + 
		        '        </div>' + 
		        '    </div>' +    
		        '</div>';
				--%>
				
		        content.appendChild(closeBtn);
		        customOverlay2.setContent(content);
		        
		     	// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
		        function closeOverlay() {
		        	customOverlay2.setMap(null);     
		        }
		        
	            kakao.maps.event.addListener(marker, 'mouseover', function() {
     	        	customOverlay.setMap(map); // 지도에 올린다.
	            });

	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	            	customOverlay.setMap(null);
	            });

	            kakao.maps.event.addListener(marker, 'click', function() {
	            	//$(".item").trigger("click");
	            	if (selectOverlay) {
	            		selectOverlay.setMap(null);
	            	}
	            	customOverlay2.setMap(map);
	            	selectOverlay = customOverlay2;

					//itemEl.style.backgroundColor="yellow";
		        });

	            kakao.maps.event.addListener(marker, 'click', function(idx) {
	            	// 클릭된 마커가 없고, click 마커가 클릭된 마커가 아니면
		            // 마커의 이미지를 클릭 이미지로 변경합니다
		            if (!selectedMarker || selectedMarker !== marker) {
			            imageSrc = 'resource/images/marker_number_orange.png';
			            imageSize = new kakao.maps.Size(36, 37);  // 마커 이미지의 크기
	        	        imgOptions =  {
	        	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	        	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	        	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        	        };
	
	        	        clickImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);
	        	     	// 클릭한 마커의 위도, 경도 정보를 가져옵니다 
           			    var latlng = marker.getPosition();
           				document.getElementById('lat').value = latlng.getLat();
           				document.getElementById('lon').value = latlng.getLng();
           				document.getElementById('place-name').value = title;
           				
           				var geocoder = new kakao.maps.services.Geocoder();

           				var coord = new kakao.maps.LatLng(latlng.getLat(), latlng.getLng());
           				var callback = function(result, status) {
           				    if (status === kakao.maps.services.Status.OK) {
           				    	document.getElementById('address').value = result[0].address.address_name;
           				    }
           				};

           				geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
           				
	        	     	// 클릭된 마커 객체가 null이 아니면
		                // 클릭된 마커의 이미지를 기본 이미지로 변경하고
		                if (!!selectedMarker) {
		                	
		                	imageSrc = 'resource/images/marker_number_purple.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		                	imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
		        	        imgOptions =  {
		        	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		        	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		        	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        	        };
		        	        
		        	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);
		        	        
		                	selectedMarker.setImage(markerImage);
			            } 
		                
	                	marker.setImage(clickImage);
		            }

		         	// 클릭된 마커를 현재 클릭된 마커 객체로 설정합니다
		            selectedMarker = marker;
	            });

	            //itemEl.onmouseover =  function () {
	            //    displayInfowindow(marker, title);
	            //};
			        
	            //itemEl.onmouseover =  function () {
	            //	this.style.backgroundColor="#ded6ea";
	 	        //};
	 	        
	            //itemEl.onmouseout =  function () {
	            //	this.style.backgroundColor="";
	 	        //};
	 	        
	 	        <%--
	            itemEl.onclick = function () {
	            	if (selectOverlay) {
	            		selectOverlay.setMap(null);
	            	} 
		            //this.style.backgroundColor="yellow";
	            	customOverlay2.setMap(map);
	            	selectOverlay = customOverlay2;

	     			//document.getElementsByClassName('item')[1].style.backgroundColor="#ded6ea";
		 	    };
		 	    --%>
		 	    
		 		itemEl.onclick = function (idx) {
		 			if (selectOverlay) {
	            		selectOverlay.setMap(null);
	            	} 
		            //this.style.backgroundColor="yellow";
	            	customOverlay2.setMap(map);
	            	selectOverlay = customOverlay2;
	            	
					if (!selectedMarker || selectedMarker !== marker) {
						imageSrc = 'resource/images/marker_number_orange.png';
						imageSize = new kakao.maps.Size(36, 37);  // 마커 이미지의 크기
					    imgOptions =  {
					        spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
					        spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
					        offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
					    };
					
					    clickImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);
					 	// 클릭한 마커의 위도, 경도 정보를 가져옵니다 
           			    var latlng = marker.getPosition();
           				document.getElementById('lat').value = latlng.getLat();
           				document.getElementById('lon').value = latlng.getLng();
           				document.getElementById('place-name').value = title;
           				
           				var geocoder = new kakao.maps.services.Geocoder();

           				var coord = new kakao.maps.LatLng(latlng.getLat(), latlng.getLng());
           				var callback = function(result, status) {
           				    if (status === kakao.maps.services.Status.OK) {
           				    	document.getElementById('address').value = result[0].address.address_name;
           				    }
           				};
           				
           				geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
			 	   
						if (!!selectedMarker) {
							imageSrc = 'resource/images/marker_number_purple.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
							imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
							imgOptions =  {
								spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
								spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
								offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
							};
		        	        
		        	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);
		                	selectedMarker.setImage(markerImage);
			            } 
	       	    	marker.setImage(clickImage);
		 		}
		 		// 클릭된 마커를 현재 클릭된 마커 객체로 설정합니다
	            selectedMarker = marker;
			 	   
			 	};
	 	        
	            //itemEl.onmouseout =  function () {
	            //    infowindow.close();
	            //};
	        	            
	        })(marker, places[i].place_name);
	
	        fragment.appendChild(itemEl);
	    }

	    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;
	
	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	    map.setBounds(bounds);
	}


	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {
	
	    var el = document.createElement('li'),
	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                '<div class="info">' +
	                '   <h5>' + places.place_name + '</h5>';
	
	    if (places.road_address_name) {
	        itemStr += '    <span>' + places.road_address_name + '</span>' +
	                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '    <span>' +  places.address_name  + '</span>'; 
	    }
	                 
	      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	                '</div>';           
	
	    el.innerHTML = itemStr;
	    el.className = 'item';
	
	    return el;
	}
    <%--
	$(document).on("click", ".item", function() {
	    this.style.backgroundColor="#ded6ea";
	});
	--%>
	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
	    var imageSrc = 'resource/images/marker_number_purple.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        	imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });
	
	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
	
	    return marker;
	}
	
	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}

	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('pagination'),
	        fragment = document.createDocumentFragment(),
	        i; 
	
	    // 기존에 추가된 페이지번호를 삭제합니다
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }
	
	    for (i=1; i<=pagination.last; i++) {
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;
	
	        if (i===pagination.current) {
	            el.className = 'on';
	        } else {
	            el.onclick = (function(i) {
	                return function() {
	                    pagination.gotoPage(i);
	                }
	            })(i);
	        }
	
	        fragment.appendChild(el);
	    }
	    paginationEl.appendChild(fragment);
	}

	<%--
	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
		var content = '<div class="info-title">' + title + '</div>';
	
	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	}
	--%>

	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}

</script>
</body>
</html>