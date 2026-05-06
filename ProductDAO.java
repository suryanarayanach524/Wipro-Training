package com.company.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.company.model.Product;
import com.company.util.DBConnection;

public class ProductDAO {

	public void addProduct(Product p)
	{
	String sql = "insert into products(name ,price) values(? ,?)"; // parameterized query
//	String sql1 = "create table abc(id int)";  // static queries when there is no parameter
	//try with resources
	try(Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql))
	
	{
		ps.setString(1,p.getName());
		ps.setDouble(2, p.getPrice());
		ps.executeUpdate();
		System.out.println("Data added ");
		
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
}
	
public void getAllProducts()
{
	String sql = "select * from products";
	try(Connection conn = DBConnection.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			)
	
	{
		while(rs.next())
		{
			System.out.println(rs.getInt("id") + " " + rs.getString("name") + " " +rs.getDouble("price"));
			
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
}

public void updateProduct(int id,double price) {
	String sql="update products set price=? where id=?";
	try(Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql))
	{
		ps.setDouble(1, price);
		ps.setInt(2, id);
		ps.executeUpdate();
		System.out.println("Price of the Product with Id: "+id+" Updated");
		
	} catch (Exception e) {
		e.printStackTrace();
	}
		
}
public void deleteProduct(int id) {
	String sql="delete from products where id=?";
	try(Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql)){
		ps.setInt(1, id);
		ps.executeUpdate();
		System.out.println("Product with Id: "+id+" is deleted");
		
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	
}
}
