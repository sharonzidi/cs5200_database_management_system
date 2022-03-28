package blog.model;


/**
 * BlogUsers is a simple, plain old java objects (POJO).
 * Well, almost (it extends {@link Restaurants}).
 */
public class Users extends Restaurants {
	protected String password;
	protected String email;
	protected String phone;
	
	
	public Users(String userName, String firstName, String lastName, String password, String email, String phone) {
		super(userName, firstName, lastName);
		this.password = password;
		this.email = email;
		this.phone = phone;
	}
	
	public Users(String userName) {
		super(userName);
	}
	

	/** Getters and setters. */
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
}


	