package notice;


public class NoticeDTO{

	private int num; 
    private String userID;
    private String subject;
    private String content;
    private String reg_date;
    private int readcount;

	public void setNum(int num){
    	this.num=num;
    }
    public void setUserID (String userID) {
        this.userID = userID;
    }
    public void setSubject (String subject) {
        this.subject = subject;
    }
    public void setContent (String content) {
        this.content = content;
    }
    public void setReg_date (String reg_date) {
        this.reg_date = reg_date;
    }
	public void setReadcount(int readcount){
	  	this.readcount=readcount;
	}
    
    public int getNum(){
    	return num;
    }
    public int getReadcount(){
   	    return readcount;
    }
    public String getUserID () {
        return userID;
    }
    public String getSubject () {
        return subject;
    }
    public String getContent () {
        return content;
    }
    public String getReg_date () {
        return reg_date;
    }
	public NoticeDTO(int num, String userID, String subject, String content, String reg_date, int readcount) {
		super();
		this.num = num;
		this.userID = userID;
		this.subject = subject;
		this.content = content;
		this.reg_date = reg_date;
		this.readcount = readcount;
	}
	public NoticeDTO() {
		
	}
}