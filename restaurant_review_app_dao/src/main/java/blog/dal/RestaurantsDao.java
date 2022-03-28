package blog.dal;

import blog.model.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class RestaurantsDao {
	protected ConnectionManager connectionManager;
	
	// Single pattern: instantiation is limited to one object.
	private static RestaurantsDao instance = null;
	protected RestaurantsDao() {
		connectionManager = new ConnectionManager();
	}
	public static RestaurantsDao getInstance() {
		if(instance == null) {
			instance = new RestaurantsDao();
		}
		return instance;
	}


	public Restaurants create(Restaurants restaurant) throws SQLException {
		String insertRestaurant = "INSERT INTO Restaurants(Name, Description,Menu,Hours,Active,CuisineType,"
				+ "Street1,Street2,City,State,Zip,CompanyName) VALUES(?,?,?,?,?,?,?,?,?,?,?,?);";
		Connection connection = null;
		PreparedStatement insertStmt = null;
		ResultSet resultKey = null;
		try {
			connection = connectionManager.getConnection();
			insertStmt = connection.prepareStatement(insertRestaurant,
					Statement.RETURN_GENERATED_KEYS);

			insertStmt.setString(1, restaurant.getName());
			insertStmt.setString(2, restaurant.getDescription());
			insertStmt.setString(3, restaurant.getMenu());
			insertStmt.setString(4, restaurant.getHours());
			insertStmt.setBoolean(5, restaurant.getActive());
			insertStmt.setString(6, restaurant.getCuisinetype().name());
			insertStmt.setString(7, restaurant.getStreet1());
			insertStmt.setString(8, restaurant.getStreet2());
			insertStmt.setString(9, restaurant.getCity());
			insertStmt.setString(10, restaurant.getState());
			insertStmt.setInt(11, restaurant.getZip());
			insertStmt.setString(12, restaurant.getCompanyName());

			insertStmt.executeUpdate();
			
			resultKey = insertStmt.getGeneratedKeys();
			int restaurantId = -1;
			if(resultKey.next()) {
				restaurantId = resultKey.getInt(1);
			} else {
				throw new SQLException("Unable to retrieve auto-generated key.");
			}
			restaurant.setRestaurantId(restaurantId);
			return restaurant;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(connection != null) {
				connection.close();
			}
			if(insertStmt != null) {
				insertStmt.close();
			}
			if(resultKey != null) {
				resultKey.close();
			}
		}
	}


	public Restaurants delete(Restaurants restaurant) throws SQLException {
		String deleteRestaurant = "DELETE FROM Restaurants WHERE Name=?;";
		Connection connection = null;
		PreparedStatement deleteStmt = null;
		try {
			connection = connectionManager.getConnection();
			deleteStmt = connection.prepareStatement(deleteRestaurant);
			deleteStmt.setString(1, restaurant.getName());
			deleteStmt.executeUpdate();

			// Return null so the caller can no longer operate on the Persons instance.
			return null;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(connection != null) {
				connection.close();
			}
			if(deleteStmt != null) {
				deleteStmt.close();
			}
		}
	}

	public Restaurants getRestaurantById(int restaurantId) throws SQLException {
		String selectRestaurant = "SELECT Name, Description,Menu,Hours,Active,CuisineType,"
				+ "Street1,Street2,City,State,Zip,CompanyName FROM Restaurants WHERE RestaurantId=?;";
		Connection connection = null;
		PreparedStatement selectStmt = null;
		ResultSet results = null;
		try {
			connection = connectionManager.getConnection();
			selectStmt = connection.prepareStatement(selectRestaurant);
			selectStmt.setInt(1, restaurantId);

			results = selectStmt.executeQuery();

			if(results.next()) {
				int resultRestaurantId = results.getInt("RestaurantId");
				String name = results.getString("Name");
				String description = results.getString("Description");
				String menu = results.getString("Menu");
				String hours = results.getString("Hours");
				Boolean active = results.getBoolean("Active");
				Restaurants.cuisineType cuisinetype = Restaurants.cuisineType.valueOf(
						results.getString("CuisineType"));
				String street1 = results.getString("Street1");
				String street2 = results.getString("Street2");
				String city = results.getString("City");
				String state = results.getString("State");
				int zip = results.getInt("Zip");
				String companyName = results.getString("CompanyName");
				
				Restaurants restaurant = new Restaurants(resultRestaurantId, name, description, menu,
						hours, active, cuisinetype, street1, street2, 
						city, state, zip, companyName);
				
				return restaurant;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(connection != null) {
				connection.close();
			}
			if(selectStmt != null) {
				selectStmt.close();
			}
			if(results != null) {
				results.close();
			}
		}
		return null;
	}

	/**
	 * Get the matching Persons records by fetching from your MySQL instance.
	 * This runs a SELECT statement and returns a list of matching Persons.
	 */
	public List<Restaurants> getRestaurantsByCuisine(Restaurants.cuisineType cuisine) throws SQLException {
		List<Restaurants> restaurants = new ArrayList<Restaurants>();
		String selectRestaurants =
			"SELECT Name, Description,Menu,Hours,Active,CuisineType,Street1,Street2,City,State,Zip,CompanyName "
			+ "FROM Restaurants WHERE CuisineType=?;";
		Connection connection = null;
		PreparedStatement selectStmt = null;
		ResultSet results = null;
		try {
			connection = connectionManager.getConnection();
			selectStmt = connection.prepareStatement(selectRestaurants);
			selectStmt.setString(1, cuisine.name());
			results = selectStmt.executeQuery();
			while(results.next()) {
				int resultRestaurantId = results.getInt("RestaurantId");
				String name = results.getString("Name");
				String description = results.getString("Description");
				String menu = results.getString("Menu");
				String hours = results.getString("Hours");
				Boolean active = results.getBoolean("Active");
				Restaurants.cuisineType cuisinetype = Restaurants.cuisineType.valueOf(
						results.getString("CuisineType"));
				String street1 = results.getString("Street1");
				String street2 = results.getString("Street2");
				String city = results.getString("City");
				String state = results.getString("State");
				int zip = results.getInt("Zip");
				String companyName = results.getString("CompanyName");
				
				Restaurants restaurant = new Restaurants(resultRestaurantId, name, description, menu,
						hours, active, cuisinetype, street1, street2, 
						city, state, zip, companyName);
				restaurants.add(restaurant);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(connection != null) {
				connection.close();
			}
			if(selectStmt != null) {
				selectStmt.close();
			}
			if(results != null) {
				results.close();
			}
		}
		return restaurants;
	}
	
	public List<Restaurants> getRestaurantsByCompanyName(String companyName) throws SQLException {
		
		List<Restaurants> restaurants = new ArrayList<Restaurants>();
		String selectRestaurants =
			"SELECT Name, Description,Menu,Hours,Active,CuisineType,Street1,Street2,City,State,Zip,CompanyName "
			+ "FROM Restaurants WHERE CompanyName=?;";
		Connection connection = null;
		PreparedStatement selectStmt = null;
		ResultSet results = null;
		try {
			connection = connectionManager.getConnection();
			selectStmt = connection.prepareStatement(selectRestaurants);
			selectStmt.setString(1, companyName);
			results = selectStmt.executeQuery();
			while(results.next()) {
				int restaurantId = results.getInt("RestaurantId");
				String name = results.getString("Name");
				String description = results.getString("Description");
				String menu = results.getString("Menu");
				String hours = results.getString("Hours");
				Boolean active = results.getBoolean("Active");
				Restaurants.cuisineType cuisinetype = Restaurants.cuisineType.valueOf(
						results.getString("CuisineType"));
				String street1 = results.getString("Street1");
				String street2 = results.getString("Street2");
				String city = results.getString("City");
				String state = results.getString("State");
				int zip = results.getInt("Zip");
				String resultCompanyName = results.getString("CompanyName");
				
				Restaurants restaurant = new Restaurants(restaurantId, name, description, menu,
						hours, active, cuisinetype, street1, street2, 
						city, state, zip, resultCompanyName);
				restaurants.add(restaurant);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(connection != null) {
				connection.close();
			}
			if(selectStmt != null) {
				selectStmt.close();
			}
			if(results != null) {
				results.close();
			}
		}
		return restaurants;
	}
}
