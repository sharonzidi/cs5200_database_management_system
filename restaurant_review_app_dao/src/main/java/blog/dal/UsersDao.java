package blog.dal;

import blog.model.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


/**
 * Data access object (DAO) class to interact with the underlying Users table in your
 * MySQL instance. This is used to store {@link Users} into your MySQL instance and 
 * retrieve {@link Users} from MySQL instance.
 */
public class UsersDao extends RestaurantsDao {
	// Single pattern: instantiation is limited to one object.
	private static UsersDao instance = null;
	protected UsersDao() {
		super();
	}
	public static UsersDao getInstance() {
		if(instance == null) {
			instance = new UsersDao();
		}
		return instance;
	}

	public Users create(Users Users) throws SQLException {
		// Insert into the superclass table first.
		create(new Restaurants(Users.getUserName(), Users.getFirstName(),
			Users.getLastName()));

		String insertUser = "INSERT INTO Users(Password, Email, Phone) VALUES(?,?,?);";
		Connection connection = null;
		PreparedStatement insertStmt = null;
		try {
			connection = connectionManager.getConnection();
			insertStmt = connection.prepareStatement(insertUser);
			insertStmt.setString(1, Users.getPassword());
			insertStmt.setString(2, Users.getEmail());
			insertStmt.setString(3, Users.getPhone());
			insertStmt.executeUpdate();
			return Users;
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
		}
	}

	/**
	 * Update the LastName of the Users instance.
	 * This runs a UPDATE statement.
	 */
	public Users updateLastName(Users User, String newLastName) throws SQLException {
		// The field to update only exists in the superclass table, so we can
		// just call the superclass method.
		super.updateLastName(User, newLastName);
		return User;
	}

	/**
	 * Delete the Users instance.
	 * This runs a DELETE statement.
	 */
	public Users delete(Users User) throws SQLException {
		String deleteUser = "DELETE FROM Users WHERE UserName=?;";
		Connection connection = null;
		PreparedStatement deleteStmt = null;
		try {
			connection = connectionManager.getConnection();
			deleteStmt = connection.prepareStatement(deleteUser);
			deleteStmt.setString(1, User.getUserName());
			int affectedRows = deleteStmt.executeUpdate();
			if (affectedRows == 0) {
				throw new SQLException("No records available to delete for UserName=" + User.getUserName());
			}

			super.delete(User);

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

	public Users getUserByUserName(String userName) throws SQLException {
		// To build an User object, we need the Persons record, too.
		String selectUser =
			"SELECT Users.UserName AS UserName, FirstName, LastName, Password, Email, Phone " +
			"FROM Users INNER JOIN Persons " +
			"  ON Users.UserName = Persons.UserName " +
			"WHERE Users.UserName=?;";
		Connection connection = null;
		PreparedStatement selectStmt = null;
		ResultSet results = null;
		try {
			connection = connectionManager.getConnection();
			selectStmt = connection.prepareStatement(selectUser);
			selectStmt.setString(1, userName);
			results = selectStmt.executeQuery();
			if(results.next()) {
				String resultUserName = results.getString("UserName");
				String firstName = results.getString("FirstName");
				String lastName = results.getString("LastName");
				String password = results.getString("Password");
				String email = results.getString("Email");
				String phone = results.getString("Phone");
				Users User = new Users(resultUserName, firstName, lastName, password, email, phone);
				return User;
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

	public List<Users> getUsersFromFirstName(String firstName)
			throws SQLException {
		List<Users> Users = new ArrayList<Users>();
		String selectUsers =
			"SELECT Users.UserName AS UserName, FirstName, LastName, Password, Email, Phone " +
			"FROM Users INNER JOIN Persons " +
			"  ON Users.UserName = Persons.UserName " +
			"WHERE Persons.FirstName=?;";
		Connection connection = null;
		PreparedStatement selectStmt = null;
		ResultSet results = null;
		try {
			connection = connectionManager.getConnection();
			selectStmt = connection.prepareStatement(selectUsers);
			selectStmt.setString(1, firstName);
			results = selectStmt.executeQuery();
			while(results.next()) {
				String userName = results.getString("UserName");
				String resultFirstName = results.getString("FirstName");
				String lastName = results.getString("LastName");
				String password = results.getString("Password");
				String email = results.getString("Email");
				String phone = results.getString("Phone");
				Users User = new Users(userName, resultFirstName, lastName, password, email, phone);
				Users.add(User);
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
		return Users;
	}
}
