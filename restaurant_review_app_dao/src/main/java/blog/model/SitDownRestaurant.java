package blog.model;


public class SitDownRestaurant extends Restaurants {
	protected int capacity;
	
	public SitDownRestaurant(Integer restaurantId, String name, String description, String menu,
			String hours, Boolean active, cuisineType cuisinetype, String street1, String street2, 
			String city, String state, Integer zip, String companyName, int capacity) {
		super(restaurantId, name, description, menu, hours, active, cuisinetype, street1, street2, city, state, zip, companyName);
		this.capacity = capacity;
	}
	
	public SitDownRestaurant(Integer restaurantId) {
		super(restaurantId);
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	
}
