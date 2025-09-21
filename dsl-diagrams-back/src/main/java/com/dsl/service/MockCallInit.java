package com.dsl.service;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Call;
import com.twilio.type.PhoneNumber;

import java.net.URI;

public class MockCallInit {
    public static void main(String[] args) {
        String url = "https://c24221ad324e.ngrok-free.app/api/twilio/voice";
        Twilio.init("AC7e96d8d08434a57adcb77a58158d1478", "f7c0c6e605260ad9635587c716838997");

        Call call = Call.creator(
                new PhoneNumber("+21650695820"),
                new PhoneNumber("+12135664564"),
                URI.create(url)
        ).create();

        call.getSid();

    }
}
