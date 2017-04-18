package server;

import typer.Typer;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.*;
import java.util.Enumeration;

public class Server {
    private final int PORT_NUMBER;
    private ServerSocket serverSocket;

    public Server(int portNumber) {
        this.PORT_NUMBER = portNumber;
    }

    // FIXME: find out how MWireless IPs work
    public String getIP() {
        try {
            for (Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();
                    interfaces.hasMoreElements(); ) {
                NetworkInterface networkInterface = interfaces.nextElement();
                for (Enumeration<InetAddress> inetAddresses = networkInterface.getInetAddresses();
                        inetAddresses.hasMoreElements(); ) {
                    InetAddress address = inetAddresses.nextElement();
                    if (address.isSiteLocalAddress()) {
                        return address.toString();
                    }
                    else if (address.isAnyLocalAddress()) {
                        return address.toString();
                    }
                    // MWireless is weird
                    else if (address.toString().startsWith("/35.")) {
                        return address.toString();
                    }

                }
            }
        }
        catch (Exception e) {
            System.err.println(e);
        }

        return "unknown";
    }

    private void printInfo() {
        try {
            for (Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();
                    interfaces.hasMoreElements(); ) {
                NetworkInterface networkInterface = interfaces.nextElement();
                for (Enumeration<InetAddress> inetAddresses = networkInterface.getInetAddresses();
                        inetAddresses.hasMoreElements(); ) {
                    InetAddress address = inetAddresses.nextElement();
                    if (address.isSiteLocalAddress()) {
                        System.out.println(address);
                    }
                    if (address.isAnyLocalAddress()) {
                        System.out.println(address);
                    }

//                    System.out.println(address);
                }
            }
        }
        catch (Exception e) {
            System.err.println(e);
        }
    }
    // how long need to press buttons for
    public void startServer() throws IOException {
        serverSocket = new ServerSocket(PORT_NUMBER, 1);
        printInfo();

        while (true) { //TODO: make it end eventually
            Socket clientSocket = serverSocket.accept();
            System.out.println("Connection accepted");

            while (true) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                String line = reader.readLine(); // TODO: why do spaces cause this to infinite loop??
                System.out.println(line);
                Typer typer = new Typer();
                typer.typeMessage(line);
            }
        }
    }

    public static void main(String[] args) throws IOException {
        Server server = new Server(3000);
        server.startServer();
    }
}
