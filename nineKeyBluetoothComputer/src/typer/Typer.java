package typer;

import com.sun.rmi.rmid.ExecPermission;

import java.awt.*;
import java.awt.event.KeyEvent;

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
        for (char c : str.toCharArray()) {

        	int keyToPress;
        	boolean shiftNeeded = false;
        	switch(c) {
        	case '!':
        		keyToPress = KeyEvent.VK_1;
        		shiftNeeded = true;
        		break;
        	case '@':
        		keyToPress = KeyEvent.VK_2;
        		shiftNeeded = true;
        		break;
        	case '#':
        		keyToPress = KeyEvent.VK_3;
        		shiftNeeded = true;
        		break;
        	case '$':
        		keyToPress = KeyEvent.VK_4;
        		shiftNeeded = true;
        		break;
        	case '%':
        		keyToPress = KeyEvent.VK_5;
        		shiftNeeded = true;
        		break;
        	case '^':
        		keyToPress = KeyEvent.VK_6;
        		shiftNeeded = true;
        		break;
        	case '&':
        		keyToPress = KeyEvent.VK_7;
        		shiftNeeded = true;
        		break;
        	case '*':
        		keyToPress = KeyEvent.VK_8;
        		shiftNeeded = true;
        		break;
        	case '(':
        		keyToPress = KeyEvent.VK_9;
        		shiftNeeded = true;
        		break;
        	case ')':
        		keyToPress = KeyEvent.VK_0;
        		shiftNeeded = true;
        		break;
        	case '_':
        		keyToPress = KeyEvent.VK_MINUS;
        		shiftNeeded = true;
        		break;
        	case '+':
        		keyToPress = KeyEvent.VK_EQUALS;
        		shiftNeeded = true;
        		break;
        	case '{': 
        		keyToPress = KeyEvent.VK_OPEN_BRACKET;
        		shiftNeeded = true;
        		break;
        	case '}':
        		keyToPress = KeyEvent.VK_CLOSE_BRACKET;
        		shiftNeeded = true;
        		break;
        	case ':':
        		keyToPress = KeyEvent.VK_SEMICOLON;
        		shiftNeeded = true;
        		break;
        	case '"':
        		shiftNeeded = true;
        	case '\'':
        		keyToPress = KeyEvent.VK_QUOTE;
        		break;
        	case '|':
        		keyToPress = KeyEvent.VK_BACK_SLASH;
        		shiftNeeded = true;
        		break;
        	case '<':
        		keyToPress = KeyEvent.VK_COMMA;
        		shiftNeeded = true;
        		break;
        	case '>':
        		keyToPress = KeyEvent.VK_PERIOD;
        		shiftNeeded = true;
        		break;
        	case '?':
        		keyToPress = KeyEvent.VK_SLASH;
        		shiftNeeded = true;
        		break;
        	case '~':
        		shiftNeeded = true;
        	case '`':
        		keyToPress = KeyEvent.VK_BACK_QUOTE;
        		break;
        	default:
        		if( c >= 'A' && c <= 'Z' ) 
        			shiftNeeded = true;
        		keyToPress = Character.toUpperCase(c);
        	}
        	
        	if( shiftNeeded ) 
        		robot.keyPress(KeyEvent.VK_SHIFT);
        	robot.keyPress(keyToPress);
        	robot.keyRelease(keyToPress);
        	if( shiftNeeded )
        		robot.keyRelease(KeyEvent.VK_SHIFT);
        }
    }
}
