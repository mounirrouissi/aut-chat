package com.dsl.models;

public record MarkPhaseAction(
        String type,
        String phase
) implements Action { }
