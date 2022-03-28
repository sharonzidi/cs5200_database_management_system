package blog.model;


public class FoodCartRestaurant extends Restaurants {
	protected boolean licensed;
	
	public FoodCartRestaurant(Integer restaurantId, String name, String description, String menu,
			String hours, Boolean active, cuisineType cuisinetype, String street1, String street2, 
			String city, String state, Integer zip, String companyName, boolean licensed) {
		super(restaurantId, name, description, menu, hours, active, cuisinetype, street1, street2, city, state, zip, companyName);
		this.licensed = licensed;
	}
	
	public FoodCartRestaurant(Integer restaurantId) {
		super(restaurantId);
	}

	public boolean isLicensed() {
		return licensed;
	}

	public void setLicensed(boolean licensed) {
		this.licensed = licensed;
	}

}
