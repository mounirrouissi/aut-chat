package com.dsl.models;

// Action.java

// com.dsl.models.Action
public sealed interface Action permits BranchAction, DeleteInsightAction, EndAction, GotoAction, IsSundayAction, MarkLeadPhaseAction, MarkPhaseAction, ScheduleFollowupAction, SendMessageAction, SendTemplateAction, SetMarkAction, SwitchAction, SwitchDirectionAction, UnknownAction, UnscheduleAction { }
