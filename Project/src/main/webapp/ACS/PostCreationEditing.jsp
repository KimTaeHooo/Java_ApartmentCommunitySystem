<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dbsql.DBSQL"%>
<%@ page import="table.Post"%>
<%@page import="java.sql.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>게시글 생성 및 수정 화면</title>
</head>
<body>
	<%@include file="nav.jsp"%>

	<form id="postForm" action="PostCreationEditing.jsp" method="post">
		<div class="container mt-3">
			<!-- 체크박스를 게시글 내용 우측에 추가 -->
			<div class="col-md-3">
				<input type="radio" id="noticeRadio" name="postType" value="notice">
				<label for="noticeRadio">공지</label> <input type="radio"
					id="idlechatRadio" name="postType" value="idlechat" checked>
				<label for="idlechatRadio">잡담</label>
			</div>
		</div>
	</form>
	<div class="container mt-3">
		<!-- 텍스트 박스 -->
		<div class="mb-3">
			<label for="postTitle" class="form-label">제목</label>
			<textarea class="form-control" id="postTitle" rows="1"></textarea>
		</div>
		<!-- 글꼴, 크기, 글 색상 설정 -->
		<div class="row">
			<div class="col-md-4">폰트</div>
			<div class="col-md-4">사이즈</div>
			<div class="col-md-4">색</div>

			<div class="col-md-4">
				<select id="fontSelect" class="form-select form-select-sm"
					aria-label=".form-select-sm example">
					<option value="Font" selected>Font</option>
					<option value="'Arial, sans-serif'">Arial</option>
					<option value="'Times New Roman, serif'">Times New Roman</option>
					<option value="'Courier New, monospace'">Courier New</option>
				</select>
			</div>
			<div class="col-md-4">
				<select id="sizeSelect" class="form-select form-select-sm"
					aria-label=".form-select-sm example">
					<option value="Size" selected>Size</option>
					<option value="'12px'">12</option>
					<option value="'14px'">14</option>
					<option value="'16px'">16</option>
				</select>
			</div>
			<div class="col-md-4">
				<select id="colorSelect" class="form-select form-select-sm"
					aria-label=".form-select-sm example">
					<option value="Color" selected>Color</option>
					<option value="'black'">검정</option>
					<option value="'red'">빨강</option>
					<option value="'blue'">파랑</option>
				</select>
			</div>
		</div>
	</div>

	<form id="postForm" action="PostCreationEditing.jsp" method="post">
		<div class="container mt-3">
			<!-- 텍스트 박스 -->
			<div class="mb-3">
				<label for="postContent" class="form-label">게시글 내용</label> <small
					id="postLengthInfo" class="form-text text-muted">최대 2000자까지
					입력 가능합니다.</small>
				<textarea class="form-control" id="postContent" rows="20"
					oninput="checkPostTextLength()" maxlength="2000"></textarea>
				<div class="col-md-3">이미지 삽입</div>
				<div id="postImg" contenteditable="true"
					style="border: 1px solid #ccc; padding: 10px; background-color: #f7f7f7; width: auto; height: 200px; font-family: Arial, sans-serif; font-size: 14px; color: #333; line-height: 1.6;"></div>
			</div>
		</div>
	</form>
	<div class="container mt-3">
		<button onclick="applyFontAndSize()">Apply Style</button>
		<button onclick="preview()">Preview</button>
		<div id="previewArea"></div>
		<!-- 확인 버튼 -->
		<button type="submit" class="btn btn-primary" id="btnConfirm">확인</button>
	</div>


	<script>
		function checkPostTextLength() {
			var postInput = document.getElementById("postContent");
			var postLength = postInput.value.length;
			var maxLength = 2000;
			var postLengthInfo = document.getElementById("postLengthInfo");

			if (postLength > maxLength) {
				postInput.value = postInput.value.substring(0, maxLength);
				postLengthInfo.textContent = "최대 2000자까지 입력 가능합니다. (현재 "
						+ maxLength + "자)";
			} else {
				postLengthInfo.textContent = "최대 2000자까지 입력 가능합니다. (현재 "
						+ postLength + "자)";
			}
		}

		// 생성, 수정 구분 값.
		var editing = false;
		// postid를 URL 파라미터로부터 가져와서 처리.
		const urlParams = new URLSearchParams(window.location.search);
		const postId = urlParams.get("postid");
		const postid = urlParams.get("postid");
		console.log("editing:", editing);
		console.log("postid:", postid);
		function applyFontAndSize() {
			var selectedFont = $("#fontSelect").val();
			var selectedSize = $("#sizeSelect").val();
			var selectedColor = $("#colorSelect").val();
			var textArea = document.getElementById("postContent");
			var selectedText = textArea.value.substring(
					textArea.selectionStart, textArea.selectionEnd);

			console.log("Selected font:", selectedFont);
			console.log("Selected size:", selectedSize);
			console.log("Selected color:", selectedColor);
			console.log("Selected text:", selectedText);

			if (selectedFont == "Font" && selectedSize == "Size"
					&& selectedColor == "Color") {
				alert("스타일을 선택해 주세요.");
				return;
			}

			if (!selectedText) {
				alert("텍스트를 선택해 주세요.");
				return;
			}

			var styleText = "";
			if (selectedFont != "Font") {
				styleText += 'font-family:' + selectedFont.replace(/'/g, "")
						+ ';'; // 따옴표 제거
			}
			if (selectedSize != "Size") {
				styleText += 'font-size:' + selectedSize.replace(/'/g, "")
						+ ';'; // 따옴표 제거
			}
			if (selectedColor != "Color") {
				styleText += 'color:' + selectedColor.replace(/'/g, "") + ';'; // 따옴표 제거
			}

			console.log("styleText:", styleText);

			if (styleText) {
				var styledText = '[style ' + styleText + ']' + selectedText
						+ '[/style]';
				console.log("styledText:", styledText);
				console.log("styleText:", styleText);
				console.log("selectedText:", selectedText);
				var updatedText = textArea.value.substring(0,
						textArea.selectionStart)
						+ styledText
						+ textArea.value.substring(textArea.selectionEnd);
				textArea.value = updatedText;
			}
		}

		function preview() {
			var textArea = document.getElementById("postContent");
			var content = textArea.value;
			content = content.replace(/\[style (.*?)\]/g, function(_, style) {
				return '<span style="' + style + '">';
			});
			content = content.replace(/\[\/style\]/g, '</span>');
			document.getElementById("previewArea").innerHTML = content;
		}

		// 확인 버튼 클릭 이벤트 처리
		document
				.getElementById("btnConfirm")
				.addEventListener(
						"click",
						function() {
							var textArea = document
									.getElementById("postContent");
							var titleArea = document
									.getElementById("postTitle");
							var imgDiv = document.getElementById("postImg");
							var postContent = textArea.value;
							var postTitle = titleArea.value;
							var postImg = imgDiv.innerHTML;
							var notice = document.getElementById("noticeRadio").checked;
							var confirmed = confirm("확인 버튼을 누르면 게시글을 저장합니다. 계속하시겠습니까?");

							if (confirmed) {
								// AJAX 요청을 보냅니다.
								$
										.ajax({
											url : "Post.jsp",
											method : "POST",
											data : {
												postId : postId,
												postContent : postContent,
												postTitle : postTitle,
												postImg : postImg,
												notice : notice,
												btnConfirm : "true",
												editing : editing
											},
											success : function(response) {
												// 요청이 성공적으로 처리되었을 때 실행되는 코드
												console
														.log("요청이 성공적으로 처리되었습니다.");
												console
														.log("서버 응답: ",
																response); // 브라우저 콘솔에 서버 응답 기록
												console
														.log("editing:",
																editing);
												if (editing == false)
													window.location.href = "MainView.jsp";
												else
													window.location.href = "Myinfo.jsp";
											},
											error : function(xhr, status, error) {
												// 요청이 실패하거나 에러가 발생했을 때 실행되는 코드
												console.error("요청이 실패하였습니다.");
												console.error(xhr, status,
														error);
											}
										});
							}
						});

		function insertImage() {
			var textArea = document.getElementById("postContent");
			textArea.value += "\n"; // 이미지 첨부 후 줄 바꿈 처리
		}

		// 이미지 드래그 앤 드랍
		var editor = document.getElementById('postImg');

		editor.addEventListener('dragover', function(e) {
			e.stopPropagation();
			e.preventDefault();
			e.dataTransfer.dropEffect = 'copy';
		});

		editor.addEventListener('drop', function(e) {
			e.stopPropagation();
			e.preventDefault();

			var files = e.dataTransfer.files;
			var file = files[0];

			if (file.type.match('image.*')) {
				var reader = new FileReader();

				reader.onload = function(e) {
					var img = document.createElement('img');
					img.src = e.target.result;
					editor.appendChild(img);
				};

				reader.readAsDataURL(file);
			}
		});

		$(document).ready(
				function() {
					// AJAX 요청을 보내서 데이터를 가져옴
					$.ajax({
						url : "PostDetailsView.jsp", // 데이터를 가져올 서버의 URL
						type : "POST",
						data : {
							postid : postid
						},
						success : function(response) {
							// 요청이 성공적으로 처리되었을 때 실행되는 코드
							const $responseHtml = $(response);
							//console.log(response);
							// 각 input 요소의 값을 가져와서 변수에 저장
							const postTitle = $responseHtml.find(
									'input[name="postTitle"]').val();
							const postContent = $responseHtml.find(
									'input[name="postContent"]').val();
							const postType = $responseHtml.find(
									'input[name="postType"]').val();
							

							console.log(postTitle);
							console.log(postContent);
							console.log(postType);
							$("#postTitle").val(postTitle);
							$("#postContent").val(postContent);
							if (postType == "공지") {
								$("#noticeRadio").prop("checked", true);
							} else if (postType == "잡담") {
								$("#idlechatRadio").prop("checked", true);
							} else if (postType == "일정") {
								$("#ScheduleRadio").prop("checked", true);
							}
							//$("#postType").val(postType);
							editing = true;
							console.log("editing:", editing);
						},
						error : function(xhr, status, error) {
							// 요청이 실패하거나 에러가 발생했을 때 실행되는 코드
							console.error("요청이 실패하였습니다.");
							console.error(xhr, status, error);
						}
					});
				});
	</script>
</body>
</html>