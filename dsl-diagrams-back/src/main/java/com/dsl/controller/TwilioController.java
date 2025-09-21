package com.dsl.controller;

import com.dsl.service.EnhancedNLPService;
import com.dsl.service.TwilioService;
import com.dsl.controller.NLPResult;
import com.dsl.controller.UserContext;
import com.twilio.twiml.VoiceResponse;
import com.twilio.twiml.TwiMLException;
import com.twilio.twiml.voice.Gather;
import com.twilio.twiml.voice.Say;
import com.twilio.twiml.voice.Hangup;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/twilio")
public class TwilioController {

    private static final Logger logger = LoggerFactory.getLogger(TwilioController.class);

    private final EnhancedNLPService nlpService;
    private final TwilioService twilioService;

    @Value("${twilio.base-url}")
    private String baseUrl;

    @Autowired
    public TwilioController(EnhancedNLPService nlpService, TwilioService twilioService) {
        this.nlpService = nlpService;
        this.twilioService = twilioService;
    }

    @PostMapping(value = "/voice", produces = MediaType.APPLICATION_XML_VALUE)
    public String handleIncomingCall() {
        try {
            VoiceResponse twiml = new VoiceResponse.Builder()
                    .say(new Say.Builder("Hello! Please tell me how I can help you today.").build())
                    .gather(new Gather.Builder()
                            .inputs(Gather.Input.SPEECH)
                            .action("/api/twilio/process-speech")
                            .speechTimeout("auto")
                            .build())
                    .build();
            return twiml.toXml();
        } catch (TwiMLException e) {
            logger.error("Error generating TwiML for incoming call", e);
            // Return a valid empty response to avoid an error on Twilio's side
            return new VoiceResponse.Builder().build().toXml();
        }
    }

    @PostMapping(
            value = "/process-speech",
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_XML_VALUE
    )
    public String processSpeech(
            @RequestParam(value = "SpeechResult", required = false) String speechResult,
            @RequestParam(value = "Confidence", required = false) Double confidence) {

        logger.info("Received speech result: '{}' with confidence: {}", speechResult, confidence);

        if (speechResult == null || speechResult.isBlank()) {
            return handleFallback("I'm sorry, I didn't catch that. Could you please repeat yourself?");
        }

        // Best Practice: Check the confidence score. [9]
        // You might want to handle low-confidence transcriptions differently.
        if (confidence != null && confidence < 0.5) {
            return handleFallback("I'm not very confident I understood you correctly. Can you please say that again?");
        }

        // In a real application, you would retrieve a persistent user context based on the 'CallSid' or 'From' number.
        UserContext context = new UserContext();

        NLPResult nlpResult = nlpService.processMessage(speechResult, context);

        String responseMessage = nlpResult != null ? nlpResult.getSuggestedResponse() : null;
        if (responseMessage == null || responseMessage.isBlank()) {
            responseMessage = "I'm sorry, I couldn't find an answer for that. Please try asking in a different way.";
        }

        try {
            VoiceResponse twiml = new VoiceResponse.Builder()
                    .say(new Say.Builder(responseMessage).build())
                    .hangup(new Hangup.Builder().build())
                    .build();

            return twiml.toXml();
        } catch (TwiMLException e) {
            logger.error("Error generating TwiML for speech processing", e);
            return new VoiceResponse.Builder().build().toXml();
        }
    }

    /**
     * Handles cases where speech is not understood or confidence is low, prompting the user to try again.
     */
    private String handleFallback(String message) {
        try {
            Say say = new Say.Builder(message).build();
            // Re-gather input instead of hanging up
            Gather gather = new Gather.Builder()
                    .inputs(Gather.Input.SPEECH)
                    .action("/api/twilio/process-speech")
                    .speechTimeout("auto")
                    .build();

            VoiceResponse twiml = new VoiceResponse.Builder()
                    .say(say)
                    .gather(gather)
                    .build();
            return twiml.toXml();
        } catch (TwiMLException e) {
            logger.error("Error generating TwiML for fallback", e);
            return new VoiceResponse.Builder().hangup(new Hangup.Builder().build()).build().toXml();
        }
    }

    @PostMapping("/make-call")
    public String makeCall(@RequestParam String to) {
        String url = baseUrl + "/api/twilio/voice";
        logger.info("Making outbound call to {} with TwiML URL: {}", to, url);
        return twilioService.makeCall(to, url);
    }
}