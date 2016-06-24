package healthNetwork;

import healthNetwork.GraphicHandler;
import healthNetwork.customView.MyButton;
import healthNetwork.customView.MyLabel;
import healthNetwork.customView.MyPasswordField;
import healthNetwork.customView.MyTextField;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.* ;  // for standard JDBC programs
import java.math.* ;

/**
 * This class shows start page for signing in or up! For this class supposed a imaginary layout rather than
 * a layout manager for working easier with this.Magnitude of this imaginary layouts is records as final integer
 * Created by mma on 6/8/2016.
 */
public class StartPage extends JFrame {

    private int width = GraphicHandler.getInstance().getWidthScreen() / 4;
    private int height = GraphicHandler.getInstance().getHeightScreen() / 3;
    private MyLabel titleLbl;
    private MyTextField idField;
    private JPasswordField passwordField;
    private JButton signInBtn;
    private JToolBar toolBar;

    /**
     * Magnitude of imaginary layouts
     */
    private final int heightOfTitleBar = height / 7;
    private final int widthOfTitleBar = width;
    private final int titleBarX = 0;
    private final int titleBarY = height / 15;
    private final int titleFontSize = 35;
    private final int mainPanelX = 0;
    private final int mainPanelY = heightOfTitleBar;
    private final int heightOfMainPanel = height * 5 / 7;
    private final int widthOfMainPanel = width;
    private final int toolBarX = 0;
    private final int toolBarY = heightOfTitleBar + heightOfMainPanel;
    private final int heightOfToolBar = height - (heightOfMainPanel + heightOfTitleBar);
    private final int widthOfToolBar = width;

    public StartPage() {
        super();

        initialize();

        setTitle();

        setMainPanel();

        setToolBar();

        AddComponentsToFrame();

        setVisible(true);
    }

    private void setMainPanel() {
        idField = new MyTextField("ID", Constants.buttonJPGPath);
        idField.setSize(width * 2 / 3, height / 8);
        idField.setLocation(widthOfMainPanel / 2 - idField.getWidth() / 2, mainPanelY + heightOfMainPanel / 4);

        passwordField = new MyPasswordField("Password", Constants.buttonJPGPath);
        passwordField.setSize(width * 2 / 3, height / 8);
        passwordField.setLocation(widthOfMainPanel / 2 - idField.getWidth() / 2, mainPanelY + heightOfMainPanel / 2);

        signInBtn = new MyButton("sign in", Constants.buttonJPGPath);
        signInBtn.setSize(passwordField.getWidth() / 2, heightOfMainPanel / 5);
        signInBtn.setLocation(widthOfMainPanel / 2 - signInBtn.getWidth() / 2, mainPanelY + heightOfMainPanel * 5 / 6);
        signInBtn.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                try {
                    Class.forName("com.mysql.jdbc.Driver");

                    String pass = null;
                    if (passwordField.getPassword() != null) {
                        pass = new String(passwordField.getPassword());
                        System.out.println(pass);
                    }

                    Connection conn = DriverManager.getConnection(
                            "jdbc:mysql://localhost/db_project",
                            "root@localhost" , pass
                    );

//                    Statement statement = conn.createStatement();
//                    ResultSet resultSet = statement.executeQuery("select * from job_distribution");
//                    resultSet.next();
//                    System.out.println(resultSet.getString("job"));
                }
                catch(ClassNotFoundException ex) {
                    System.out.println("Error: unable to load driver class!");
                    System.exit(1);
                } catch (SQLException e1) {
                    e1.printStackTrace();
                    JOptionPane.showMessageDialog(StartPage.this,"No such User registered!");
                }


            }
        });
    }

    private void initialize() {
        GraphicHandler graphicHandler = GraphicHandler.getInstance();

        this.setSize(width, height);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        graphicHandler.placeInCenter(this);
        this.setResizable(false);
        this.setLayout(null);
        this.setUndecorated(true);

        try {
            UIManager
                    .setLookAndFeel(Constants.nimbusLookAndFeel);
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (InstantiationException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (UnsupportedLookAndFeelException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    private void setTitle() {
        titleLbl = new MyLabel(Constants.appName, Constants.labelJPGPath, JLabel.CENTER);
        titleLbl.setLocation(titleBarX, titleBarY);
        titleLbl.setSize(widthOfTitleBar, heightOfTitleBar);
        titleLbl.setForeground(Color.WHITE);
        titleLbl.setFont(new Font(Constants.arilFont, Font.CENTER_BASELINE, titleFontSize));
    }

    private void setToolBar() {
        JButton exit = new MyButton(Constants.exitJPGPath);
        exit.setLocation(0, 0);
        exit.setSize(Constants.sizeOfExitButton, Constants.sizeOfExitButton);
        exit.setIcon(new ImageIcon(getClass().getResource(Constants.exitPNGPath)));
        exit.setBorder(BorderFactory.createEmptyBorder());
        //exit.setBackground(Color.decode("#01aaeb"));
        exit.setToolTipText("Exit");
        exit.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent arg0) {
                // TODO Auto-generated method stub
                dispose();
            }
        });

        toolBar = new JToolBar();
        toolBar.setLocation(toolBarX, toolBarY);
        toolBar.setSize(widthOfToolBar, heightOfToolBar);
        toolBar.setBorder(BorderFactory.createEmptyBorder());
        toolBar.setFloatable(false);
        toolBar.add(exit);
    }

    private void AddComponentsToFrame() {
        getContentPane().add(titleLbl);
        getContentPane().add(toolBar);
        getContentPane().add(idField);
        getContentPane().add(passwordField);
        getContentPane().add(signInBtn);
    }

    /**
     * This method draws a blue image background of this frame
     *
     * @param g
     */
    @Override
    public void paint(Graphics g) {
        super.paint(g);

        Image image = new ImageIcon(getClass().getResource(Constants.blueBackJPGPath)).getImage();
        g.drawImage(image, 0, 0, width, height, null);

        componentRepaint();
    }

    private void componentRepaint() {
        titleLbl.repaint();
        toolBar.getComponent(0).repaint();
        signInBtn.repaint();
        idField.repaint();
        passwordField.repaint();
    }
}
