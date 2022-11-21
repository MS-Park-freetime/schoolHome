package individualChat;

public class IndividualDTO {
	int individualID;
	String fromID;
	String toID;
	String individualContent;
	String individualTIme;
	public IndividualDTO() {
		
	}
	public IndividualDTO(int individualID, String fromID, String toID, String individualContent,
			String individualTIme) {
		super();
		this.individualID = individualID;
		this.fromID = fromID;
		this.toID = toID;
		this.individualContent = individualContent;
		this.individualTIme = individualTIme;
	}
	public int getIndividualID() {
		return individualID;
	}
	public void setIndividualID(int individualID) {
		this.individualID = individualID;
	}
	public String getFromID() {
		return fromID;
	}
	public void setFromID(String fromID) {
		this.fromID = fromID;
	}
	public String getToID() {
		return toID;
	}
	public void setToID(String toID) {
		this.toID = toID;
	}
	public String getIndividualContent() {
		return individualContent;
	}
	public void setIndividualContent(String individualContent) {
		this.individualContent = individualContent;
	}
	public String getIndividualTIme() {
		return individualTIme;
	}
	public void setIndividualTIme(String individualTIme) {
		this.individualTIme = individualTIme;
	}
}
