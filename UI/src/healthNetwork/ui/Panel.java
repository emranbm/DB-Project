package healthNetwork.ui;

import healthNetwork.Constants;
import healthNetwork.GraphicHandler;
import healthNetwork.customView.*;

import javax.swing.*;
import java.awt.*;

/**
 * This class shows start page for signing in or up! For this class supposed a imaginary layout rather than
 * a layout manager for working easier with this.Magnitude of this imaginary layouts is records as final integer
 * Created by mma on 6/8/2016.
 */
public class Panel extends JFrame {

    private int width = GraphicHandler.getInstance().getWidthScreen() * 3 / 4;
    private int height = GraphicHandler.getInstance().getHeightScreen() * 3 / 4;

    private MyPanel toolBar ;
    private MyPanel sqlEditorPane ;
    private MyPanel outputArea ;
    private MyPanel errorLog ;

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
    private final int heightOfErrorLog = height * 19 / 100 ;
    private final int widthOfErrorLog = width;
    private final int errorLogX = 0;
    private final int errorLogY = heightOfToolBar + heightOfSqlEditorPanel + heightOfOutputArea;

    public Panel() {
        super();

        initialize();

        setToolBar();

        setSqlEditorPane();

        setOutputArea();

        setErrorLog() ;

        AddComponentsToFrame();

        setVisible(true);
    }

    private void setSqlEditorPane(){
        sqlEditorPane = new MyPanel(Constants.blueBackJPGPath) ;
        sqlEditorPane.setSize(widthOfSqlEditorPanel , heightOfSqlEditorPanel);
        sqlEditorPane.setLocation(sqlEditorPanelX , sqlEditorPanelY);
    }

    private void setOutputArea(){
        outputArea = new MyPanel(Constants.blueBackJPGPath) ;
        outputArea.setLocation(outputAreaX , outputAreaY);
        outputArea.setSize(widthOfOutputArea , heightOfOutputArea);
    }

    private void setErrorLog(){
        errorLog = new MyPanel(Constants.blueBackJPGPath) ;
        errorLog.setSize(widthOfErrorLog , heightOfErrorLog );
        errorLog.setLocation(errorLogX , errorLogY);
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

    private void setToolBar() {
        toolBar = new MyPanel(Constants.blueBackJPGPath) ;
        toolBar.setLocation(toolBarX , toolBarY);
        toolBar.setSize(widthOfToolBar , heightOfToolBar);

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