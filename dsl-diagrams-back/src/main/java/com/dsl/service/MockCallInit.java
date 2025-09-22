package com.dsl.service;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Call;
import com.twilio.type.PhoneNumber;

import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.util.Properties;

public class MockCallInit {
    public static void main(String[] args) {
        Properties props = new Properties();

        try (InputStream input = MockCallInit.class.getClassLoader()
                .getResourceAsStream("config.properties")) {

            if (input == null) {
                System.out.println("Sorry, unable to find config.properties");
                return;
            }
            props.load(input);

        } catch (IOException ex) {
            ex.printStackTrace();
            return;
        }

        // Load properties
        String accountSid = props.getProperty("twilio.accountSid");
        String authToken = props.getProperty("twilio.authToken");
        String fromNumber = props.getProperty("twilio.fromNumber");
        String toNumber = props.getProperty("twilio.toNumber");
        String url = props.getProperty("twilio.url");

        // Init Twilio
        Twilio.init(accountSid, authToken);

        // Make call
        Call call = Call.creator(
                new PhoneNumber(toNumber),   // recipient
                new PhoneNumber(fromNumber), // sender (Twilio number)
                URI.create(url)
        ).create();

        System.out.println("Call initiated, SID: " + call.getSid());
    }
}
