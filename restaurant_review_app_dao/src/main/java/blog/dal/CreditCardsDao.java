package blog.dal;
import java.util.Date;

import blog.model.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;


/**
 * Data access object (DAO) class to interact with the underlying Users table in your
 * MySQL instance. This is used to store {@link Users} into your MySQL instance and 
 * retrieve {@link Users} from MySQL instance.
 */
public class CreditCardsDao {
	// Single pattern: instantiation is limited to one object.
	protected ConnectionManager connectionManager;

	private static CreditCardsDao instance = null;
	protected CreditCardsDao() {
		connectionManager = new ConnectionManager();
	}
	public static CreditCardsDao getInstance() {
		if(instance == null) {
			instance = new CreditCardsDao();
		}
		return instance;
	}

	public CreditCards create(CreditCards creditCard) throws SQLException {
		String insertCard = "INSERT INTO CreditCards(CardNumber, Expiration, UserName) VALUES(?,?,?);";
		Connection connection = null;
		PreparedStatement insertStmt = null;
		try {
			connection = connectionManager.getConnection();
			insertStmt = connection.prepareStatement(insertCard);
			insertStmt.setLong(1, creditCard.getCardNumber());
			insertStmt.setTimestamp(2, new Timestamp(creditCard.getExpiration().getTime()));
			insertStmt.setString(3, creditCard.getUserName());
			insertStmt.executeUpdate();
			return creditCard;
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
	public CreditCards updateExpiration(CreditCards creditCard, Date newExpiration) throws SQLException {
		String updateExpiration = "UPDATE CreditCards SET Expiration=? WHERE CardNumber=?;";
		Connection connection = null;
		PreparedStatement updateStmt = null;
		try {
			connection = connectionManager.getConnection();
			updateStmt = connection.prepareStatement(updateExpiration);
			updateStmt.setTimestamp(1, new Timestamp(newExpiration.getTime()));
			updateStmt.setLong(2, creditCard.getCardNumber());
			updateStmt.executeUpdate();

			creditCard.setExpiration(newExpiration);
			return creditCard;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(connection != null) {
				connection.close();
			}
			if(updateStmt != null) {
				updateStmt.close();
			}
		}
	}

	/**
	 * Delete the Users instance.
	 * This runs a DELETE statement.
	 */
	public CreditCards delete(CreditCards creditCard) throws SQLException {
		String deleteCreditCard = "DELETE FROM CreditCards WHERE CardNumber=?;";
		Connection connection = null;
		PreparedStatement deleteStmt = null;
		try {
			connection = connectionManager.getConnection();
			deleteStmt = connection.prepareStatement(deleteCreditCard);
			deleteStmt.setLong(1, creditCard.getCardNumber());
			int affectedRows = deleteStmt.executeUpdate();
			if (affectedRows == 0) {
				throw new SQLException("No records available to delete for CreditCard=" + creditCard.getCardNumber());
			}

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

	public CreditCards getCreditCardByCardNumber(long cardNumber) throws SQLException {
		String selectCreditCard =
				"SELECT CardNumber, Expiration, UserName " +
				"FROM CreditCards " +
				"WHERE CardNumber=?;";
			Connection connection = null;
			PreparedStatement selectStmt = null;
			ResultSet results = null;
			try {
				connection = connectionManager.getConnection();
				selectStmt = connection.prepareStatement(selectCreditCard);
				selectStmt.setLong(1, cardNumber);
				results = selectStmt.executeQuery();
	
				if(results.next()) {
					long resultCardNumber = results.getLong("CardNumber");
					Date expiration =  new Date(results.getTimestamp("Expiration").getTime());
					String userName = results.getString("UserName");
					
					CreditCards creditCard = new CreditCards(resultCardNumber, expiration, userName);
					return creditCard;
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

	public List<CreditCards> getCreditCardsByUserName(String userName) throws SQLException {
		List<CreditCards> creditCards = new ArrayList<CreditCards>();
		String selectCreditCards =
				"SELECT CardNumber, Expiration, UserName " +
				"FROM CreditCards " +
				"WHERE UserName=?;";
		Connection connection = null;
		PreparedStatement selectStmt = null;
		ResultSet results = null;
		try {
			connection = connectionManager.getConnection();
			selectStmt = connection.prepareStatement(selectCreditCards);
			selectStmt.setString(1, userName);
			results = selectStmt.executeQuery();
			while(results.next()) {
				long cardNumber = results.getLong("CardNumber");
				Date expiration =  new Date(results.getTimestamp("Expiration").getTime());
				
				CreditCards creditCard = new CreditCards(cardNumber, expiration, userName);
				creditCards.add(creditCard);
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
		return creditCards;
	}
}
