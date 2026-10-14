package com.example;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import org.junit.Before;
import org.junit.Test;

public class TestGreeter {

  private Greeter greeter;

  @Before
  public void setup() {
    greeter = new Greeter();
  }

  @Test
  public void greetShouldIncludeTheOneBeingGreeted() {
    String someone = "World";

    assertTrue(greeter.greet(someone).contains(someone));
  }

  @Test
  public void greetShouldIncludeGreetingPhrase() {
    String someone = "World";

    assertTrue(greeter.greet(someone).length() > someone.length());
  }

  @Test
  public void greetShouldReturnExactMessage() {
    assertEquals("Hello, World!", greeter.greet("World"));
  }
}
