import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.stage.Stage;
import server.Server;

import java.io.IOException;

public class ComputerSideUI extends Application {
    private Server server;
    @FXML private TextField ipAddressField;
    @FXML private TextField portNumberField;
    @FXML private Button startButton;
    @FXML private Label statusField;

    private Label getStringAsLabel(String string, FontWeight fontWeight) {
        Label l = new Label(string);
        l.setFont(Font.font("Tahoma", fontWeight, 14));
        l.setWrapText(true);

        return l;
    }

    @Override
    public void start(Stage primaryStage) throws Exception {
        Parent root = FXMLLoader.load(getClass().getResource("ui.xml"));

        primaryStage.setTitle("9-Key Keyboard Computer Connection");
        primaryStage.setScene(new Scene(root, 480, 360));
        primaryStage.show();
    }

    @FXML protected void startServer(ActionEvent event) {
        Runnable serverRunnable = () -> {
            startButton.setDisable(true);
            portNumberField.setDisable(true);
            server = new Server(Integer.parseInt(portNumberField.getText()));
            ipAddressField.setText(server.getIP());
            try {
                server.startServer();
            }
            catch (IOException e) {
                System.out.println(e);
                statusField.setText("Oops! The server encountered an error.");
            }
        };

        Thread t = new Thread(serverRunnable);
        t.start();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
