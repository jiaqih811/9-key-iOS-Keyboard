import server.Server;

import java.io.IOException;

public class TestServer {
    public static void main(String[] args) {
        Server server = new Server(3000);
        server.startServer();
    }
}
