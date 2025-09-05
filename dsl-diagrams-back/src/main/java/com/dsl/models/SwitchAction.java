package com.dsl.models;

import java.util.Map;

public record SwitchAction(String function, Map<String, String> branches) implements Action {}

