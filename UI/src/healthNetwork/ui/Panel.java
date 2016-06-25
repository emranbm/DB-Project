package healthNetwork.ui;

import healthNetwork.Constants;
import healthNetwork.GraphicHandler;
import healthNetwork.SqlHandler;
import healthNetwork.customView.*;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * This class shows start page for signing in or up! For this class supposed a imaginary layout rather than
 * a layout manager for working easier with this.Magnitude of this imaginary layouts is records as final integer
 * Created by mma on 6/8/2016.
 */
public class Panel extends JFrame {

    private Connection sqlConnection;

    private int width = GraphicHandler.getInstance().getWidthScreen() * 3 / 4;
    private int height = GraphicHandler.getInstance().getHeightScreen() * 3 / 4;

    private MyPanel toolBar;
    private MyPanel sqlEditorPane;
    private MyPanel outputArea;
    private MyPanel errorLog;
    private JTextPane sqlPane;
    private JTable table ;

    /**
     * Magnitude of imaginary layouts
     */
    private final int heightOfToolBar = height / 9;
    private final int widthOfToolBar = width;
    private final int toolBarX = 0;
    private final int toolBarY = 0;
    private final int heightOfSqlEditorPanel = height / 5;
    private final int widthOfSqlEditorPanel = width;
    private final int sqlEditorPanelX = 0;
    private final int sqlEditorPanelY = heightOfToolBar;
    private final int heightOfOutputArea = height / 2;
    private final int widthOfOutputArea = width;
    private final int outputAreaX = 0;
    private final int outputAreaY = heightOfToolBar + heightOfSqlEditorPanel;
    private final int heightOfErrorLog = height * 19 / 100;
    private final int widthOfErrorLog = width;
    private final int errorLogX = 0;
    private final int errorLogY = heightOfToolBar + heightOfSqlEditorPanel + heightOfOutputArea;

    public Panel(Connection sqlConnection) {
        super();

        initialize(sqlConnection);

        setToolBar();

        setSqlEditorPane();

        setOutputArea();

        setErrorLog();

        AddComponentsToFrame();

        setVisible(true);
    }

    private void setSqlEditorPane() {
        sqlEditorPane = new MyPanel(Constants.blueBackJPGPath);
        sqlEditorPane.setSize(widthOfSqlEditorPanel, heightOfSqlEditorPanel);
        sqlEditorPane.setLocation(sqlEditorPanelX, sqlEditorPanelY);

        sqlPane = new JTextPane();
        sqlPane.setSize(widthOfSqlEditorPanel * 19 / 20, heightOfSqlEditorPanel * 19 / 20);
        sqlPane.setLocation(0, 0);

        JScrollPane scrollPane = new JScrollPane(sqlPane, JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED, JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
        scrollPane.setSize(widthOfSqlEditorPanel * 19 / 20, heightOfSqlEditorPanel * 19 / 20);
        scrollPane.setLocation(widthOfSqlEditorPanel * 1 / 40, heightOfSqlEditorPanel * 1 / 40);
        sqlEditorPane.add(scrollPane);
    }

    private void setOutputArea() {
        outputArea = new MyPanel(Constants.blueBackJPGPath);
        outputArea.setLocation(outputAreaX, outputAreaY);
        outputArea.setSize(widthOfOutputArea, heightOfOutputArea);
    }

    private void setErrorLog() {
        errorLog = new MyPanel(Constants.blueBackJPGPath);
        errorLog.setSize(widthOfErrorLog, heightOfErrorLog);
        errorLog.setLocation(errorLogX, errorLogY);

        JTextPane errorPane = new JTextPane();
        errorPane.setSize(this.getWidth(), this.getHeight());
        errorPane.setLocation(0, 0);
        errorPane.setEditable(false);

        MyErrorPane scrollPane = new MyErrorPane(errorPane);
        scrollPane.setSize(widthOfErrorLog * 19 / 20, heightOfErrorLog * 19 / 20);
        scrollPane.setLocation(widthOfErrorLog * 1 / 40, heightOfErrorLog * 1 / 40);

        errorLog.add(scrollPane);
    }

    private void initialize(Connection sqlConnection) {
        this.sqlConnection = sqlConnection;

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

    private void setToolBar() {
        toolBar = new MyPanel(Constants.blueBackJPGPath);
        toolBar.setLocation(toolBarX, toolBarY);
        toolBar.setSize(widthOfToolBar, heightOfToolBar);

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
                dispose();
            }
        });

        JToolBar bar = new JToolBar();
        bar.setLocation(widthOfToolBar / 60, heightOfToolBar / 5);
        bar.setSize(exit.getWidth() * 2, exit.getHeight() * 2);
        bar.setBorder(BorderFactory.createEmptyBorder());
        bar.setFloatable(false);
        bar.add(exit);

        JButton exe = new MyButton();
        exe.setLocation(0, 0);
        exe.setSize(Constants.sizeOfExitButton, Constants.sizeOfExitButton);
        exe.setIcon(new ImageIcon(getClass().getResource(Constants.executePNGPath)));
        exe.setBorder(BorderFactory.createEmptyBorder());
        //exit.setBackground(Color.decode("#01aaeb"));
        exe.setToolTipText("execute");
        exe.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent arg0) {
                String query = sqlPane.getText();
                MyErrorPane errorPane = ((MyErrorPane) errorLog.getComponent(0));
                try {
                    Statement statement = sqlConnection.createStatement();
                    long t = System.currentTimeMillis();

                    boolean hasResultSet = statement.execute(query);
                    t = System.currentTimeMillis() - t;

                    ResultSet lastRS = null;

                    while (statement.getUpdateCount() != -1) {
                        boolean tmp = statement.getMoreResults();
                        hasResultSet = tmp || hasResultSet;
                        if (tmp)
                            lastRS = statement.getResultSet();
                    }

                    if (hasResultSet) {
                        ResultSet resultSet = lastRS;//statement.getResultSet();
                        table = null ;
                        table = new JTable(SqlHandler.buildTableModel(resultSet));
                        customizeComponent(table);
                        JScrollPane scrollPane = new JScrollPane(table);
                        customizeComponent(scrollPane);
                        addComponentToOutput(scrollPane);
                    }
                    errorPane.append("query ok. in " + t + " milliseconds");
                } catch (SQLException e) {
                    //e.printStackTrace();
                    errorPane.append("query failed: " + e.getMessage());
                }
            }

            private void customizeComponent(JComponent component) {
                component.setVisible(true);
                component.setSize(outputArea.getWidth() * 19 / 20, outputArea.getHeight() * 19 / 20);
                component.setLocation(widthOfOutputArea / 40, heightOfOutputArea / 40);
            }

            private void addComponentToOutput(JComponent component) {
                outputArea.removeAll();
                outputArea.add(component);
                outputArea.repaint();
            }
        });

        JToolBar bar2 = new JToolBar();
        bar2.setLocation(widthOfToolBar / 2, heightOfToolBar / 5);
        bar2.setSize(exe.getWidth() * 2, exe.getHeight() * 2);
        bar2.setBorder(BorderFactory.createEmptyBorder());
        bar2.setFloatable(false);
        bar2.add(exe);

        JButton deleteSelectedRow = new MyButton();
        deleteSelectedRow.setLocation(0, 0);
        deleteSelectedRow.setSize(Constants.sizeOfExitButton, Constants.sizeOfExitButton);
        deleteSelectedRow.setIcon(new ImageIcon(getClass().getResource(Constants.removePNGPath)));
        deleteSelectedRow.setBorder(BorderFactory.createEmptyBorder());
        deleteSelectedRow.setToolTipText("Delete selected row");
        deleteSelectedRow.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if( outputArea.getComponentCount() == 0 ){
                    JOptionPane.showMessageDialog(Panel.this,"No table selected!");
                }else{
                    for( int i = 0 ; i < table.getColumnCount() ; i++ ) {
                        table.getValueAt(table.getSelectedRow(),i) ;
                    }
                }
            }
        });


        JToolBar bar3 = new JToolBar();
        bar3.setLocation(widthOfToolBar * 45 / 100, heightOfToolBar / 5);
        bar3.setSize(exit.getWidth() * 2, exit.getHeight() * 2);
        bar3.setBorder(BorderFactory.createEmptyBorder());
        bar3.setFloatable(false);
        bar3.add(deleteSelectedRow);

        toolBar.add(bar);
        toolBar.add(bar2);
        toolBar.add(bar3) ;
    }

//    private void setToolBar() {
//        JButton exit = new MyButton(Constants.exitJPGPath);
//        exit.setLocation(0, 0);
//        exit.setSize(Constants.sizeOfExitButton, Constants.sizeOfExitButton);
//        exit.setIcon(new ImageIcon(getClass().getResource(Constants.exitPNGPath)));
//        exit.setBorder(BorderFactory.createEmptyBorder());
//        //exit.setBackground(Color.decode("#01aaeb"));
//        exit.setToolTipText("Exit");
//        exit.addActionListener(new ActionListener() {
//
//            @Override
//            public void actionPerformed(ActionEvent arg0) {
//                // TODO Auto-generated method stub
//                dispose();
//            }
//        });
//
//        toolBar = new JToolBar();
//        toolBar.setLocation(toolBarX, toolBarY);
//        toolBar.setSize(widthOfToolBar, heightOfToolBar);
//        toolBar.setBorder(BorderFactory.createEmptyBorder());
//        toolBar.setFloatable(false);
//        toolBar.add(exit);
//    }

    private void AddComponentsToFrame() {
        getContentPane().add(toolBar);
        getContentPane().add(sqlEditorPane);
        getContentPane().add(outputArea);
        getContentPane().add(errorLog);
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
        toolBar.repaint();
        sqlEditorPane.repaint();
        outputArea.repaint();
        errorLog.repaint();
    }
}
