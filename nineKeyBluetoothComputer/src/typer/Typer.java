package typer;

import com.sun.rmi.rmid.ExecPermission;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.util.ArrayList;

public class Typer {
    private class TyperEvent {

    }

    private Robot robot;

    public Typer() {
        try {
            robot = new Robot();
        }
        catch (Exception e) {
            System.out.println(e);
        }
    }

    public void typeMessage(String str) {
//        ArrayList<Integer> virtualKeyList = convertStringToVirtualKeys(str);
        for (char c : str.toCharArray()) {
            robot.keyPress(Character.toUpperCase(c));
            robot.keyRelease(Character.toUpperCase(c));
        }
    }
}
