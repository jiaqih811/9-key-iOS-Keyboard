import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;
import typer.Typer;

public class testGui extends Application {

    Typer typer;

//    public static void main(String[] args) {
//        launch(args);
//    }

    @Override
    public void start(Stage primaryStage) {
        typer = new Typer();

        primaryStage.setTitle("Robot Test GUI");

        TextField robotText = new TextField();
        Button runRobotBtn = new Button("Type Text");

        runRobotBtn.setOnAction(handle -> {
            try {
                Thread.sleep(3000);
            }
            catch (Exception e) {
                throw new RuntimeException("Thread sleep failed");
            }

            typer.typeMessage(robotText.getText());
        });

        GridPane root = new GridPane();
        GridPane.setConstraints(robotText, 1, 0);
        GridPane.setConstraints(runRobotBtn, 1, 1);
        root.getChildren().add(robotText);
        root.getChildren().add(runRobotBtn);
        primaryStage.setScene(new Scene(root, 300, 250));
        primaryStage.show();
    }
}
