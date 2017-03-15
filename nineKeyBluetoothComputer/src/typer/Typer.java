package typer;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.util.ArrayList;

public class Typer {
    private class TyperEvent {

    }

    private Robot robot;

    public Typer() throws AWTException {
        robot = new Robot();
    }

    private ArrayList<Integer> convertStringToVirtualKeys(String str) {
        ArrayList<Integer> virtualKeyList = new ArrayList<>();
        for (char c : str.toCharArray()) {
            virtualKeyList.add(AWTKeyStroke.getAWTKeyStroke(c).getKeyCode());
        }

        return virtualKeyList;
    }

    public void typeMessage(String str) {
        ArrayList<Integer> virtualKeyList = convertStringToVirtualKeys(str);
        for (Integer i : virtualKeyList) {
            robot.keyPress(i);
            robot.keyRelease(i);
        }
    }
}
