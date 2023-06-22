package Util;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EmailVO {

	private String senderName;
	private String senderMail;
	private String receiveMail;
	private String subject;
	private String message;
	
	
}
