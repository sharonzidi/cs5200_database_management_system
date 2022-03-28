package blog.model;


public class TakeOutRestaurant extends Restaurants {
	protected int maxWaitTime;
	
	public TakeOutRestaurant(Integer restaurantId, String name, String description, String menu,
			String hours, Boolean active, cuisineType cuisinetype, String street1, String street2, 
			String city, String state, Integer zip, String companyName, int maxWaitTime) {
		super(restaurantId, name, description, menu, hours, active, cuisinetype, street1, street2, city, state, zip, companyName);
		this.maxWaitTime = maxWaitTime;
	}
	
	public TakeOutRestaurant(Integer restaurantId) {
		super(restaurantId);
	}

	public int getMaxWaitTime() {
		return maxWaitTime;
	}

	public void setMaxWaitTime(int maxWaitTime) {
		this.maxWaitTime = maxWaitTime;
	}

	
}
