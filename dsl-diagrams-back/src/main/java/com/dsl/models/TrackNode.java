package com.dsl.models;

import java.util.List;

public record TrackNode(
        String name,
        List<StateNode> states
) { }
