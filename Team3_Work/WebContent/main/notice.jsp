<%@page import="myUtil.HanConv"%>
<%@page import="java.util.Calendar"%>
<%@page import="student.StudentDBBean"%>
<%@page import="schedule.ScheduleBean"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.*"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="board" class="board.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Document</title>

<link href="../css/notice_sty.css" rel="stylesheet" type="text/css">
<link href="../css/menu.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../3/script.js" charset="utf-8"></script>
<style>
section {
   height: 80vh;
   display: block;
}

footer {
   clear: both;
   display: block;
}

footer {
   text-align: center;
}
.blank {
	height: 50px;
}
#contents{
   padding-left: 300px;
   border-left: #dddddd solid 1px; 
}
/* 달력 */
#cal {
   width: 20%;
   height: 50%;
   margin: auto 30px;
   float: left;
}

table {
   width: 100%;
   border-collapse: collapse;
}

.cth {
   width: 40px;
   height: 40px;
   color: white;
   background-color: #11264f;
   text-align: center;
}

.ctd {
   width: 40px;
   height: 40px;
   text-align: center;
}

.calendar {
   width: 280px;
}

#month {
   padding: 5px;
   background-color: #11264f;
   color: white;
   font-weight: bold;
   height: 40px;
   line-height: 40px;
   font-size: 30px;
   padding-left: 10px;
   margin-bottom: 0;
}

.today {
   background-color: #11264f;
   border-radius: 50px;
   color: white;
   font-weight: bold;
}
</style>
</head>
<body>
   <%
// 세션 가져오기
	String stu_name = request.getParameter("stu_name"); 
	BoardDBBean db = new BoardDBBean();

	ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();

	// 페이징 처리
	String pageNUM = request.getParameter("pageNUMN");
	if (pageNUM == null) {
		pageNUM = "1";
	}
	// 검색어가 있을 경우, 값을 받아서 변수에 저장
	if(request.getParameter("search") != null){
		String search_col = HanConv.toKor(request.getParameter("search_col"));
		String search = HanConv.toKor(request.getParameter("search"));
		boardList = db.getListBoard(search_col, search, 4, pageNUM);
		
	}else{
		
		boardList = db.getListBoard("", "", 4, pageNUM);
	}



   String comm_title;

   Timestamp comm_date;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   int comm_index = 0;
   int comm_groupn = 0;
   int comm_step = 0;
   %>


<div id="content">
   <section class="notice">
      <div class="clear">
         <article>
            <!--1-->
            <div class="temp">
               <h2>학사 공지</h2>

               <%
                  for (int i = 0; i < 7; i++) { // 5개까지만(공지는 답댓 기능이 없어서 단순 for문으로 처리)

                  board = boardList.get(i);
                  comm_index = board.getComm_index();
                  comm_groupn = board.getComm_groupn();
                  comm_title = board.getComm_title();
                  comm_date = board.getComm_date();

                  SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
                  String inputDate = sf.format(comm_date);
                  String now = sf.format(new Date());

                  if (comm_groupn == 4) {
               %>
               <ul>
                  <li>
                  <a class="a" href="../3/comm_Show.jsp?comm_index=<%=comm_index%>&pageNUM=<%=pageNUM%>">
                  <span> 
                  <%
                      if (inputDate.equals(now)) {
                   %>
                    <img alt="" src="../css/new.png" height="22" width="25">  &nbsp;&nbsp;
                   <%
                      }
                   %>
                  <%=comm_title%></span>
                        <p><%=sdf.format(comm_date)%></p> 
                     </a>
                     </li>
                  <%
                     }
                  }
                  %>
               </ul>
               <a class="a1" href="../2/stu_Notice.jsp">더보기</a>
            </div>
         </article>


		
         <!--2-->
         
         <div id="cal">
            <div class="calendar">
               <h3 id="month"></h3>
               <table>
                  <thead>
                     <tr>
                        <th class="cth">일</th>
                        <th class="cth">월</th>
                        <th class="cth">화</th>
                        <th class="cth">수</th>
                        <th class="cth">목</th>
                        <th class="cth">금</th>
                        <th class="cth">토</th>
                     </tr>
                  </thead>
                  <tbody id="calendar-body"></tbody>
               </table>
            <!-- calendar END -->
         
         <div class="blank"></div>
         
         
         <div class="calendar">
			<table>
         		<tr calss="trbody">
         <%
			StudentDBBean student = StudentDBBean.getInstance();
			ArrayList<ScheduleBean> viewlist = null;
			
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			viewlist = student.ScheduleView(true, year);
			
			System.out.println(viewlist.size());
			
			int month = cal.get(Calendar.MONTH)+1;
	
			for (int i = 0; i < viewlist.size(); i++) {
				ScheduleBean view2 = viewlist.get(i);
	
				int start_year = view2.getShce_startyear();
				int start_month = view2.getShce_startmonth();
				int start_day = view2.getShce_startday();
				int end_month = view2.getShce_endmonth();
				int end_day = view2.getShce_endday();
				int holiday = view2.getShce_holiday();
				String content = view2.getSche_content();
				
				if(month == end_month && month == start_month){
					if(start_month == end_month && start_day == end_day){
				%>
					<tr calss="trbody">
					<td class="pdate"><%=start_month%>&nbsp;.<%=start_day %></td>
					<td class="pdesc"><%=content%></td>
				</tr>
				
				<%
					
					}else{
						%>
						<tr calss="trbody">
						
						<td class="pdate">
							<%=start_month%>&nbsp;.<%=start_day %> ~
							<%=end_month%>&nbsp;.<%=end_day %>
						</td>
						<td class="pdesc"><%=content%></td>
					
					</tr>
					<%
					}
				}
					
					}
				%>
        	 </table>
        	 </div>
         
         
         </div>
         <!-- cal END -->
      </div>
      <!-- clear END -->
   </section>
</div>
</body>
<script>
    monthAndYear = document.getElementById("month");
    showCalendar();

    function showCalendar() {
        let today = new Date();
        let year = today.getFullYear(); // 년도
        let month = today.getMonth(); // 월
        let firstDay = new Date(year, month).getDay();

        tbl = document.getElementById("calendar-body");

        tbl.innerHTML = "";

        // 달력위에 년도, 월 표시
        monthAndYear.innerHTML = year + "." + (month + 1);

        // 달력 테이블 생성
        let date = 1;
        for (let i = 0; i < 6; i++) {
            let row = document.createElement("tr");

            for (let j = 0; j < 7; j++) {
                if (i === 0 && j < firstDay) {
                    cell = document.createElement("td");
                    cellText = document.createTextNode("");
                    cell.classList.add("ctd");
                    cell.appendChild(cellText);
                    row.appendChild(cell);
                } else if (date > daysInMonth(month, year)) {
                    break;
                } else {
                	  cell = document.createElement("td");
                      cellText = document.createTextNode(date);
                      <%for(int i=0; i < viewlist.size(); i++){%>
                      if (date >= <%=viewlist.get(i).getShce_startday() %> && date <= <%=viewlist.get(i).getShce_endday() %>) {
                         <%if(viewlist.get(i).getShce_holiday() == 1){%>
                    	  cell.style.color = "red";
                    	  <%}else{%>
                    	  cell.style.color = "blue";
                    	  <%}%>
                         cell.style.fontWeight = "bold";
                      }
                   <%}%>

                  if (date === today.getDate()
                        && year === today.getFullYear()
                        && month === today.getMonth()) {
                        cell.classList.add("today");
                    }
                    cell.classList.add("ctd");
                    cell.appendChild(cellText);
                    row.appendChild(cell);
                    date++;
                }
            }
            tbl.appendChild(row);
        }
    }
    
    function daysInMonth(iMonth, iYear) {
        return 32 - new Date(iYear, iMonth, 32).getDate();
    }
</script>
</html>



