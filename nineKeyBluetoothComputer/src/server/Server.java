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
                }
            }
        }
        catch (Exception e) {
            System.err.println(e);
        }
    }

    public void startServer() {
        // TODO: do we want to reuse the connection? probably...
        try {
            serverSocket = new ServerSocket(PORT_NUMBER);
            printInfo();

            while (true) { //TODO: make it end eventually
                Socket clientSocket = serverSocket.accept();

                BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                String line = reader.readLine();
                System.out.println(line);
                Typer typer = new Typer();
                typer.typeMessage(line);
                clientSocket.close();
            }

//            serverSocket.close();
        }
        catch (IOException e) {
            System.err.println(e);
        }
    }

    public static void main(String[] args) {
        Server server = new Server(3000);
        server.startServer();
    }
}
