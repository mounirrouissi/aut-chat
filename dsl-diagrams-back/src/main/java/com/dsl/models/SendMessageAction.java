// SendMessageAction.java
package com.dsl.models;

public record SendMessageAction(String channel, String from, String to, String template) implements Action {}
