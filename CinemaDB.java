package projectDB;

import java.awt.EventQueue;
import javax.swing.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Font;

import java.sql.*;


public class CinemaDB {

	private JFrame frame;
	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	static final String DB_URL = "jdbc:mysql://localhost/Cinema?useSSL=false";
	static final String USER = "root";
	static final String PASS = "5853";

	static Connection conn = null;
    static Statement stmt = null; 
    static ResultSet rs = null;
    
    
	
    /********** Launch the application **********/
	
	public static void main(String[] args) {
		
	    try{
	        Class.forName("com.mysql.jdbc.Driver");
	        conn = DriverManager.getConnection(DB_URL,USER,PASS);
	        stmt = conn.createStatement();
	    
			EventQueue.invokeLater(new Runnable() {
				public void run() {
					try {
						CinemaDB window = new CinemaDB();
						window.frame.setVisible(true);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			});
	    } catch(SQLException se){
	         se.printStackTrace();
	    } catch(Exception e){
	         e.printStackTrace();
	    } finally{
	    	try{
	            if(stmt != null)
	               stmt.close();
	    	} catch(SQLException se2){
	    	}
	        try{
	            if(conn != null)
	               conn.close();
	        } catch(SQLException se){
	            se.printStackTrace();
	        }
	    }
	}

	
	
	/********** Create the application **********/
	
	public CinemaDB() {
		initialize();
	}


	
	/********** Initialize the contents of the frame. **********/
	
	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 290, 350);
		frame.getContentPane().setLayout(null);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		JLabel label = new JLabel("Choose your type");
		label.setFont(new Font("Dialog", Font.BOLD | Font.ITALIC, 14));
		label.setBounds(2, 2, 200, 30);
		frame.getContentPane().add(label);
		
		JButton button1 = new JButton("Customer");
		button1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//click
				CustomerMenu cust = new CustomerMenu();
				cust.customerScreen();
			}
		});
		button1.setBounds(70, 50, 150, 50);
		frame.getContentPane().add(button1);
		
		JButton button2 = new JButton("Cashier");
		button2.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//click
				CashierMenu cash = new CashierMenu();
				cash.cashierScreen();
			}
		});
		button2.setBounds(70, 125, 150, 50);
		frame.getContentPane().add(button2);
		
		JButton button3 = new JButton("Shift Manager");
		button3.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//click
				ShiftManagerMenu sm = new ShiftManagerMenu();
				sm.shiftManagerScreen();
			}
		});
		button3.setBounds(70, 200, 150, 50);
		frame.getContentPane().add(button3);
	}
}
