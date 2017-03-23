package bluetoothserver;

import javax.bluetooth.*;
import javax.microedition.io.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class Server {
    public void startServer() throws IOException {
        UUID uuid = new UUID("1001", true);
        System.out.println(uuid.toString());

        String connectionString = "btspp://localhost:" + uuid;
        StreamConnectionNotifier notifier = (StreamConnectionNotifier) Connector.open(connectionString);

        System.out.println("Server started!");
        StreamConnection connection = notifier.acceptAndOpen();
        System.out.println("Did not block");
        RemoteDevice device = RemoteDevice.getRemoteDevice(connection);
        System.out.println("Remote device address: " + device.getBluetoothAddress());
        System.out.println("Remote device name: " + device.getFriendlyName(true));

        //read string from spp client
        InputStream inStream=connection.openInputStream();
        BufferedReader bReader = new BufferedReader(new InputStreamReader(inStream));
        String lineRead = bReader.readLine();
        System.out.println(lineRead);
    }
}
