package com.company.main;



import java.util.Scanner;

import com.company.dao.ProductDAO;
import com.company.model.Product;

public class MainApp {
	public static void main(String[] args)
	{
		
		ProductDAO dao = new ProductDAO();
		Scanner sc = new Scanner(System.in);
		
		while(true)
		{
		System.out.println("\n1. Add product");
		System.out.println("2. View product");
		System.out.println("3. Update product");
		System.out.println("4. Delete product");
		System.out.println("5. Exit");
		int choice = sc.nextInt();
		
		switch(choice)
		{
		case 1:
			System.out.println("Enter name");
			String name = sc.next();
			System.out.println("Enter price");
			double price = sc.nextDouble();
			
			dao.addProduct(new Product(name, price));
			break;
			
		case 2:
			dao.getAllProducts();
			break;
		case 3:
			System.out.println("Enter the Id of the Product");
			int id=sc.nextInt();
			System.out.println("Enter the New price to update");
			double price1=sc.nextDouble();
			dao.updateProduct(id, price1);
			break;
		case 4:
			System.out.println("Enter the id of the product ");
			int id1=sc.nextInt();
			dao.deleteProduct(id1);
			break;
		case 5:
			System.exit(0);
		}
		}
		
	}

}
