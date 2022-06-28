<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.status-grey::after{
    content: "";
    width: 1px;
    height: 12px;
    border-right: 1px solid rgb(238, 238, 238);
    margin-left: 10px;
    margin-right: 10px;
}

</style>
</head>
<body>
<section class="eeRGVw">
	<div style="width: 1280px; margin: 0 auto;">
		<div style="display: flex;
					padding-bottom: 30px;
	    			border-bottom: 1px solid rgb(238, 238, 238);"><!-- 상단 -->
			<div style="width: 40%;margin-right: 40px;"><!-- 상단왼쪽 -->
				<div style="height: 70%;"><!-- 대표사진 -->
					대표사진<img alt="" src="">
				</div>
				<br>
				<div style="height: 30%">
					<div style="display: flex; justify-content: space-between;"><!-- 버튼 -->
						<div style="display: flex; height: 56px; width: 200px;
									margin-right: 10px;
									align-items: center;justify-content: center;">
							<button style="width: 100%; height: 100%;
											background: rgb(204, 204, 204); color: white;
											border:1px solid;font-weight: 600;font-size: 18px;">
								<img width="16" height="16" 
								src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxwYXRoIGZpbGw9IiNGRkYiIGZpbGwtcnVsZT0ibm9uemVybyIgZD0iTTcuMDA1IDEuMDQ1aC4yMzNjLjI4LjIyOC41MzcuNDkuNzYyLjc3Ny4yMjUtLjI4OC40ODEtLjU0OS43NjItLjc3N2guMjMzYTYuMTYgNi4xNiAwIDAgMC0uMDktLjExM0M5LjY4NC4zNDQgMTAuNjI4IDAgMTEuNiAwIDE0LjA2NCAwIDE2IDIuMTEgMTYgNC43OTZjMCAzLjI5Ni0yLjcyIDUuOTgxLTYuODQgMTAuMDYyTDggMTZsLTEuMTYtMS4xNTFDMi43MiAxMC43NzcgMCA4LjA5MiAwIDQuNzk2IDAgMi4xMSAxLjkzNiAwIDQuNCAwYy45NzIgMCAxLjkxNi4zNDQgMi42OTUuOTMyYTYuMTYgNi4xNiAwIDAgMC0uMDkuMTEzeiIvPgo8L3N2Zz4K">
								<span>찜</span>
								<span>0</span>
							</button>
						</div>
						<button style="	width: 200px;
										background: rgb(255, 164, 37); color: white;
										border: 1px solid;font-weight: 600;font-size: 18px;">
						연락하기</button>
					</div>
				</div>
			</div>
			
			<div style="width: 60%;"><!-- 상단오른쪽 --><!-- 상품정보 -->
				<!-- 제목/가격 -->
				<div style="padding-bottom: 30px;
	    					border-bottom: 1px solid rgb(238, 238, 238);">
					<div style="font-size: 24px;margin-bottom: 25px;
								font-weight: 600;line-height: 1.4;">
					글제목
					</div>
					<div style="font-size: 40px; font-weight: 500;">
					가격
						<span style="font-size: 28px;font-weight: 400;
									margin-left: 5px;">
						원</span>
					</div>
				</div>
				<!-- 찜/조회수/시간 -->
				<div style="display: flex; font-size: 16px;
							margin-top: 15px; margin-bottom: 25px;
							color: rgb(204, 204, 204);">
					<div class="status-grey" style="display: flex; align-items: center;">
						<img style="margin-right: 5px;" width="16" height="16" 
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAjhJREFUWAnFl1uPKUEUhbdCxF2Iu7h78f9/ixdexANeSNxCkJnz1ZwSRncrM0OvhK6ufVmrdiu1O/DxD/INq9VKFouFbDYbOR6PEggEJBKJSDqdlkKhIKFQ6FvE1+3pdJL5fC7EHw4HIXU4HJZEIiHZbFZSqdRdXOBaAEHj8VjW6/Wdo5kIBoNSLBalVCppYcxDNJvNNPn5fDaud9dkMimNRkMvxhgvAna7nQyHQ2EVNmBV3W5Xu45GI10tmziq1+v1JBaLaXctANLBYKDLbZPE+MTjcT3cbrdmyurKY+n3+/pRKiImk8nT5MRB/Cw5cfyu4ARqv9/LcrnUN+/8ghNuxcBhI7xcC5xwK7aMX4BbsfX8AtzKa9++Whjcij8WvwC3Yk/6BbiV+TPxQwTcKpPJ+MGtOeFWHBB+PAY44VYctZxu7waccOuzIJ/Pv7UKrB5OoAUopfQ5/a4q0BPAeRHAgG4nl8vpyVd+wQGXwZeM/3f1el2i0aix/fmV3HBc40YAZel0Oq4933Xgs2M6IXKb0pv4GwFM0ny22+1Lv2ccf3Pl195qtW56QZPvTgAG9mez2fwTEZCTy6kjhstRAAba6FqtxvBXIAe53OAqgADeASqVilvsw3liyeEFTwEElstl/fFK4mSzjXsogOSshBcRW+BrWzkrARBXq1UrEZDjawtrAUYEpXXDs+TkeUoAAZTWScRPyMnn/JqLxQPm+U6nU+2FIDPnEeZourycOlofTF4LeODqav4EUxqvNxGf2nsAAAAASUVORK5CYII=">
						<div>
						찜
						</div>
					</div>
					<div class="status-grey" style="display: flex; align-items: center;">
						<img style="margin-right: 5px;" width="21" height="13" 
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACwAAAAaCAYAAADMp76xAAAAAXNSR0IArs4c6QAABAdJREFUWAm9mFtIFFEYx9tZ11UW1tLoaoGEPShqq3ahgogyIgnqQXqIgih6qKgEH4JIqCgIIoowIrSn6i0irOxCQdAN7wb2IiSlSUZuGJGyumu/b9lZZo8zs7ObdeBwvvNd/uc/53zznWFcs9Js7e3tczVNWzs1NbUKiErGfJfLNYcxVyCRg8g/GAeZdiC3eTyeN2VlZd/Enm5zpRLY09Pjm5yc3EnMbghUMbpTiYd8BP8X9Dt+v/9uYWHhz1TixdcR4YGBgezh4eFD+J+gz5XAGWijYFzKycm5nArxpIQ5+hqAr9AXzgBJM4ggqXWyvLz8uplR1VkShmgOR3iVo9+jBv2LOWs9pu+H+JAdvilhyC4j6AldxqSNhT7g1Oh2u59mZWV9loDx8fGl4XB4C+IBHrpIdA7ad7C2V1RUvLPynUa4u7s7wIvVQsB8qyCDfgK5jgUaWChs0MdFyLo7OjoOo7hI98QN1sJvsHaB+cDMJYFwV1fXCnblJY5+M2dFN8GOVgcCgWeK3nQKdhXYDzE6IR2GdA2k76lgmq7o7OxcBGAzcydkJazOKVlxjvnWieyguTmZ25y21PiEFt3h/v7+rJGRkddYyhOsFhOe/gMvR6lVGliEzZL0YGPep5DTw16vd2VJScmAjhnd4WAweBaFI7KxwEaVLCQyIHOafB2ULrLo9IVkjMU0GnVJ5PmhUOim0UejIqwGuNaoTCZLNVB9yNFTkUikHqzF0kUWnepnFqv6GOdgbWYDDuo6jaduYOLWFU5Gvgk+qX4A73ei08ue6ms3B/ui3LbiozExLUd2AOxSQnWx850h2+f8/PyQYGksfoRxMhVguRRUf06qyYnOLFaNM87BjdAP0KMbq1Fu2phcMDolk2M3WIIbOGf5JjgD1hfpIosuwYmJWazqo8yvGG++6NH29vZmjo2NPcdxveJsOoXQ/yprXcKpsrLyt04kWtaKi4tDPp9vB0T6dIPdSN4Xxa5bO7dpNomR2GkGEwVchjIyMrYbyYpbwstDGSqkHL0CdJ4Jhqr6l1ezfNhvhGynumj8ahYDOSc7vI7+UeZJmke+DajjR3lAy7IoNvERX/CcfEd8pRBsMCMrfBJ2WCdITi8gpx8xD+g6u1FyGvtff15KSlLjt5aWllpumClhIdfX1+cdHR09D0gtu2TpZ/cgKdqasrOzj/M+/bKLS0qEb4JN5PU1QJbbAaVrY0M+UQKPkY73nWAkJSwgkoe84fsQ6+lLRDcD7Stkz3FV35Aq5RTPEWEdLFavt7HQXnTVPEimbnM4ThDbQtytvLy85oKCgnGHcXG3lAjHoxAogbNJlTWIq6VDQn6k5DLmih+y/EgJMsqPlFaOvZW3/y0v1A+xp9v+ADhPuomDsZuZAAAAAElFTkSuQmCC">
						<div>
						조회수
						</div>
					</div>
					<div style="display: flex; align-items: center;">
						<img style="margin-right: 5px;" width="16" height="16" 
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAuRJREFUWAnFV01rE1EUzUwSMWATENpFRNyIi0YI+eiui4LoogWFgkvBH6Dgpip+dONKgivdC3XlpkWELkTQRVw1H4QwWQmhLrKwq1IwxHyM54zvDck4mc6bTO3AY97MO/eeM/e9d+c+LeLzqlQq8Wg0ujIajW6ZprkIs7SmaRfQN9HvsOG5pev6h+Fw+LVYLPb9uNaOAzUajYXBYPAcPHeATR2HF+OHEPMuFou9yGazP71spgowDONMt9t9BOMNtDkvJx5jRxgrJRKJl5lM5rcbzlVArVabR6i3YbDsZhTgXRlTs57P5w+ctv8IAPkiwr2LdskJnuUZU7KPtgoRrXE/EwL45SDeC5tcEgoRS+OR0OUg55xhPyly8tA3OcgleW0BYsEpzTnm9THaknTm874suCy4JYBbDU9c7UoXvugzwllRMvoL3hCcEUsA9zneB91qAfgjc4IzojPD4UuYZP7rRU5y60yvYPab4cIUmSK3ztweplcVX+TWEYqMilGYWHJzEabDdKroK60jO52aAHLbiUhReShwTIHJNcBiYqYLX/IxoIMOIxBYANLweRIXCoWb2FJrEPJdUUiHa8BQNLLh2EY7+IM+a7fbZ3O53G4ymbwKf08B+GWDPDrAtrR6vX4dNdwnD5yfoR9w9hCReE9ws9m82Ov1XqF728sYUbuhMR0CxEoljGz4DdPyQP6gqtXqXayxt1NEHOL9vFWQAPgawHtTgEqvEQm4Mrcg5An6VxDdL24OMPYGEbtvCeCvsd/vcwGF+UdkZRyFmHMuAo7i8fhlVsxWHhClc8kFOMur1BRy+izJct1ORCydMVCehdGnbVlwWXBbAOt2zNs6wrbv05EyjL7JMX5GsAXQG6tVgFZPQgR90vd4RUzOCQFCRAtAFpphTkeZPkE+cSZwFSBEHGCerqG/icbjVdCLtpv05fxy6dDahvLB7X5qh1OnGMfxnFUUj+dWLYHtJo/nBhaZ0vH8D6NELRJSWvu9AAAAAElFTkSuQmCC">
						<div>
						시간
						</div>
					</div>
				</div>
				<!-- 거래지역 -->
				<div style="display: flex">
					<div style="width: 90px; color: rgb(153, 153, 153);">
					거래지역
					</div>
					<div style="display: flex; align-items: center;">
						<img style="padding-right: 10px;" width="12" height="15"
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAeCAYAAAA2Lt7lAAAAAXNSR0IArs4c6QAAA0VJREFUSA2tVktoE0EYnmwejUlDCYUcJD3YGooJGA1RYgJtKh6KtJ6q+EAvvQn25EnEHjx56qGgCJ5EPCqIBxE1j/YmiFJSYkvQBiExqRRJNNGkid+/uMvsdjZJtQOT+Z/fN/+/M7sxsQ4jkUgcNJlMV9rtdhTrEEK9mD8x85ifYX/qcrmehMNhsgmHSWRNpVKHkHwXMy7y8zYQVyjW6/XO+3y+X7yP5B0EyWRyDvY7SLLrgzvpIFrBvDQ+Pr7Cx2kI0JKbcN7mA3Yjg2ALG4tOTExklTyVADu/DOdDxfGvK0g+2e32E5FI5CthSPSzvLy8H8t9kv93YJMH6vX6ooIjEzQajVtw7FOMe7DOpNPpEOFIODFDKGt2D0BVCGzW1Gq15mUCKJOYFtW7C6Gvr48NDw8zbFCUdSqTydgI+KTI281GoH6/nw0MDMgEuVxOk4JNO0ql0nEJwlGNp0dlZGREBscDZRsbG8IsbOKwhB+ryEs7xHETuZjH42G4uQx9ZmgDazabwjgY21SBWe9Vyg+FQszpdGrcDoeDjY6Oyrb19XVWqVQ0fl4BzjYd0y+8kZdtNhsLBoMqidlsZoFAgNFaLBZZoVDgw3fIIMhRi1J6D6piq6urrFwuM56Edk4VVatVtra2pk/T6MCtDg4OLlGLEhrPX0VPQu2i3lO/qe/U/y7jFar9LcXj8TcI/CgK5kmoLTSy2Syr1WqicI1NkqRHZKAWtaDc0Hg5hSfJ5/Nsc3OT8xqKH3AYnpFXvYJ4mz4G2AWjFGyEEVm3gbgtq9V6LBaLyTdPftlREh7mLJxvjQB6BG+iG2cVcMJSCaLRaA0gZ0CSNyLpwT43Njb2mo9TCciIL1ERBFOYxreHz+Zk5CziwNzjTLKoPgPegU/nJPTnmDtuOR+nyAB/iW/xaazbik1ZNRUoRlTyAsHXFL3Tirhsf3//ORE45QkJyEHlImmB5A7jG07MFP4XfTeKMSSgBJR9HSTyedYDwN6AbYY/MfoY0jsSAKTldrsvYn2nT8aJu4pWJvV2vd6RgILxNv1hsVimQaK+dSEvAPyBHkykC0+RKBAn6wiAl+BLo3VE2PVtRzhdK1DIsOP3aMs0qjnfKzjl/gFgkydRSXu9AAAAAABJRU5ErkJggg==">
						지역
					</div>
				</div>
				<!-- 상세정보 글 -->
				<h4 style="border-bottom: 1px solid rgb(238, 238, 238);
							padding-bottom: 30px;">상품정보</h4>
				글내용~~
			</div>
		</div>
		
		<div><!-- 하단 -->
			<div style="padding-top: 30px">
				사진목록
			</div>
		</div>
	</div>
</section>
</body>
</html>