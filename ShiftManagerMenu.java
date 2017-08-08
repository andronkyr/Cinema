package projectDB;

import java.awt.EventQueue;
import javax.swing.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Font;
import java.text.*;
import java.util.Calendar;
import java.sql.*;
import java.util.Date;

public class ShiftManagerMenu {

	private JFrame frame;
	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	static final String DB_URL = "jdbc:mysql://localhost/Cinema?useSSL=false";
	static final String USER = "root";
	static final String PASS = "5853";
	
	Connection conn;
	Statement stmt; 
    ResultSet rs;

    
    
	/********** Launch the application **********/
    
	public static void shiftManagerScreen() {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					ShiftManagerMenu window = new ShiftManagerMenu();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	
	
	/********** Create the application **********/
	 
	public ShiftManagerMenu() {
		initialize();
	}

	
	
	/********** Initialize the contents of the frame **********/
	
	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 620, 400);
		frame.getContentPane().setLayout(null);
		frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		
		JLabel label = new JLabel("What do you want to do?");
		label.setFont(new Font("Dialog", Font.BOLD | Font.ITALIC, 14));
		label.setBounds(2, 2, 200, 30);
		frame.getContentPane().add(label);
		
		JButton button1 = new JButton("See the employees that are currently working");
		button1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//click
				frame.dispose();
				
				try{
					Class.forName("com.mysql.jdbc.Driver");
			        conn = DriverManager.getConnection(DB_URL,USER,PASS);
			        stmt = conn.createStatement();
			        
			        String sql;
			        JTextArea textArea = new JTextArea();
					Date curDate = new Date();
                    SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
                    SimpleDateFormat time = new SimpleDateFormat("kk:mm:ss");
                    String currentDay = date.format(curDate);
                    String currentTime = time.format(curDate);                    

                    Calendar cal = Calendar.getInstance();
                    cal.set(Calendar.HOUR_OF_DAY,8);
                    cal.set(Calendar.MINUTE,00);
                    cal.set(Calendar.SECOND,0);
                    cal.set(Calendar.MILLISECOND,0);
                    Date time_limit = cal.getTime();
                    cal.set(Calendar.HOUR_OF_DAY,18);
                    cal.set(Calendar.MINUTE,00);
                    cal.set(Calendar.SECOND,0);
                    cal.set(Calendar.MILLISECOND,0);
                    Date time_limit2 = cal.getTime();                 
                    String shift;
                    //Καθορισμός βάρδιας
                    if(curDate.compareTo(time_limit) > 0 && curDate.compareTo(time_limit2) < 0)
                    	shift = "Morning";
                    else
                    	shift = "Afternoon";

                     /*Ορισμός τρέχουσας ημερομηνίας σε 05/08/2016*/
                    /*******************************************/
                    currentDay = "2016-08-05" ; 
                    /******************************************/
                    /*Η βάρδια καθορίζεται με βάση την τρέχουσα ωρα που υπολογίζεται παραπάνω */
                    
                    sql = "SELECT Employee.id,name,lastname,job FROM Schedule INNER JOIN Employee ON Employee.id = Schedule.id WHERE Schedule.working_date = \"" + currentDay +"\" AND shift = \"" + shift +"\" ORDER BY id";
                    rs = stmt.executeQuery(sql);
                    String name,lastname,job;
                    textArea.setText("");
                    int id;
                    while(rs.next()) {
                    	id = rs.getInt("Employee.id");
                        name = rs.getString("name");
                        lastname= rs.getString("lastname");
                        job = rs.getString("job");
                        textArea.append(id + " | Name : "+ name + " | Lastname : " + lastname +" | Job : " + job + "\n");                           
                    }
                    JScrollPane scrollPanel = new JScrollPane(textArea);
                    JOptionPane.showMessageDialog(null, scrollPanel, "Currenty working employees", JOptionPane.INFORMATION_MESSAGE);
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
		button1.setBounds(70, 75, 480, 50);
		frame.getContentPane().add(button1);
		
		JButton button2 = new JButton("See the employees that worked or will work on a specific date");
		button2.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//click
				frame.dispose();
				
				try{
					Class.forName("com.mysql.jdbc.Driver");
			        conn = DriverManager.getConnection(DB_URL,USER,PASS);
			        stmt = conn.createStatement();
			        
                    String date, shift, sql, name,lastname,job;
                    int id;
                    JTextArea textArea = new JTextArea();
                    date = JOptionPane.showInputDialog("Please enter date in yyyy-MM-dd format");
                    shift = JOptionPane.showInputDialog("Please enter the shift you want ");
                    sql = "SELECT Employee.id,name,lastname,job,Schedule.shift FROM Schedule INNER JOIN Employee ON Employee.id = Schedule.id WHERE Schedule.working_date = \"" + date + "\" AND Schedule.shift = \"" + shift + "\" ORDER BY id";
                    rs = stmt.executeQuery(sql);
                    textArea.setText("");
                    while(rs.next()) {
                    	id = rs.getInt("Employee.id");
                        name = rs.getString("name");
                        lastname= rs.getString("lastname");
                        job = rs.getString("job");
                        shift = rs.getString("shift");
                        textArea.append(id + "| Name : " + name + " | Lastname : " + lastname +"  | Job : " + job + " | Shift : " + shift + "\n");                           
                    }
                    JScrollPane scrollPanel = new JScrollPane(textArea);
                    JOptionPane.showMessageDialog(null, scrollPanel, "Working employees", JOptionPane.INFORMATION_MESSAGE);
					
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
		button2.setBounds(70, 175, 480, 50);
		frame.getContentPane().add(button2);
		
		JButton button3 = new JButton("Access statistics about the cinema");
		button3.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//click
				frame.dispose();
				
				try{
					Class.forName("com.mysql.jdbc.Driver");
			        conn = DriverManager.getConnection(DB_URL,USER,PASS);
			        stmt = conn.createStatement();
			        
			        String sql,tmp, Date_1 = null, Date_2 = null;
			        int temp;
			        JTextArea textArea = new JTextArea();
			        tmp = JOptionPane.showInputDialog("Please make a selection" + "\n"									
								                    + "1.Which movies and what was their genre did men customers watch between Date_1 and Date_2 and rated 4 or 5"  + "\n"
								                    + "2.Which are the movies with the largest number of viewers between Date_1 and Date_2"  + "\n"
								                    + "3.Which customer watched the largest number of 3D movies between Date_1 and Date_2"  + "\n"
								                    + "4.What are the genres that are favored by women customers of age 20-30 "  + "\n"
								                    + "5.Which bonus cards have won free tickets between Date_1 and Date_2 and whether have they redeemed them"  + "\n"
								                    + "6.How many hours has an employee worked between Date_1 and Date_2 and how much was he paid" + "\n");
			        temp = Integer.parseInt(tmp);
              
                    if(temp != 4) {
                    	Date_1 = JOptionPane.showInputDialog("Please enter Date_1 (format yyyy-MM-dd)");
                    	Date_2 = JOptionPane.showInputDialog("Please enter Date_2 (format yyyy-MM-dd)");
                    }
                    String title, genre, id;
                    switch(temp) {
                    	case(1): 
                    		sql = "SELECT Movies_Watched.title,Genre.genre FROM Customer INNER JOIN Movies_Watched ON Customer.id = Movies_Watched.id " +
                    				"INNER JOIN Genre ON Movies_Watched.title = Genre.title WHERE Customer.sex = 'Male' AND Movies_Watched.date_watched> \" " + 
                    				Date_1 + "\" AND Movies_Watched.date_watched < \" " + Date_2 + " \" AND Movies_Watched.rating > 3 GROUP BY Movies_Watched.title,Genre.genre";
                    		rs = stmt.executeQuery(sql);
                    		textArea.setText("");
                    		while(rs.next()) {
                    			title = rs.getString("Movies_Watched.title");
                    			genre = rs.getString("Genre.genre");
                    			textArea.append(title + "  |  " + genre + "\n");                           
                    		}
                    		JOptionPane.showMessageDialog(null, textArea, "Men's rating movies", JOptionPane.INFORMATION_MESSAGE);
                    		break;                    	
                    	case(2): 
                    		Date_1 = Date_1 + " 00:00:00";
                    		Date_2 = Date_2 + " 00:00:00";

                    		sql = "SELECT title ,count(title) as tickets " +
                    				"FROM Tickets " + 
                    				"WHERE beg_time > \" " + Date_1 + " \" AND end_time < \" " + Date_2
                    				+ " \" GROUP BY (title) " +
                    				"HAVING count(title) = " +
                    				"(" +
                    				"SELECT MAX(temp) FROM (" + 
                    				"SELECT count(title) as temp "+
                    				"FROM Tickets " +
                    				"WHERE beg_time > \" " + Date_1 + " \" AND end_time < \" " + Date_2
                    				+ " \" GROUP BY (title) " +
                    				") s " +  
                    				")";
                    		rs = stmt.executeQuery(sql);
                    		String tickets;
                    		textArea.setText("");
                    		while(rs.next()) {
                    			title = rs.getString("title");
                    			tickets = rs.getString("tickets");
                    			textArea.append(title + "  |  " + tickets + "\n");                           
                    		}
                    		JOptionPane.showMessageDialog(null, textArea, "Movie with the most views", JOptionPane.INFORMATION_MESSAGE);
                    		break;	
                    	case(3): 
                    		Date_1 = Date_1 + "00:00:00";
                    		Date_2 = Date_2 + "00:00:00";
                    		sql = "SELECT Customer.id " +
                    				"FROM Customer INNER JOIN Tickets ON Customer.id = Tickets.buyer " +
                    				"WHERE Tickets.beg_time > \" " + Date_1 + " \" AND Tickets.end_time <\" " + Date_2 +
                    				" \" " +
                    				"AND type = '3D' GROUP BY (Customer.id) ORDER BY count(Customer.id) DESC LIMIT 0,1;";
                    		rs = stmt.executeQuery(sql);
                    		textArea.setText("");
                    		while(rs.next()) {
                    			id = rs.getString("Customer.id");
                    			textArea.append("Customer : " + id);                           
                    		}
                    		JOptionPane.showMessageDialog(null, textArea, "Most 3D movies", JOptionPane.INFORMATION_MESSAGE);
                    		break;
                    	case(4): 
                    		sql = "SELECT Genre.genre,count(genre) as Tickets " 
                    				+ "FROM Customer INNER JOIN Movies_Watched ON Customer.id = Movies_Watched.id " 
                    				+ "INNER JOIN Genre ON Movies_Watched.title = Genre.title WHERE Customer.sex = 'Female' " 
                    				+ "AND Customer.birthday > DATE_ADD(CURDATE(),INTERVAL -30 YEAR ) AND Customer.birthday < DATE_ADD(CURDATE(),INTERVAL -20 YEAR ) " 
                    				+ "group by genre order by count(genre) desc;";
	                    	rs = stmt.executeQuery(sql);
	                		textArea.setText("");
	                		int count;
	                		while(rs.next()) {
	                			genre = rs.getString("Genre.genre");
	                			count = rs.getInt("Tickets");
	                			textArea.append("Genre : " + genre + " Tickets : " + count + "\n");                           
	                		}
	                		JOptionPane.showMessageDialog(null, textArea, "Young women preferences", JOptionPane.INFORMATION_MESSAGE);
                    		break;
                    	case(5): 
                    		sql = "SELECT Bonus_Card.card_id as Customer, free_tickets as Tickets_Left  ,count(Free_tickets.card_id) as Times_Won FROM Bonus_Card " +
                    				"INNER JOIN Free_tickets ON Bonus_Card.card_id = Free_tickets.card_id " +
                    				"WHERE Free_tickets.date_of_winning >= \" " +Date_1 + " \" AND Free_tickets.date_of_winning  <=\" "+ Date_2
                    				+ " \" " +
                    				"GROUP BY (Free_tickets.card_id);";
                    		rs = stmt.executeQuery(sql);
                    		String times, left;
                    		textArea.setText("");
                    		while(rs.next()) {
                    			id = rs.getString("Customer");
                    			times = rs.getString("Times_Won");
                    			left = rs.getString("Tickets_Left");
                    			textArea.append("Customer : " + id + "   |   Times Won : " + times + " |  Tickets Left : " + left + "\n");                           
                    		}
                    		JOptionPane.showMessageDialog(null, textArea, "Free Tickets", JOptionPane.INFORMATION_MESSAGE);
                    		break;
                    	case(6): 
                    		sql = "SELECT name,lastname,count(Schedule.id)*10 AS Hours,count(Schedule.id)*10*hourly_salary AS Salary " +
                    				"FROM Employee INNER JOIN Schedule ON Employee.id = Schedule.id " + 
                    				"WHERE Schedule.working_date >= \" " +Date_1 + " \" AND Schedule.working_date <=\" "+ Date_2
                    				+ " \" " +
                    				"GROUP BY (Schedule.id)  ORDER BY name ASC;";
                    		rs = stmt.executeQuery(sql);
                    		String name,lastname,hours,salary;
                    		textArea.setText("");
                    		while(rs.next()) {
                    			name = rs.getString("name");
                    			lastname = rs.getString("lastname");
                    			hours = rs.getString("Hours");
                    			salary = rs.getString("Salary");
                    			textArea.append("Name : " + name + " | Lastname : " + lastname + " | Hours Worked : " + hours + " | Salary : " + salary + "\n");                           
                    		}
                    		JScrollPane ScrollPanel = new JScrollPane(textArea);
                    		JOptionPane.showMessageDialog(null, ScrollPanel, "Salaries", JOptionPane.INFORMATION_MESSAGE);
                    		break;
                    }
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
		button3.setBounds(70, 275, 480, 50);
		frame.getContentPane().add(button3);
	}
}
