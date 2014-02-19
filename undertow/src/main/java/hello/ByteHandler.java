package hello;

import static hello.HelloWebServer.*;
import io.undertow.server.*;
import io.undertow.util.*;

public class ByteHandler implements HttpHandler
{
  private static final String aByte = "a";

  @Override
  public void handleRequest(HttpServerExchange exchange) throws Exception
  {
    exchange.getResponseHeaders().put(
        Headers.CONTENT_TYPE, TEXT_PLAIN);
    exchange.getResponseSender().send(aByte);
  }

}
