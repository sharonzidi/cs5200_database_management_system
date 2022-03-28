package blog.model;


public class Companies {
	protected String companyName;
	protected String about;

	
	// This constructor can be used for reading records from MySQL, where we have all fields,
	// including the PostId.
	public Companies(String companyName, String about) {
		this.companyName = companyName;
		this.about = about;
	}
	
	// This constructor can be used for reading records from MySQL, where we only have the postId,
	// such as a foreign key reference to PostId.
	// Given PostId, we can fetch the full BlogPost record.
	public Companies(String companyName) {
		this.companyName = companyName;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getAbout() {
		return about;
	}

	public void setAbout(String about) {
		this.about = about;
	}
	

}