package projectDB;

import java.awt.EventQueue;
import javax.swing.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Font;
import java.text.*;
import java.sql.*;
import java.util.Date;

public class CashierMenu {

	private JFrame frame;

	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	static final String DB_URL = "jdbc:mysql://localhost/Cinema?useSSL=false";
	static final String USER = "root";
	static final String PASS = "5853";
	
	Connection conn;
	Statement stmt; 
    ResultSet rs;
    
    
    
    /********** Launch the application **********/
    
	public static void cashierScreen() {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					CashierMenu window = new CashierMenu();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	
	
	/********** Create the application **********/
	
	public CashierMenu() {
		initialize();
	}
	
	
	
	/********** Initialize the contents of the frame **********/
	
	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 520, 300);
		frame.getContentPane().setLayout(null);
		frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		
		JLabel label = new JLabel("What do you want to do?");
		label.setFont(new Font("Dialog", Font.BOLD | Font.ITALIC, 14));
		label.setBounds(2, 2, 200, 30);
		frame.getContentPane().add(label);	
		
		JButton button1 = new JButton("Show Today's Screening Times & Reserve Seats");
		button1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//click
				frame.dispose();
				
				try{
					Class.forName("com.mysql.jdbc.Driver");
			        conn = DriverManager.getConnection(DB_URL,USER,PASS);
			        stmt = conn.createStatement();
					
					int tmp, screen;
					String sql, title, temp, begin_s,end_s;
					JTextArea textArea = new JTextArea();
					//Υπολογισμός τρέχουσας ημερομηνίας και ώρας
					Date curDate = new Date();
	                Date curTime = new Date();
	                SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd ");
	                SimpleDateFormat ft2 = new SimpleDateFormat("kk:mm:ss");
	                String beg_time = ft.format(curDate) + ft2.format(curTime);
	                String end_time = ft.format(curDate) + "23:59:59";

	                /*Ορισμός τρέχουσας ημερομηνίας σε 05/08/2016*/
	                /***********************************/
	                beg_time = "2016-08-05 00:00:00";
	                end_time = "2016-08-05 23:59:00";
	                /***********************************/
	                
	                sql = "SELECT * FROM Screening_Times WHERE beg_time >= \"" + beg_time + "\" AND beg_time <=\"" + end_time + "\" order by beg_time asc";
	                rs = stmt.executeQuery(sql);
	                Timestamp begin,end;
	                while(rs.next()) {
	                	title = rs.getString("title");
	                    screen = rs.getInt("name");
	                    begin= rs.getTimestamp("beg_time");
	                    end = rs.getTimestamp("end_time");
	                    begin_s = new SimpleDateFormat("kk:mm:ss").format(begin);
	                    end_s = new SimpleDateFormat("kk:mm:ss").format(end);
	                    textArea.append(title + "| Screen : " + screen + " | " + begin_s + "  | " + end_s + "\n"); 
	                }
	                JScrollPane ScrollPanel = new JScrollPane(textArea);
	                JOptionPane.showMessageDialog(null, ScrollPanel, "Schedule", JOptionPane.INFORMATION_MESSAGE);
	                
	                temp = JOptionPane.showInputDialog("Do you want to reserve a ticket? (yes = 1 / no = 0)");
	                tmp = Integer.parseInt(temp);
	                
	                if(tmp == 1) {
	                	String sscreen="";
	                	JOptionPane.showMessageDialog(null,"Keep in mind the Title, Screen and Time of the movie you want!!" ,"WARNING", JOptionPane.WARNING_MESSAGE);
	                	JOptionPane.showMessageDialog(null, ScrollPanel, "Schedule", JOptionPane.INFORMATION_MESSAGE);
	                	title = JOptionPane.showInputDialog("Please enter movie's title");
	                	sscreen = JOptionPane.showInputDialog("Please enter movie's screen");
	                	begin_s = JOptionPane.showInputDialog("Please enter movie's beginning time (format hh:mm:ss)");
	                	//Προσθήκη στο begin_s της ημερομηνίας
	                	begin_s = ft.format(curDate) + begin_s;

	                	/*Ορισμός τρέχουσας ημερομηνίας σε 05/08/2016*/
	                	/********************************/
	                	begin_s = "2016-08-05 " + begin_s;
	                	/********************************/
	                	
	                	screen = Integer.parseInt(sscreen);
	                	int size;
	                	//Οι αίθουσες 21 και 22 έχουν χωρητικότητα 18 άτομα , ενώ οι 11 και 12 έχουν χωρητικότητα 30 άτομα.
	                	if(screen == 21 || screen == 22)
	                		size = 18;
	                	else 
	                		size = 30;
	                	String tickets [] = new String [size];
	                	for (int i = 0 ; i < size  ; i++) {
	                		if(i < 9)
	                			tickets[i] = "0" + Integer.toString(i + 1);
	                		else
	                			tickets[i] = Integer.toString(i + 1);
	                	}
	                	
	                	sql = "SELECT * FROM Tickets WHERE beg_time = \"" + begin_s + "\" AND title =\"" + title + "\" AND name = " + screen;
	                	rs = stmt.executeQuery(sql);
	                	int ticket_number;
	                	while(rs.next()) {
	                		ticket_number = rs.getInt("ticket_number") ;
	                        if(ticket_number%2 == 1 )
	                        	tickets[ticket_number - 1 ] = "X ";  
	                        else
	                        	tickets[ticket_number - 1 ] = " X"; 
	                	}
	                	//Απεικόνιση διαθέσιμων θέσεων
	                	textArea.setText("Available seats : \n");
	                	if(size == 18) {
	                		for (int i = 0 ; i < size ; i++) {
	                			if(i%2 == 0)
	                				textArea.append("    ");
	                			textArea.append(tickets[i] + " ");
	                			if(i == 5 || i == 11 || i == 17)
	                				textArea.append("\n");
	                		}
	                	} else {
	                		for (int i = 0 ; i < size ; i++) {
	                			if(i%2 == 0)
	                				textArea.append("    ");
	                			textArea.append(tickets[i] + " ");
	                			if(i == 5 || i == 11 || i == 17 || i == 23 || i == 29)
	                				textArea.append("\n");
	                		}
	                	}
	                	JScrollPane ScrollPanel2 = new JScrollPane(textArea);
	                	JOptionPane.showMessageDialog(null, ScrollPanel2, "Seats", JOptionPane.INFORMATION_MESSAGE);
	                   
	                	temp = JOptionPane.showInputDialog("Please enter amount of tickets");
	                	int amount = Integer.parseInt(temp);
	                	
	                	int price = 0;
	                	textArea.setText("");
	                	for(int i = 1 ; i <= amount ; i++) {
	                		textArea.append("Ticket " + i + "/" + amount + ":" + "\n");
	                		temp = JOptionPane.showInputDialog("Please enter buyer's id");
	                		int buyer = Integer.parseInt(temp);
	                		sql = "SELECT card_id FROM Customer WHERE id = " + buyer;
	                		rs = stmt.executeQuery(sql);
	                		int card = 0;
	                		while(rs.next()) {
	                			card = rs.getInt("card_id") ;
	                		}
	                      
	                		temp = JOptionPane.showInputDialog("Please enter seat number");
	                		int seat_no = Integer.parseInt(temp);
	                		String type = JOptionPane.showInputDialog("Please enter type (Regular or 3D)");
	                		sql = "INSERT INTO Tickets(title,name,ticket_number,beg_time,end_time,type,buyer) VALUES (\"" + title + "\" ," + screen + "," + seat_no + ",\"" + begin_s + "\",\"2016-01-01 00:00:00 \",\"" + type + "\"," + buyer + ")";
	                		System.out.println(sql);
	                		stmt.executeUpdate(sql);
	                		textArea.append("Customer's " + buyer + " card is " + card + "\n");
	                		int free = 0;
	                		sql = "SELECT free_tickets FROM Bonus_Card WHERE card_id = " + card;
	                		rs = stmt.executeQuery(sql);  
	                		while(rs.next()) {
	                			free = rs.getInt("free_tickets") ;
	                		}
	                		textArea.append("This card has " + free + " tickets available" + "\n");
	                		JOptionPane.showMessageDialog(null, textArea, "Ticket Price", JOptionPane.INFORMATION_MESSAGE);
	                		
	                		int choice2 = 0;
	                		if(free > 0) {
	                			temp = JOptionPane.showInputDialog("Do you want to redeem a ticket ( yes = 1 / no = 0 )");
	                			choice2 = Integer.parseInt(temp);
	                			if (choice2 == 1) {
	                				sql = "UPDATE Bonus_Card SET free_tickets = free_tickets - 1 WHERE card_id = " + card;
	                				stmt.executeUpdate(sql);   
	                			}
	                		} if(choice2 == 0) {
	                			if(type.equals("Regular"))
	                				price += 20;
	                			else
	                				price += 30;
	                		}
	                		if(i == amount)
	                			textArea.append("Total Price : " + price + "\n");
	                		else
	                			textArea.append("Partial Price : " + price + "\n");
	                      
	                		JOptionPane.showMessageDialog(null, textArea, "Ticket Price", JOptionPane.INFORMATION_MESSAGE);
	                   }
	                }
				} catch(SQLException se){
	       	         se.printStackTrace();
	       	    } catch(Exception e2){
	       	         e2.printStackTrace();
	       	    } finally{
	       	    	try{
	       	    		if(stmt!= null)
	       	               stmt.close();
	       	    	} catch(SQLException se2){
	       	        }
	       	        try{
	       	            if(conn!= null)
	       	               conn.close();
	       	        } catch(SQLException se){
	       	            se.printStackTrace();
	       	        }
	       	    }
			}	
		});
		button1.setBounds(70, 75, 380, 50);
		frame.getContentPane().add(button1);
		
		JButton button2 = new JButton("Update Customer's Personal Info");
		button2.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//click
				frame.dispose();
				
				try{
					Class.forName("com.mysql.jdbc.Driver");
			        conn = DriverManager.getConnection(DB_URL,USER,PASS);
			        stmt = conn.createStatement();
			        
			        String temp, sql, birthday, marital_status, sex, card_id = "0", points, title, rating;
			        JTextArea textArea = new JTextArea();
			        temp = JOptionPane.showInputDialog("Please enter id");
                    int id = Integer.parseInt(temp);                 
                    sql = "SELECT * FROM Customer WHERE id = " + id;
                    rs = stmt.executeQuery(sql);
                    if(rs.next()) {
                    	rs = stmt.executeQuery(sql);
                    	textArea.setText("This customer's stored information is : " + "\n");
                    	while(rs.next()) {
                    		birthday = rs.getString("birthday");
                    		marital_status = rs.getString("marital_status");
                    		sex = rs.getString("sex");
                    		card_id = rs.getString("card_id");
                    		textArea.append("Birthday : " + birthday + "\n"
                    				+ "Marital Status : " + marital_status + "\n"
                          			+ "Sex : " + sex + "\n"
                          			+ "Card ID : " + card_id + "\n");
                    	}
                       
                    	sql = "SELECT bonus_points FROM Bonus_Card WHERE card_id = " + card_id;
                    	rs = stmt.executeQuery(sql);
                    	while(rs.next()) {
                    		points = rs.getString("bonus_points");
                    		textArea.append("Bonus Points : " + points + "\n");
                    	}
                    	sql = "SELECT title,rating FROM Movies_Watched WHERE id = " + id;
                    	rs = stmt.executeQuery(sql);
                    	textArea.append("\nMovies Watched : \n");
                    	while(rs.next()) {
                    		title = rs.getString("title");
                    		rating = rs.getString("rating");
                    		textArea.append(title + "[" + rating + "]" + "\n");
                    	}
                    	textArea.append("\n( The rating is displayed in square brackets ) \n");
                    	JScrollPane scrollPanel = new JScrollPane(textArea);
                    	JOptionPane.showMessageDialog(null, scrollPanel, "Customer's Info", JOptionPane.INFORMATION_MESSAGE);

                    	temp = JOptionPane.showInputDialog("Please choose what you want to update" + "\n"
                    		   								+ "1.Birthday" + "\n"
                    		   								+ "2.Marital Status" + "\n"
                    		   								+ "3.Sex" + "\n"
                    		   								+ "4.Card id" + "\n"
                    		   								+ "5.Points" + "\n");
                    	int tmp = Integer.parseInt(temp); 
                    	int flag = 0 ;
                    	String change = "";
                    	switch(tmp) {
                       		case (1):                            
                       			change = "birthday";
                       			break;                       		
                       		case (2):                           
                       			change = "marital_status";
                       			break;
                       		case (3):                          
                       			change = "sex";
                       			break;
                       		case (4):                      
                       			change = "card_id";
                       			break;
                       		case (5):                           
                       			change = "bonus_points";
                       			flag = 1;
                       			break;	
                    	}
                    	String value = JOptionPane.showInputDialog("Enter new value");
                    	if(flag == 0 ) {
                    		sql = "UPDATE Customer SET " + change + "= \"" + value + "\" WHERE id = " + id;
                    		stmt.executeUpdate(sql); 
                    	} else {
                    		sql = "UPDATE Bonus_Card SET " + change + "=" + value + " WHERE card_id = " + card_id;
                    		stmt.executeUpdate(sql); 
                    	}
                    	JOptionPane.showMessageDialog(null, "Database successfully updated!", "Sucess", JOptionPane.INFORMATION_MESSAGE);
                    } else
                    	JOptionPane.showMessageDialog(null, "This id is not valid!", "ERROR", JOptionPane.ERROR_MESSAGE);
				} catch(SQLException se){
	            	se.printStackTrace();
	       	    } catch(Exception e2){
	       	       e2.printStackTrace();
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
		});
		button2.setBounds(70, 175, 380, 50);
		frame.getContentPane().add(button2);
	}

}
