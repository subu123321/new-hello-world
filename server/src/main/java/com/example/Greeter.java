package com.example;

/**
 * Builds greeting messages.
 */
public class Greeter {

  /**
   * Creates a new greeter.
   */
  public Greeter() {
    // nothing to initialise
  }

  /**
   * Returns a greeting for the given name.
   *
   * @param someone the name of the one being greeted
   * @return a greeting such as {@code "Hello, World!"}
   */
  public String greet(String someone) {
    return String.format("Hello, %s!", someone);
  }
}
