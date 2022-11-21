package board;
import java.sql.Timestamp;

public class BoardDataBean{

	private int num; 
    private String userID;
    private String subject;
    private String content;
    private Timestamp reg_date;
    private int readcount;
    private int ref;
    private int re_step;	
    private int re_level;

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
    public void setReg_date (Timestamp reg_date) {
        this.reg_date = reg_date;
    }
	public void setReadcount(int readcount){
	  	this.readcount=readcount;
	}
	public void setRef (int ref) {
        this.ref = ref;
    }
	public void setRe_level (int re_level) {
        this.re_level=re_level;
    }
	public void setRe_step (int re_step) {
        this.re_step=re_step;
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
    public Timestamp getReg_date () {
        return reg_date;
    }
    public int getRef () {
        return ref;
    }
	public int getRe_level () {
        return re_level;
    }
	public int getRe_step () {
        return re_step;
    }
    
}