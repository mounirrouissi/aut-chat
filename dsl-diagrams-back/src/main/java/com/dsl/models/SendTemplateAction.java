package com.dsl.models;


public record SendTemplateAction(
        String templateName
) implements Action { }
