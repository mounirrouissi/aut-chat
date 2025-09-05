package com.dsl.models;

import java.util.List;

public record StateNode(
        String trackName,
        String id,
        List<Action> actions
) { }
