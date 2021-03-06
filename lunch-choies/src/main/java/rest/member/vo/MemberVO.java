package rest.member.vo;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class MemberVO {
	private Long member_code;
	private String id;
	private String password;
	private String member_name;
	private LocalDateTime reg_date;
	
	private Long idCheck;
	private String passwordCheck;
}