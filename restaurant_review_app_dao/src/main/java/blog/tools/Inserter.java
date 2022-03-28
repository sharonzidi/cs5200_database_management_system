package blog.tools;

import blog.dal.*;
import blog.model.*;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;


/**
 * main() runner, used for the app demo.
 * 
 * Instructions:
 * 1. Create a new MySQL schema and then run the CREATE TABLE statements from lecture:
 * http://goo.gl/86a11H.
 * 2. Update ConnectionManager with the correct user, password, and schema.
 */
public class Inserter {

	public static void main(String[] args) throws SQLException {
		// DAO instances.
		RestaurantsDao personsDao = RestaurantsDao.getInstance();
		SitDownRestaurantsDao administratorsDao = SitDownRestaurantsDao.getInstance();
		BlogUsersDao blogUsersDao = BlogUsersDao.getInstance();
		CompaniesDao blogPostsDao = CompaniesDao.getInstance();
		BlogCommentsDao blogCommentsDao = BlogCommentsDao.getInstance();
		ResharesDao resharesDao = ResharesDao.getInstance();
		
		// INSERT objects from our model.
		Restaurants person = new Restaurants("b", "bruce", "chhay");
		person = personsDao.create(person);
		Restaurants person1 = new Restaurants("b1", "bruce", "chhay");
		person1 = personsDao.create(person1);
		Restaurants person2 = new Restaurants("b2", "bruce", "chhay");
		person2 = personsDao.create(person2);
		Date date = new Date();
		Administrators administrator = new Administrators("a", "bruce", "chhay_a", date);
		administrator = administratorsDao.create(administrator);
		Administrators administrator1 = new Administrators("a1", "bruce", "chhay_a1", date);
		administrator1 = administratorsDao.create(administrator1);
		Administrators administrator2 = new Administrators("a2", "bruce", "chhay_a2", date);
		administrator2 = administratorsDao.create(administrator2);
		BlogUsers blogUser = new BlogUsers("bu", "bruce", "chhay", date, BlogUsers.StatusLevel.novice);
		blogUser = blogUsersDao.create(blogUser);
		BlogUsers blogUser1 = new BlogUsers("bu1", "bruce", "chhay_bu1", date, BlogUsers.StatusLevel.intermediate);
		blogUser1 = blogUsersDao.create(blogUser1);
		BlogUsers blogUser2 = new BlogUsers("bu2", "bruce", "chhay_bu2", date, BlogUsers.StatusLevel.advanced);
		blogUser2 = blogUsersDao.create(blogUser2);
		Companies blogPost = new Companies("Laser Cats", "pic", "content", true, date, blogUser);
		blogPost = blogPostsDao.create(blogPost);
		Companies blogPost1 = new Companies("Dancing Cats", "pic1", "content1", true, date, blogUser);
		blogPost1 = blogPostsDao.create(blogPost1);
		Companies blogPost2 = new Companies("Sleeping Cats", "pic2", "content2", true, date, blogUser);
		blogPost2 = blogPostsDao.create(blogPost2);
		BlogComments blogComment = new BlogComments("Comment", date, blogPost, blogUser1);
		blogComment = blogCommentsDao.create(blogComment);
		BlogComments blogComment1 = new BlogComments("Comment1", date, blogPost, blogUser1);
		blogComment1 = blogCommentsDao.create(blogComment1);
		BlogComments blogComment2 = new BlogComments("Comment2", date, blogPost, blogUser1);
		blogComment2 = blogCommentsDao.create(blogComment2);
		BlogComments blogComment3 = new BlogComments("Comment3", date, blogPost, blogUser);
		blogComment = blogCommentsDao.create(blogComment3);
		BlogComments blogComment4 = new BlogComments("Comment4", date, blogPost, blogUser);
		blogComment1 = blogCommentsDao.create(blogComment4);
		BlogComments blogComment5 = new BlogComments("Comment5", date, blogPost, blogUser);
		blogComment2 = blogCommentsDao.create(blogComment5);
		Reshares reshare = new Reshares(blogUser2, blogPost);
		reshare = resharesDao.create(reshare);
		Reshares reshare1 = new Reshares(blogUser2, blogPost1);
		reshare1 = resharesDao.create(reshare1);
		Reshares reshare2 = new Reshares(blogUser2, blogPost2);
		reshare2 = resharesDao.create(reshare2);
		
		// READ.
		Restaurants p1 = personsDao.getPersonFromUserName("b");
		List<Restaurants> pList1 = personsDao.getPersonsFromFirstName("bruce");
		System.out.format("Reading person: u:%s f:%s l:%s \n",
			p1.getUserName(), p1.getFirstName(), p1.getLastName());
		for(Restaurants p : pList1) {
			System.out.format("Looping persons: u:%s f:%s l:%s \n",
				p.getUserName(), p.getFirstName(), p.getLastName());
		}
		Administrators a1 = administratorsDao.getAdministratorFromUserName("a");
		List<Administrators> aList1 = administratorsDao.getAdministratorsFromFirstName("bruce");
		System.out.format("Reading administrator: u:%s f:%s l:%s d:%s \n",
			a1.getUserName(), a1.getFirstName(), a1.getLastName(), a1.getLastLogin());
		for(Administrators a : aList1) {
			System.out.format("Looping administrators: u:%s f:%s l:%s \n",
				a.getUserName(), a.getFirstName(), a.getLastName(), a.getLastLogin());
		}
		BlogUsers bu1 = blogUsersDao.getBlogUserFromUserName("bu");
		List<BlogUsers> buList1 = blogUsersDao.getBlogUsersFromFirstName("bruce");
		System.out.format("Reading blog user: u:%s f:%s l:%s d:%s s:%s \n",
			bu1.getUserName(), bu1.getFirstName(), bu1.getLastName(), bu1.getDob(), bu1.getStatusLevel().name());
		for(BlogUsers bu : buList1) {
			System.out.format("Looping blog users: u:%s f:%s l:%s d:%s s:%s \n",
				bu.getUserName(), bu.getFirstName(), bu.getLastName(), bu.getDob(), bu.getStatusLevel().name());
		}
		List<Companies> bpList1 = blogPostsDao.getBlogPostsForUser(bu1);
		for(Companies bp : bpList1) {
			System.out.format("Looping blog posts: t:%s c:%s u:%s \n",
				bp.getTitle(), bp.getContent(), bu1.getUserName());
		}
		List<BlogComments> bcList1 = blogCommentsDao.getBlogCommentsForUser(blogUser1);
		for(BlogComments bc : bcList1) {
			System.out.format("Looping blog comments: t:%s u:%s \n",
				bc.getContent(), blogUser1.getUserName());
		}
		bcList1 = blogCommentsDao.getBlogCommentsForUser(blogUser);
		for(BlogComments bc : bcList1) {
			System.out.format("Looping blog comments: t:%s u:%s \n",
				bc.getContent(), blogUser.getUserName());
		}
		List<Reshares> rList1 = resharesDao.getResharesForUser(blogUser2);
		for(Reshares r : rList1) {
			System.out.format("Looping reshare: i:%s u:%s t:%s \n",
				r.getReshareId(), r.getBlogUser().getUserName(),
				r.getBlogPost().getTitle());
		}
	}
}
