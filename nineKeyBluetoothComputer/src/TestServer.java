import server.Server;

import java.io.IOException;

public class TestServer {
    public static void main(String[] args) {
        Server server = new Server(4000);
        server.startServer();
    }
}
