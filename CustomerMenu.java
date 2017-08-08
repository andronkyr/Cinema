package projectDB;

import java.awt.EventQueue;
import javax.swing.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Font;
import java.sql.*;

public class CustomerMenu {

	private JFrame frame;
	private JTextField textField;
		
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	static final String DB_URL = "jdbc:mysql://localhost/Cinema?useSSL=false";
	static final String USER = "root";
	static final String PASS = "5853";
	
	Connection conn;
	Statement stmt; 
    ResultSet rs;

    
    
    /********** Launch the application **********/
    
	public static void customerScreen() {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					CustomerMenu window = new CustomerMenu();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	
	
	/********** Create the application **********/
	
	public CustomerMenu() {
		initialize();
	}

	
	
	/********** Initialize the contents of the frame **********/
	
	private void initialize() {
		frame = new JFrame();
		frame.getContentPane().setEnabled(false);
		frame.setBounds(100, 100, 340, 250);
		frame.getContentPane().setLayout(null);
		frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		
		JLabel label = new JLabel("Enter your ID");
		label.setFont(new Font("Dialog", Font.BOLD | Font.ITALIC, 14));
		label.setBounds(2, 2, 200, 30);
		frame.getContentPane().add(label);
		
		textField = new JTextField();
		textField.setBounds(70, 50, 200, 50);
		textField.setColumns(10);
		frame.getContentPane().add(textField);
		
		JButton button = new JButton("OK");
		button.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//click
				frame.dispose();
				
				try{
					Class.forName("com.mysql.jdbc.Driver");
			        conn = DriverManager.getConnection(DB_URL,USER,PASS);
			        stmt = conn.createStatement();
										
					String sql, birthday, marital_status, sex, card_id = "0", points, title, rating;
					int custID;
					JTextArea textArea = new JTextArea();
					String tmp = textField.getText().trim();
					custID = Integer.parseInt(tmp);
					
					sql = "SELECT * FROM Customer WHERE id = " + custID;
	                rs = stmt.executeQuery(sql);
	                if(rs.next()) {
	                	rs = stmt.executeQuery(sql);
	                	while(rs.next()) {
	                		birthday = rs.getString("birthday");
	                		marital_status = rs.getString("marital_status");
	                		sex = rs.getString("sex");
	                		card_id = rs.getString("card_id");
	                		textArea.append("Birthday : " + birthday + "\n"
									+ "Marital Status : " + marital_status + "\n"
									+ "Sex : " + sex + "/n"
									+ "Card ID : " + card_id + "\n");
	                	}
	                	sql = "SELECT bonus_points FROM Bonus_Card WHERE card_id = " + card_id;
	                	rs = stmt.executeQuery(sql);
	                	while(rs.next()) {
	                		points = rs.getString("bonus_points");
	                		textArea.append("Bonus Points : " + points + "\n");			
	                	}
	                   
	                	sql = "SELECT title,rating FROM Movies_Watched WHERE id = " + custID;
	                	rs = stmt.executeQuery(sql);
	                	textArea.append("\nMovies Watched :" + "\n");
	                	while(rs.next()) {
	                		title = rs.getString("title");
	                		rating = rs.getString("rating");
	                		textArea.append(title + "[" + rating + "]" + "\n");
	                	}
	                	textArea.append("\n( The rating is displayed in square brackets )" + "\n");
	                	JScrollPane scrollPanel = new JScrollPane(textArea);
	                	JOptionPane.showMessageDialog(null, scrollPanel, "Customer's Info", JOptionPane.INFORMATION_MESSAGE);
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
		button.setBounds(120, 130, 100, 25);
		frame.getContentPane().add(button);
	}
}