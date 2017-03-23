import bluetoothserver.Server;

import javax.bluetooth.*;
import java.io.IOException;

public class TestBluetooth {
    public static void main(String[] args) {


        try {
            LocalDevice localDevice = LocalDevice.getLocalDevice();
            System.out.println("Address: " + localDevice.getBluetoothAddress());
            System.out.println("Name: " + localDevice.getFriendlyName());

            Server server = new Server();
            server.startServer();
        }
        // FIXME: deal with errors properly
        catch (BluetoothStateException e) {
            e.printStackTrace();
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }
}
