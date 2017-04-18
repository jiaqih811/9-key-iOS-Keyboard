import javafx.application.Application;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.event.ActionEvent;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.io.PrintWriter;
import java.net.Socket;

public class TestClient extends Application {

    private Socket socket;
    private PrintWriter out;

    @FXML private TextField ipAddressField;
    @FXML private TextField portNumberField;
    @FXML private TextField stringField;

    @Override
    public void start(Stage primaryStage) throws Exception {
        socket = null;

        Parent root = FXMLLoader.load(getClass().getResource("client.xml"));
        primaryStage.setScene(new Scene(root, 300, 250));
        primaryStage.show();
    }

    @FXML protected void sendString(ActionEvent event) {
        try {
            if (socket == null) {
                socket = new Socket(ipAddressField.getText(),
                        Integer.parseInt(portNumberField.getText()));
                out = new PrintWriter(socket.getOutputStream(), true);
            }

            out.println(stringField.getText());
        }
        catch (Exception e) {
            System.err.println(e);
            System.exit(1);
        }
    }

    public static void main(String[] args) {
        launch(args);
    }
}
