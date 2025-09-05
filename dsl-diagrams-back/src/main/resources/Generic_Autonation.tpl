START_TEMPLATE GENERIC_AUTONATION_5K_NEW_NRTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
	START_BODY

        Hi ${lead.contact.firstName?lower_case?cap_first},
        ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). Regarding the ${lead.product.year?c} ${lead.product.model?capitalize} you got in ${lead.deal.purchaseMonthInShortForm} (around ${lead.deal.purchaseOrdinalDay}), I wanted to chat with you about your 1st Scheduled Maintenance even if you have fewer miles than 5000. Is it OK if I text you?

        Prefiere Espanol?

        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AUTONATION_5K_NEW_NRTA_2ND_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
	START_BODY

        Thanks, ${lead.contact.firstName}. <#if lead.deal.numberOfMonthsSinceSoldDate??>It's been ${lead.deal.numberOfMonthsSinceSoldDate} since you got your ${lead.product.year?c} ${lead.product.model?capitalize}.</#if> I reached out to remind you about your 1st maintenance service that's due ${lead.deal.descriptiveNextServiceDate}. Even if you have fewer than 5000 miles, this service is recommended every 6 months at no cost.

        Do you want me to schedule this for you, ${lead.contact.firstName}?

	 END_BODY
END_TEMPLATE

//---------------------------------------AutoNation Generic Next Service Templates-------------------------------//

START_TEMPLATE GENERIC_AN_NEXTSERVICE_NRTA_1ST_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_TEMP; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        <#switch "${lead.futureServiceInteraction.type}">
            <#case "Type A-NOOCP">
                Hi ${lead.contact.firstName}, this is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Center). I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records, I noticed you did your last service on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} (approx. ${lead.deal.lastServiceDoneMonthCount} months ago). I wanted to chat with you about your next service (Even if you have not driven a lot of miles since your last service).<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Is it okay if I text you to discuss this further?

                Prefiere Espanol?

                ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
            <#break>
            <#case "Type A-OCP">
                Hi ${lead.contact.firstName}, this is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Center). While reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records, I noticed you did your last service on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} (approx. ${lead.deal.lastServiceDoneMonthCount} months ago). I wanted to chat with you about your next service (Even if you have not driven a lot of miles since your last service).<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Is it okay if I text you to discuss this further?

                Prefiere Espanol?

                ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
            <#break>
        </#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_NEXTSERVICE_NRTA_2ND_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; track=SCHEDULE_FOLLOWUP_NO_RESPONSE; enterpriseId=76
	END_ATTR
	START_BODY

        <#switch "${lead.futureServiceInteraction.type}">
            <#case "Type S">
                Thank you, ${lead.contact.firstName}! I reviewed your service records from ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} and noticed that your last service was done ${lead.deal.lastServiceDoneMonthCount} months ago. I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
            <#case "Type SU-A">
                Thank you, ${lead.contact.firstName}! I reviewed your service records from ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} and noticed that your last service was done ${lead.deal.lastServiceDoneMonthCount} months ago. I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
            <#case "Type SU">
                Thank you, ${lead.contact.firstName}! I reviewed your service records from ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} and noticed that your last service was done ${lead.deal.lastServiceDoneMonthCount} months ago. I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
            <#case "Type SN-A">
                Thank you, ${lead.contact.firstName}! I reviewed your service records from ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} and noticed that your last service was done ${lead.deal.lastServiceDoneMonthCount} months ago. I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
            <#case "Type SN-A-OC">
                Thank you, ${lead.contact.firstName}! I reviewed your service records from ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} and noticed that your last service was done ${lead.deal.lastServiceDoneMonthCount} months ago. I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
            <#case "Type S-OC">
                Thank you, ${lead.contact.firstName}! I reviewed your service records from ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} and noticed that your last service was done ${lead.deal.lastServiceDoneMonthCount} months ago. I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
            <#case "Type SU-A-OC">
                Thank you, ${lead.contact.firstName}! I reviewed your service records from ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} and noticed that your last service was done ${lead.deal.lastServiceDoneMonthCount} months ago. I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
            <#case "Type A-NOOCP">
                Thank you, ${lead.contact.firstName}! I reviewed your service records from ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} and noticed that your last service was done ${lead.deal.lastServiceDoneMonthCount} months ago. I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
            <#case "Type A-OCP">
                Thank you, ${lead.contact.firstName}! I reviewed your service records from ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} and noticed that your last service was done ${lead.deal.lastServiceDoneMonthCount} months ago. I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
        </#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_NEXTSERVICE_NRTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_NRAA_TEMP; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},
        I'm just following up again to remind you about your next service maintenance, on your ${lead.product.year?c} ${lead.product.model?capitalize}. If this is not the best time (or if it's early), I can follow up with you later. In case you want to book an appt, all I need is a date & time that works best for you, and I will set it up. I hope that makes it easier. : )

        Prefiere Espanol?

        ${lead.agent.agentFirstName}.
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch> ${lead.contact.firstName}

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_NEXTSERVICE_NRTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_NRAA_TEMP; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

            Hey ${lead.contact.firstName},
            I hope you receive my text this time. It's ${lead.agent.agentFirstName}. Here is why I am reaching out to you for your next service. <#if lead.brand?seq_contains("TOYOTA")>Toyota recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("LEXUS")>Lexus recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("MAZDA")>Mazda recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("KIA")>Kia recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("NISSAN")>Nissan recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("HONDA")>Honda recommends this maintenance every 7.5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("ACURA")>Acura recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("DODGE_JEEP_RAM")>The maintenance is recommended every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("HYUNDAI")>Hyundai recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("SUBARU")>Subaru recommends this maintenance every 6k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("FORD")>Ford recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("CHEVROLET")>Chevrolet recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("GMC")>GMC recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("BUICK")>Buick recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("INFINITI")>Infiniti recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("CADILLAC")>Cadillac recommends this maintenance every 5k miles or 6 months, whichever comes first.</#if> Text is usually easier & faster for booking an appt. Would you like me to schedule it for you?

            Prefiere Espanol?

            ${lead.agent.agentFirstName}
            <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_NEXTSERVICE_NRTA_3RD_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_3RD_NRAA_TEMP; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

            Hey ${lead.contact.firstName},

            It's ${lead.agent.agentFirstName} again. Not sure if you saw the last message I sent you a month ago (on ${lead.deal.lastContactedMonthOrdinalDate}). I may have contacted you too early for the next service appt on your ${lead.product.year?c} ${lead.product.model?capitalize}, I hope now is a better time. If it's easy to set your appt via text, I can help you (unless U prefer to call). Do you want me to schedule it for you?

            Prefiere Espanol?

            ${lead.agent.agentFirstName}
            <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_NEXTSERVICE_RTA_1ST_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        <#switch "${lead.futureServiceInteraction.type}">
            <#case "Type S">
                Hi ${lead.contact.firstName},
                This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Center).
                While reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records, I noticed you did your last service on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} (approx. ${lead.deal.lastServiceDoneMonthCount} months ago). I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch><#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
            <#case "Type SU-A">
                Hi ${lead.contact.firstName},
                This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Center).
                While reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records, I noticed you did your last service on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} (approx. ${lead.deal.lastServiceDoneMonthCount} months ago). I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch><#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
            <#case "Type SU">
                Hi ${lead.contact.firstName},
                This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Center).
                While reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records, I noticed you did your last service on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} (approx. ${lead.deal.lastServiceDoneMonthCount} months ago). I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch><#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
            <#case "Type SN-A">
                Hi ${lead.contact.firstName},
                This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Center).
                While reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records, I noticed you did your last service on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} (approx. ${lead.deal.lastServiceDoneMonthCount} months ago). I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch><#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
            <#case "Type SN-A-OC">
                Hi ${lead.contact.firstName},
                This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Center).
                While reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records, I noticed you did your last service on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} (approx. ${lead.deal.lastServiceDoneMonthCount} months ago). I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch><#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
            <#case "Type S-OC">
                Hi ${lead.contact.firstName},
                This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Center).
                While reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records, I noticed you did your last service on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} (approx. ${lead.deal.lastServiceDoneMonthCount} months ago). I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch><#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
            <#case "Type SU-A-OC">
                Hi ${lead.contact.firstName},
                This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Center).
                While reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records, I noticed you did your last service on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} (approx. ${lead.deal.lastServiceDoneMonthCount} months ago). I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch><#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
             <#case "Type A-NOOCP">
                Hi ${lead.contact.firstName},
                This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Center).
                While reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records, I noticed you did your last service on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} (approx. ${lead.deal.lastServiceDoneMonthCount} months ago). I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch><#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Would you like me to schedule this for you, ${lead.contact.firstName}?
             <#break>
            <#case "Type A-OCP">
                Hi ${lead.contact.firstName},
                This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Center).
                While reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records, I noticed you did your last service on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} (approx. ${lead.deal.lastServiceDoneMonthCount} months ago). I reached out to remind you about your next service that ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#case "3PA31462~2045">We recommend service every 6 months or 7.5k miles for optimal engine performance.<#break><#default>We recommend service every 6 months or 5k miles for optimal engine performance.<#break></#switch><#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Would you like me to schedule this for you, ${lead.contact.firstName}?
            <#break>
        </#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_NEXTSERVICE_RTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_NRAA_TEMP; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},
        I'm just following up again to remind you about your next service maintenance, on your ${lead.product.year?c} ${lead.product.model?capitalize}. If this is not the best time (or if it's early), I can follow up with you later. In case you want to book an appt, all I need is a date & time that works best for you, and I will set it up. I hope that makes it easier. : )

        ${lead.agent.agentFirstName}.

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_NEXTSERVICE_RTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_2ND_NRAA_TEMP; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},
        I hope you receive my text this time. It's ${lead.agent.agentFirstName}. Here is why I am reaching out to you for your next service. <#if lead.brand?seq_contains("TOYOTA")>Toyota recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("LEXUS")>Lexus recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("MAZDA")>Mazda recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("KIA")>Kia recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("NISSAN")>Nissan recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("HONDA")>Honda recommends this maintenance every 7.5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("ACURA")>Acura recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("DODGE_JEEP_RAM")>The maintenance is recommended every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("HYUNDAI")>Hyundai recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("SUBARU")>Subaru recommends this maintenance every 6k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("FORD")>Ford recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("CHEVROLET")>Chevrolet recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("GMC")>GMC recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("BUICK")>Buick recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("INFINITI")>Infiniti recommends this maintenance every 5k miles or 6 months, whichever comes first.<#elseif lead.brand?seq_contains("CADILLAC")>Cadillac recommends this maintenance every 5k miles or 6 months, whichever comes first.</#if> Text is usually easier & faster for booking an appt. Would you like me to schedule it for you?

        ${lead.agent.agentFirstName}

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_NEXTSERVICE_RTA_3RD_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_3RD_NRAA_TEMP; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},

        It's ${lead.agent.agentFirstName} again. Not sure if you saw the last message I sent you a month ago (on ${lead.deal.lastContactedMonthOrdinalDate}). I may have contacted you too early for the next service appt on your ${lead.product.year?c} ${lead.product.model?capitalize}, I hope now is a better time. If it's easy to set your appt via text, I can help you (unless U prefer to call). Do you want me to schedule it for you?

        ${lead.agent.agentFirstName}

	 END_BODY
END_TEMPLATE

//---------------------------------------AutoNation Generic 5K USED Templates-------------------------------//

START_TEMPLATE GENERIC_AN_5K_USED_NRTA_1ST_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_TEMP; serviceType=LEXUS_5K_USED,HONDA_5K_USED,TOYOTA_5K_USED,FORD_5K_USED,CHEVY_5K_USED; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

            Hi ${lead.contact.firstName},
            ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). Regarding the ${lead.product.year?c} ${lead.product.model?capitalize} you got in ${lead.deal.purchaseMonthInShortForm} ${lead.deal.purchaseYearThisYearOrLastYear} (around ${lead.deal.descriptiveDeliveryDayMonth}), I wanted to chat with you about your 1st Scheduled Maintenance (Even if you have driven fewer miles).<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch>
            Is it OK if I text you?

            Prefiere Espanol?

            ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
            <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_5K_USED_NRTA_2ND_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP; serviceType=LEXUS_5K_USED,HONDA_5K_USED,TOYOTA_5K_USED,FORD_5K_USED,CHEVY_5K_USED; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; track=SCHEDULE_FOLLOWUP_NO_RESPONSE; enterpriseId=76
	END_ATTR
	START_BODY

        Thanks, ${lead.contact.firstName}. <#if lead.deal.numberOfMonthsSinceSoldDate??>It's been ${lead.deal.numberOfMonthsSinceSoldDate} since you got your ${lead.product.year?c} ${lead.product.model?capitalize}.</#if> I reached out to remind you about your 1st Service that ${lead.deal.nextServiceWasDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay}. Even if you have driven fewer miles, this service is recommended every 6 months.

        Do you want me to schedule this for you, ${lead.contact.firstName}?

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_5K_USED_NRTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_NRAA_TEMP; serviceType=LEXUS_5K_USED,HONDA_5K_USED,TOYOTA_5K_USED,FORD_5K_USED,CHEVY_5K_USED; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

            Hello ${lead.contact.firstName},

            It seems you might have been busy the last time I reached out to you, or your vehicleDTO might not be due for its first service yet. To assist you in scheduling future appointments, could you please let me know the current mileage on your ${lead.product.year?c} ${lead.product.model?capitalize}?

            Prefiere Espanol?

            ${lead.agent.agentFirstName}
            <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch> ${lead.contact.firstName}

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_5K_USED_NRTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_NRAA_TEMP; serviceType=LEXUS_5K_USED,HONDA_5K_USED,TOYOTA_5K_USED,FORD_5K_USED,CHEVY_5K_USED; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

            Hello ${lead.contact.firstName},
            It's ${lead.agent.agentFirstName} from ${lead.office.name}. Regarding your ${lead.product.year?c} ${lead.product.model?capitalize}, which you purchased back on ${lead.deal.purchaseMonthInShortForm} ${lead.deal.purchaseOrdinalDay}. I realize I may have reached out too early last month about scheduling your first appointment. Is now a good time to discuss scheduling your first appointment?

            Prefiere Espanol?

            ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
            <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_5K_USED_RTA_1ST_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=LEXUS_5K_USED,HONDA_5K_USED,TOYOTA_5K_USED,FORD_5K_USED,CHEVY_5K_USED; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Hi ${lead.contact.firstName},
        ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). Regarding the ${lead.product.year?c} ${lead.product.model?capitalize} you got ${lead.deal.descriptiveDeliveryDate} (around ${lead.deal.descriptiveDeliveryDayMonth}), I reached out to remind you about your 1st Service that ${lead.deal.nextServiceWasDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay}. Even if you have driven fewer miles, this service is recommended every 6 months<#switch "${lead.deal.vcpApplicable}"><#case "YES">. I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO">.<#break></#switch>

        Do you want me to schedule this for you, ${lead.contact.firstName}?

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_5K_USED_RTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_NRAA_TEMP; serviceType=LEXUS_5K_USED,HONDA_5K_USED,TOYOTA_5K_USED,FORD_5K_USED,CHEVY_5K_USED; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Hello ${lead.contact.firstName},

        It seems you might have been busy the last time I reached out to you, or your vehicleDTO might not be due for its first service yet. To assist you in scheduling future appointments, could you please let me know the current mileage on your ${lead.product.year?c} ${lead.product.model?capitalize}?

	END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_5K_USED_RTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_2ND_NRAA_TEMP; serviceType=LEXUS_5K_USED,HONDA_5K_USED,TOYOTA_5K_USED,FORD_5K_USED,CHEVY_5K_USED; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Hello ${lead.contact.firstName},
        It's ${lead.agent.agentFirstName} from ${lead.office.name}. Regarding your ${lead.product.year?c} ${lead.product.model?capitalize}, which you purchased back on ${lead.deal.purchaseMonthInShortForm} ${lead.deal.purchaseOrdinalDay}. I realize I may have reached out too early last month about scheduling your first appointment. Is now a good time to discuss scheduling your first appointment?

	 END_BODY
END_TEMPLATE

//-------------------------Generic SECOND SERVICE (10K NEW) Templates for Autonation-----------------//

START_TEMPLATE GENERIC_AN_SECONDSERVICE_NRTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_TEMP; serviceType=LEXUS_10K_NEW; brand=LEXUS; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} records with our advisors, we noticed you got your first service done ${lead.deal.descriptiveServiceDate5k}.

                    But I had a quick question about your next maintenance appointment. Is it OK for me to text you?

                    Prefiere Espanol?

                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
                <#break>
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, we noticed you got your last service done ${lead.deal.descriptiveLastServiceDate} (around ${lead.deal.descriptiveLastServiceDayMonth}).
                    But I had a quick question about your next maintenance appointment. Is it OK for me to text you?

                    Prefiere Espanol?

                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
                    <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
                <#break>
                <#case "Type NS">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} records with our advisors, I noticed you purchased your ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveDeliveryDate} (around ${lead.deal.descriptiveDeliveryDayMonth}).
                    I have a quick question regarding your next maintenance appointment. Is it OK for me to text you?

                    Prefiere Espanol?

                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
                    <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
                <#break>
            </#switch>
        <#else>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} records with our advisors, we noticed you got your first service done ${lead.deal.descriptiveServiceDate5k} (around ${lead.deal.descriptiveServiceDayMonth5k}). But I had a quick question about your next maintenance appointment. Is it OK for me to text you?

                    Prefiere Espanol?

                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
                <#break>
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, we noticed you got your last service done ${lead.deal.descriptiveLastServiceDate} (around ${lead.deal.descriptiveLastServiceDayMonth}).
                    But I had a quick question about your next maintenance appointment. Is it OK for me to text you?

                    Prefiere Espanol?

                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
                    <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
                <#break>
            </#switch>
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_10K_NRTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_TEMP; serviceType=TOYOTA_10K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} records with our advisors, we noticed you got your first service done ${lead.deal.descriptiveServiceDate5k}.

                    But I had a quick question about your 10K Service. Is it OK for me to text you?

                    Prefiere Espanol?

                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
                <#break>
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, we noticed you got your last service done ${lead.deal.descriptiveLastServiceDate} (around ${lead.deal.descriptiveLastServiceDayMonth}).
                    But I had a quick question about your 10K Service. Is it OK for me to text you?

                    Prefiere Espanol?

                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
                    <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
                <#break>
                <#case "Type NS">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} records with our advisors, I noticed you purchased your ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveDeliveryDate} (around ${lead.deal.descriptiveDeliveryDayMonth}).
                    I have a quick question regarding your 10K Service. Is it OK for me to text you?

                    Prefiere Espanol?

                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
                    <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
                <#break>
            </#switch>
        <#else>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} records with our advisors, we noticed you got your first service done ${lead.deal.descriptiveServiceDate5k} (around ${lead.deal.descriptiveServiceDayMonth5k}). But I had a quick question about your 10K Service. Is it OK for me to text you?

                    Prefiere Espanol?

                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
                <#break>
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, we noticed you got your last service done ${lead.deal.descriptiveLastServiceDate} (around ${lead.deal.descriptiveLastServiceDayMonth}).
                    But I had a quick question about your 10K Service. Is it OK for me to text you?

                    Prefiere Espanol?

                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
                    <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
                <#break>
            </#switch>
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_SECONDSERVICE_VCP_NRTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_TEMP; serviceType=CHEVY_10K_NEW,FORD_10K_NEW; brand=CHEVROLET,FORD; enterpriseId=76
	END_ATTR
	START_BODY

            <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
                <#switch "${lead.futureServiceInteraction.type}">
                    <#case "Type B2">
                        Hey ${lead.contact.firstName},
                        ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} records with our advisors, we noticed you got your first service done ${lead.deal.descriptiveServiceDate5k}.

                        But I had a quick question about your next maintenance appointment.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Is it OK for me to text you?

                        Prefiere Espanol?

                        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
                    <#break>
                    <#case "Type OS">
                        Hey ${lead.contact.firstName},
                        ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, we noticed you got your last service done ${lead.deal.descriptiveLastServiceDate} (around ${lead.deal.descriptiveLastServiceDayMonth}).
                        But I had a quick question about your next maintenance appointment.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Is it OK for me to text you?

                        Prefiere Espanol?

                        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
                        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
                    <#break>
                    <#case "Type NS">
                        Hey ${lead.contact.firstName},
                        ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} records with our advisors, I noticed you purchased your ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveDeliveryDate} (around ${lead.deal.descriptiveDeliveryDayMonth}).
                        I have a quick question regarding your next maintenance appointment.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Is it OK for me to text you?

                        Prefiere Espanol?

                        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
                        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
                    <#break>
                </#switch>
            <#else>
                <#switch "${lead.futureServiceInteraction.type}">
                    <#case "Type B2">
                        Hey ${lead.contact.firstName},
                        ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} records with our advisors, we noticed you got your first service done ${lead.deal.descriptiveServiceDate5k} (around ${lead.deal.descriptiveServiceDayMonth5k}). But I had a quick question about your next maintenance appointment.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Is it OK for me to text you?

                        Prefiere Espanol?

                        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
                    <#break>
                    <#case "Type OS">
                        Hey ${lead.contact.firstName},
                        ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, we noticed you got your last service done ${lead.deal.descriptiveLastServiceDate} (around ${lead.deal.descriptiveLastServiceDayMonth}).
                        But I had a quick question about your next maintenance appointment.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Is it OK for me to text you?

                        Prefiere Espanol?

                        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
                        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
                    <#break>
                </#switch>
            </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_NRTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_NRAA_TEMP; serviceType=CHEVY_10K_NEW,FORD_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

            Hey ${lead.contact.firstName},
            I'm just checking in to remind you of your ${lead.deal.serviceInteractionDescription}. I can contact you later if this is not the best time (or if it is too early). If you'd like to set up an appointment, all I need is a date and time that works for you, and I'll take care of the rest.

            Prefiere Espanol?

            ${lead.agent.agentFirstName}.
            <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_NRTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_NRAA_TEMP; serviceType=CHEVY_10K_NEW,FORD_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

            ${lead.contact.firstName},
            Not sure if you have already done the ${lead.deal.serviceInteractionDescription} or you don't need an appt at this time. Just In case if you have any questions or you need any assistance, please feel free to text me. Hope you have a great day, ${lead.contact.firstName}.

            Prefiere Espanol?

            ${lead.agent.agentFirstName}.
            <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

//we will use V1 version for Chevrolet/Ford
START_TEMPLATE GENERIC_AN_SECONDSERVICE_V1_RTA_1ST_TEMP
	START_SUBJECT
       Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=CHEVY_10K_NEW,FORD_10K_NEW; brand=CHEVROLET,FORD; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                Hey ${lead.contact.firstName},
                ${lead.agent.agentFirstName} here from ${lead.office.name}.
                I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, and we noticed you got your first service done in ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneThisYearOrOfLastYear} (around ${lead.deal.lastServiceDoneOrdinalDay}). Your second service ${lead.deal.nextServiceMayHaveBeenDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay} even if you have driven fewer miles. This service is recommended every 10k miles or 12 months, whichever comes first.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Would you like me to schedule this for you, ${lead.contact.firstName}?
                <#break>
                <#case "Type OS">
                Hey ${lead.contact.firstName},
                ${lead.agent.agentFirstName} here from ${lead.office.name}.
                I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, we noticed you got your last service done in ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneThisYearOrOfLastYear} (around ${lead.deal.lastServiceDoneOrdinalDay}). I wanted to let you know that your second service  ${lead.deal.nextServiceMayHaveBeenDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay} even if you have fewer than 10k miles. This service is recommended every 10k miles or 12 months, whichever comes first.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Do you want me to schedule this for you, ${lead.contact.firstName}?
                <#break>
                <#case "Type NS">
                Hey ${lead.contact.firstName},
                ${lead.agent.agentFirstName} here from ${lead.office.name}.
                I was reviewing your records and noticed you purchased your ${lead.product.year?c} ${lead.product.model?capitalize} in ${lead.deal.purchaseMonthInShortForm} ${lead.deal.purchaseYearThisYearOrLastYear} (around ${lead.deal.purchaseOrdinalDay}). I was looking at your service records, I wasn't able to find the first service. Also your second service ${lead.deal.nextServiceMayHaveBeenDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay} and I don't see that either on the Records.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Were you planning on getting the second service done anytime soon?
                <#break>
            </#switch>
        <#else>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                Hey ${lead.contact.firstName},
                ${lead.agent.agentFirstName} here from ${lead.office.name}.
                I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, and we noticed you were @${lead.deal.lastMileage} miles the last time you came in for the first service. This was in ${lead.deal.lastServiceDoneMonthInShortForm} (on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay}). If you have been driving a similar no. of miles, I think your ${lead.product.model?capitalize} might be due for the next service<#switch "${lead.deal.vcpApplicable}"><#case "YES">. I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO">.<#break></#switch> How many miles do you have right now?
                <#break>
                <#case "Type OS">
                Hey ${lead.contact.firstName},
                ${lead.agent.agentFirstName} here from ${lead.office.name}.
                I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, we noticed you were @${lead.deal.lastMileage} miles the last time you came in for the service. This was in ${lead.deal.lastServiceDoneMonthInShortForm} (on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay}). If you have been driving a similar no. of miles, I think your ${lead.product.model?capitalize} might be due for the next service<#switch "${lead.deal.vcpApplicable}"><#case "YES">. I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO">.<#break></#switch> How many miles do you have right now?
                <#break>
            </#switch>
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_RTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_NRAA_TEMP; serviceType=CHEVY_10K_NEW,FORD_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},
        I'm just checking in to remind you of your ${lead.deal.serviceInteractionDescription}. I can contact you later if this is not the best time (or if it is too early). If you'd like to set up an appointment, all I need is a date and time that works for you, and I'll take care of the rest.

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_RTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_2ND_NRAA_TEMP; serviceType=CHEVY_10K_NEW,FORD_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName},
        Not sure if you have already done the ${lead.deal.serviceInteractionDescription} or you don't need an appt at this time. Just In case if you have any questions or you need any assistance, please feel free to text me. Hope you have a great day, ${lead.contact.firstName}.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_LEXUS_10K_NRTA_2ND_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP; serviceType=LEXUS_10K_NEW; brand=LEXUS; track=SCHEDULE_FOLLOWUP_NO_RESPONSE; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Thanks, ${lead.contact.firstName}, I see that you already did your first service ${lead.deal.descriptiveServiceDate5k}. Your next service ${lead.deal.dueDateVerb10K} ${lead.deal.descriptiveDueDate10k} even if you have fewer miles than 10000. This won't cost you. Would you like to get this done (before the benefits expire)?

                    ${lead.agent.agentFirstName}
                <#break>
                <#case "Type OS">
                    Thanks, ${lead.contact.firstName}. I see that you did your last service ${lead.deal.descriptiveLastServiceDate}. I wanted to let you know your next service ${lead.deal.dueDateVerb10K} ${lead.deal.descriptiveDueDate10k} even if you have fewer miles than 10000. Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#break>
                <#case "Type NS">
                    When I looked at your Service Records, ${lead.contact.firstName}, I wasn't able to find your first service. Also your second service ${lead.deal.dueDateVerb10K} ${lead.deal.descriptiveDueDate10k} and I don't see that either on the Records. Were you planning on getting the second service done anytime soon?
                <#break>
            </#switch>
        <#else>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    I noticed you were @ ${lead.deal.last5KMileage} miles the last time you came in for the first service. This was ${lead.deal.descriptiveServiceDate5k} (${lead.deal.lastService5KMonthCount} months ago). If you have been driving a similar number of miles, I think your ${lead.product.model?capitalize} will soon be due for the next service (No cost, covered under LexusCare). What's your current mileage?
                <#break>
                <#case "Type OS">
                    I noticed you were @${lead.deal.lastMileage} miles the last time you came in at the Dealership. This was ${lead.deal.descriptiveLastServiceDate} (on ${lead.deal.descriptiveLastServiceMonth} ${lead.deal.descriptiveLastServiceDayMonth}). If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for second service. What's your current mileage?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#break>
            </#switch>
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_LEXUS_10K_RTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=LEXUS_10K_NEW; brand=LEXUS; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). We spoke ${lead.deal.contactedServiceMonth5k} about the first service for your ${lead.product.year?c} ${lead.product.model?capitalize}. I see you got your first service done on ${lead.deal.descriptiveServiceMonth5k} ${lead.deal.descriptiveServiceDayMonth5k}. I hope your vehicleDTO is running smoothly. BTW, Your second service ${lead.deal.dueDateVerb10K} ${lead.deal.descriptiveDueDate10k} even if you have fewer miles than 10000.

                    Would you like me to set this up for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#break>
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). We spoke ${lead.deal.contactedServiceMonth5k} about the first service for your ${lead.product.year?c} ${lead.product.model?capitalize}. I noticed you got your last service done at our dealership ${lead.deal.descriptiveLastServiceDate} (around ${lead.deal.descriptiveLastServiceDayMonth}). BTW, Your second service ${lead.deal.dueDateVerb10K} ${lead.deal.descriptiveDueDate10k} even if you have fewer miles than 10000.

                    Did you already get the 10K Service done, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#break>
                <#case "Type NS">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). We spoke briefly ${lead.deal.contactedServiceMonth5k} about your ${lead.product.year?c} ${lead.product.model?capitalize} (first service). Just wanted to let you know your second service ${lead.deal.dueDateVerb10K} ${lead.deal.descriptiveDueDate10k}.

                    Did you already get the 10K Service done, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#break>
            </#switch>
        <#else>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). We discussed the first service for your ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I noticed you were @ ${lead.deal.last5KMileage} miles the last time you came in for the first service (on ${lead.deal.descriptiveServiceMonth5k} ${lead.deal.descriptiveServiceDayMonth5k}). If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for second service.

                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#break>
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). We spoke ${lead.deal.contactedServiceMonth5k} about the first service for your ${lead.product.year?c} ${lead.product.model?capitalize}. I noticed you were @ ${lead.deal.lastMileage} miles the last time you came in for Service (on ${lead.deal.descriptiveLastServiceDayMonth} ${lead.deal.descriptiveLastServiceDate}). If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for second service.

                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#break>
            </#switch>
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_SECONDSERVICE_V1_NRTA_2ND_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP; serviceType=CHEVY_10K_NEW,FORD_10K_NEW; brand=CHEVROLET,FORD; track=SCHEDULE_FOLLOWUP_NO_RESPONSE; enterpriseId=76
	END_ATTR
	START_BODY

<#if lead.deal.predictionBasedOn = 'TIME_BASED'>
<#switch "${lead.futureServiceInteraction.type}">
<#case "Type B2"> Thanks, ${lead.contact.firstName}. I see that you already did your first service in ${lead.deal.lastServiceDoneMonthInShortForm}. Your second service ${lead.deal.nextServiceMayHaveBeenDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay} even if you have driven fewer miles. This service is recommended every 10k miles or 12 months, whichever comes first.  Would you like me to schedule this for you, ${lead.contact.firstName}? <#break>
<#case "Type OS"> Thanks, ${lead.contact.firstName}. I see that you did your last service in ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneThisYearOrOfLastYear}. I wanted to let you know that your second service  ${lead.deal.nextServiceMayHaveBeenDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay} even if you have fewer than 10k miles. This service is recommended every 10k miles or 12 months, whichever comes first.  Do you want me to schedule this for you, ${lead.contact.firstName}? ${lead.agent.agentFirstName} ${lead.agent.agentLastName} <#break>
<#case "Type NS"> Thanks, ${lead.contact.firstName}. I was looking at your service records, I wasn't able to find the first service. Also your second service ${lead.deal.nextServiceMayHaveBeenDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay} and I don't see that either on the Records.  Were you planning on getting the second service done anytime soon? <#break></#switch>
<#else>
<#switch "${lead.futureServiceInteraction.type}">
<#case "Type B2"> Thanks, ${lead.contact.firstName}. I noticed you were @${lead.deal.lastMileage} miles the last time you came in for the maintenance service. This was in ${lead.deal.lastServiceDoneMonthInShortForm} (on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay}). If you have been driving a similar no. of miles, I think your ${lead.product.model?capitalize} might be due for the next service.
How many miles do you have right now? <#break>
<#case "Type OS"> Thanks, ${lead.contact.firstName}. I noticed you were @${lead.deal.lastMileage} miles the last time you came in for the service. This was in ${lead.deal.lastServiceDoneMonthInShortForm} (on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay}). If you have been driving a similar no. of miles, I think your ${lead.product.model?capitalize} might be due for the next service.
How many miles do you have right now? <#break></#switch>
</#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_15K_NRTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_TEMP; serviceType=HONDA_15K_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        <#switch "${lead.futureServiceInteraction.type}">
        <#case "Type B2">
        Hey ${lead.contact.firstName},
        ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, we noticed you got your first service done in ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneThisYearOrOfLastYear} (around ${lead.deal.lastServiceDoneOrdinalDay}).
        I have a quick question about your second recommended service. Is it OK for me to text you?

        Prefiere Espanol?
        <#break>
        <#case "Type OS">
        Hey ${lead.contact.firstName},
        ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, we noticed you got your last service done in ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneThisYearOrOfLastYear} (around ${lead.deal.lastServiceDoneOrdinalDay}). I had a quick question about your second scheduled service. Is it OK for me to text you?

        Prefiere Espanol?
        <#break>
        <#case "Type NS">
        Hey ${lead.contact.firstName},
        ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). I noticed you got your ${lead.product.year?c} ${lead.product.model?capitalize} back in ${lead.deal.purchaseMonthInShortForm} ${lead.deal.purchaseYearThisYearOrLastYear} (around ${lead.deal.purchaseOrdinalDay}). I wanted to chat with you about your scheduled service. Is it OK for me to text you?

        Prefiere Espanol?
        <#break></#switch>

        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_15K_NRTA_2ND_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP; serviceType=HONDA_15K_NEW; brand=HONDA; track=SCHEDULE_FOLLOWUP_NO_RESPONSE; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
        <#switch "${lead.futureServiceInteraction.type}">
        <#case "Type B2"> Thanks, ${lead.contact.firstName}. I see that you already did your first service in ${lead.deal.lastServiceDoneMonthInShortForm}. Your second service which includes an engine oil and filter change, tire rotation, and multipoint inspections ${lead.deal.nextServiceWasDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay} even if you have driven fewer miles<#switch "${lead.product.year?c}"><#case "2023">. This is covered by Honda at no cost.<#break><#case "2024">. This is covered by Honda at no cost.<#break><#default>.<#break></#switch> This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?<#break>
        <#case "Type OS"> Thanks, ${lead.contact.firstName}. I see that you did your last service in ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneThisYearOrOfLastYear}. I wanted to let you know your second service ${lead.deal.nextServiceWasDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay} even if you have fewer than 15k miles<#switch "${lead.product.year?c}"><#case "2023">. This is covered by Honda at no cost.<#break><#case "2024">. This is covered by Honda at no cost.<#break><#default>.<#break></#switch> This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?<#break>
        <#case "Type NS"> Thanks, ${lead.contact.firstName}. It's been ${lead.deal.numberOfMonthsFromSoldDate} months since you got your ${lead.product.year?c} ${lead.product.model?capitalize}. I reached out to remind you about your scheduled service. This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?<#break> <#default><#break></#switch>
        <#else>
        <#switch "${lead.futureServiceInteraction.type}">
        <#case "Type B2"> Thanks, ${lead.contact.firstName}. I noticed you were @${lead.deal.lastMileage} miles the last time you came in for the first service. This was in ${lead.deal.lastServiceDoneMonthInShortForm} (${lead.deal.lastServiceMonthCount} months ago). If you have been driving a similar no. of miles, I think your ${lead.product.model?capitalize} might be due for the next service. This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?<#break>
        <#case "Type OS"> Thanks, ${lead.contact.firstName}. I noticed you were @${lead.deal.lastMileage} miles the last time you came in for the service. This was in ${lead.deal.lastServiceDoneMonthInShortForm} (${lead.deal.lastServiceMonthCount} months ago). If you have been driving a similar no. of miles, I think your ${lead.product.model?capitalize} might be due for the next service. This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?<#break><#default><#break></#switch>
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_15K_RTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=HONDA_15K_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
        <#switch "${lead.futureServiceInteraction.type}">
        <#case "Type B2">
        Hey ${lead.contact.firstName},
        ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, we noticed you got your last service done in ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneThisYearOrOfLastYear} (around ${lead.deal.lastServiceDoneOrdinalDay}). Your second service which includes an engine oil and filter change, tire rotation, and multipoint inspections ${lead.deal.nextServiceWasDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay} even if you have driven fewer miles. This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?
        <#break>
        <#case "Type OS">
        Hey ${lead.contact.firstName},
        ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, we noticed that you did your last service in ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneThisYearOrOfLastYear}. I wanted to let you know your second service ${lead.deal.nextServiceWasDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay} even if you have fewer than 15k miles. This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?
        <#break>
        <#case "Type NS">
        Hey ${lead.contact.firstName},
        ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). I noticed you got your ${lead.product.year?c} ${lead.product.model?capitalize} back ${lead.deal.descriptiveDeliveryDate} (around ${lead.deal.soldDateOfMonth}). I reached out to remind you about your scheduled service. This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?
        <#break>
        </#switch>
        <#else>
        <#switch "${lead.futureServiceInteraction.type}">
        <#case "Type B2">
        Hey ${lead.contact.firstName},
        ${lead.agent.agentFirstName} here from ${lead.office.name}. When I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, we noticed you were @${lead.deal.lastMileage} miles the last time you came in for the first service. This was in ${lead.deal.lastServiceDoneMonthInShortForm} (${lead.deal.lastServiceMonthCount} months ago). If you have been driving a similar no. of miles, I think your ${lead.product.model?capitalize} might be due for the next service. This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?
        <#break>
        <#case "Type OS">
        Hey ${lead.contact.firstName},
        ${lead.agent.agentFirstName} here from ${lead.office.name}. While I was reviewing your ${lead.product.year?c} ${lead.product.model?capitalize} service records with our advisors, we noticed you were @${lead.deal.lastMileage} miles the last time you came in for the service. This was in ${lead.deal.lastServiceDoneMonthInShortForm} (${lead.deal.lastServiceMonthCount} months ago). If you have been driving a similar no. of miles, I think your ${lead.product.model?capitalize} might be due for the next service. This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?
        <#break>
        </#switch>
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_10K_NRTA_2ND_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP; serviceType=TOYOTA_10K_NEW; brand=TOYOTA; track=SCHEDULE_FOLLOWUP_NO_RESPONSE; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Thanks, ${lead.contact.firstName}, I see that you already did your 5K Service ${lead.deal.descriptiveServiceDate5k}. Your 10K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate}. Toyota recommends this service at 10k miles or 12 months from purchase.
                    Would you like to get this done (before the benefits expire)?

                    ${lead.agent.agentFirstName}
                <#break>
                <#case "Type OS">
                    Thanks, ${lead.contact.firstName}. I see that you did your last service ${lead.deal.descriptiveLastServiceDate}. I wanted to let you know your 10K Service ${lead.deal.dueDateVerb10K} ${lead.deal.descriptiveDueDate10k} even if you have fewer miles than 10000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#break>
                <#case "Type NS">
                    When I looked at your Service Records, ${lead.contact.firstName}, I wasn't able to find your 5K Service. Also your 10K Service ${lead.deal.dueDateVerb10K} ${lead.deal.descriptiveDueDate10k} and I don't see that either on the Records.
                    Were you planning on getting the 10K done anytime soon?
                <#break>
            </#switch>
        <#else>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    I noticed you were @ ${lead.deal.last5KMileage} miles the last time you came in for the 5K service, that was ${lead.deal.descriptiveServiceDate5k}}, about ${lead.deal.lastService5KMonthCount} months ago. If you have been driving a similar number of miles, I think your ${lead.product.model?capitalize} will soon be due for the next service (i.e. 10K). Toyota recommends this service at 10,000 miles or 12 months.
                    What's your current mileage?
                <#break>
                <#case "Type OS">
                    I noticed you were @${lead.deal.lastMileage} miles the last time you came in at the Dealership. This was ${lead.deal.descriptiveLastServiceDate} (on ${lead.deal.descriptiveLastServiceMonth} ${lead.deal.descriptiveLastServiceDayMonth}). If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for 10k service.
                    What's your current mileage?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#break>
            </#switch>
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_10K_RTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=TOYOTA_10K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). We spoke ${lead.deal.contactedServiceMonth5k} about the 5K service for your ${lead.product.year?c} ${lead.product.model?capitalize}. I see you got your 5K done on ${lead.deal.descriptiveServiceMonth5k} ${lead.deal.descriptiveServiceDayMonth5k}. I hope your vehicleDTO is running smoothly. BTW, Your 10K Service ${lead.deal.dueDateVerb10K} ${lead.deal.descriptiveDueDate10k} even if you have fewer miles than 10000.

                    Would you like me to set this up for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#break>
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). We spoke ${lead.deal.contactedServiceMonth5k} about the 5K service for your ${lead.product.year?c} ${lead.product.model?capitalize}. I noticed you got your last service done at our dealership ${lead.deal.descriptiveLastServiceDate} (around ${lead.deal.descriptiveLastServiceDayMonth}). BTW, Your 10K Service ${lead.deal.dueDateVerb10K} ${lead.deal.descriptiveDueDate10k} even if you have fewer miles than 10000.

                    Did you already get the 10K Service done, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#break>
                <#case "Type NS">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). We spoke briefly ${lead.deal.contactedServiceMonth5k} about your ${lead.product.year?c} ${lead.product.model?capitalize} (5K Service). Just wanted to let you know your 10K Service ${lead.deal.dueDateVerb10K} ${lead.deal.descriptiveDueDate10k}.

                    Did you already get the 10K Service done, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#break>
            </#switch>
        <#else>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). We discussed the 5K service for your ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I noticed you were @ ${lead.deal.last5KMileage} miles the last time you came in for the 5K (on ${lead.deal.descriptiveServiceMonth5k} ${lead.deal.descriptiveServiceDayMonth5k}). If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for 10K service.

                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#break>
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). We spoke ${lead.deal.contactedServiceMonth5k} about the 5K service for your ${lead.product.year?c} ${lead.product.model?capitalize}. I noticed you were @ ${lead.deal.lastMileage} miles the last time you came in for Service (on ${lead.deal.descriptiveLastServiceDayMonth} ${lead.deal.descriptiveLastServiceDate}). If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for 10K service.

                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                <#break>
            </#switch>
        </#if>

	 END_BODY
END_TEMPLATE

//-----------------------------------Generic FIRST SERVICE Templates for Autonation-----------------//

START_TEMPLATE GENERIC_AN_5K_NEW_NRTA_1ST_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_TEMP; serviceType=TOYOTA_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW; brand=CHEVROLET,TOYOTA,LEXUS; enterpriseId=76
	END_ATTR
	START_BODY

            Hello ${lead.contact.firstName?lower_case?cap_first},

            ${lead.agent.agentFirstName} here from ${lead.office.name} service team. I was talking to the Sales team and it seems like they might have tentatively set your first appt when you purchased your ${lead.product.year?c} ${lead.product.model?capitalize} on ${lead.deal.purchaseMonthInShortForm} ${lead.deal.purchaseOrdinalDay}. This was ${lead.deal.numberOfMonthsSinceSoldDate} ago and I am guessing you might prefer a new date and time that's more convenient for you depending on your schedule right now.
            Is it ok if I text you to discuss this.

            Prefiere Espanol?

            ${lead.agent.agentFirstName}
            <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_FORD_5K_NEW_NRTA_1ST_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_TEMP; serviceType=FORD_5K_NEW; brand=FORD; enterpriseId=76
	END_ATTR
	START_BODY

        Hello ${lead.contact.firstName?lower_case?cap_first},

        ${lead.agent.agentFirstName} here from ${lead.office.name} service team. I was talking to the Sales team and it seems like they might have tentatively set your first appt when you purchased your ${lead.product.year?c} ${lead.product.model?capitalize} on ${lead.deal.purchaseMonthInShortForm} ${lead.deal.purchaseOrdinalDay}. This was ${lead.deal.numberOfMonthsSinceSoldDate} ago and I am guessing you might prefer a new date and time that's more convenient for you depending on your schedule right now.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch>
        Is it ok if I text you to discuss this.

        Prefiere Espanol?

        ${lead.agent.agentFirstName}
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_5K_NEW_NRTA_2ND_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP; serviceType=CHEVY_5K_NEW; brand=CHEVROLET; track=SCHEDULE_FOLLOWUP_NO_RESPONSE; enterpriseId=76
	END_ATTR
	START_BODY

        Thanks, ${lead.contact.firstName}. <#if lead.deal.numberOfMonthsSinceSoldDate??>It's been ${lead.deal.numberOfMonthsSinceSoldDate} since you got your ${lead.product.year?c} ${lead.product.model?capitalize}.</#if> I reached out to remind you about your 1st maintenance service that ${lead.deal.nextServiceWasDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay}. Even if you have driven fewer than 5k miles, this service is recommended every 6 months.

        Do you want me to schedule this for you, ${lead.contact.firstName}?

	 END_BODY
END_TEMPLATE

START_TEMPLATE FORD_5K_NEW_NRTA_2ND_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP; serviceType=FORD_5K_NEW; brand=FORD; track=SCHEDULE_FOLLOWUP_NO_RESPONSE; enterpriseId=76
	END_ATTR
	START_BODY

        Thanks, ${lead.contact.firstName}. <#if lead.deal.numberOfMonthsSinceSoldDate??>It's been ${lead.deal.numberOfMonthsSinceSoldDate} since you got your ${lead.product.year?c} ${lead.product.model?capitalize}.</#if> I reached out to remind you about your 1st maintenance service that ${lead.deal.nextServiceWasDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay}. Even if you have driven fewer than 5k miles, this service is recommended every 6 months.

        Do you want me to schedule this for you, ${lead.contact.firstName}?

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_5K_NEW_RTA_1ST_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=TOYOTA_5K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hi ${lead.contact.firstName?lower_case?cap_first},
        ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center).
        We spoke in ${lead.deal.descriptiveLastContactedMonth} about your ${lead.product.year?c} ${lead.product.model?capitalize}. <#if lead.deal.numberOfMonthsSinceSoldDate??>It's been ${lead.deal.numberOfMonthsSinceSoldDate} since you got your vehicleDTO.</#if> I reached out to remind you about your 1st 5K Service that ${lead.deal.nextServiceWasDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay}. (Even if you've less miles, this is recommended every 6 months. ToyotaCare will cover it).

        Do you want me to schedule this for you, ${lead.contact.firstName?lower_case?cap_first}?
        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_5K_NEW_NRTA_2ND_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP; serviceType=TOYOTA_5K_NEW; brand=TOYOTA; track=SCHEDULE_FOLLOWUP_NO_RESPONSE; enterpriseId=76
	END_ATTR
	START_BODY

        Thanks, ${lead.contact.firstName}. <#if lead.deal.numberOfMonthsSinceSoldDate??>It's been ${lead.deal.numberOfMonthsSinceSoldDate} since you got your ${lead.product.year?c} ${lead.product.model?capitalize}.</#if> I reached out to remind you about your 1st 5K Service that's due ${lead.deal.descriptiveNextServiceDate}. Even if you have fewer than 5000 miles, this service is recommended every 5 months at no cost.
        (ToyotaCare covers this).

        Do you want me to schedule this for you, ${lead.contact.firstName}?

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_LEXUS_5K_NEW_RTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=LEXUS_5K_NEW; brand=LEXUS; enterpriseId=76
	END_ATTR
	START_BODY

        Hi ${lead.contact.firstName},
        ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). We spoke in ${lead.deal.descriptiveLastContactedMonth} about your ${lead.product.year?c} ${lead.product.model?capitalize}. It's been ${lead.product.monthsBeforeVehiclePurchased} months since you got your vehicleDTO. I reached out to remind you about your 1st maintenance service that ${lead.deal.nextServiceWasDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay}. (Even if you've less miles, this is recommended every 6 months. Lexus Care will cover it).

        Do you want me to schedule this for you, ${lead.contact.firstName}?
        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}

    END_BODY
END_TEMPLATE

START_TEMPLATE AN_LEXUS_5K_NEW_NRTA_2ND_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP; serviceType=LEXUS_5K_NEW; brand=LEXUS; track=SCHEDULE_FOLLOWUP_NO_RESPONSE; enterpriseId=76
	END_ATTR
	START_BODY

        Thanks ${lead.contact.firstName}. <#if lead.deal.numberOfMonthsSinceSoldDate??>It's been ${lead.deal.numberOfMonthsSinceSoldDate} since you got your ${lead.product.year?c} ${lead.product.model?capitalize}.</#if> I reached out to remind you about your 1st maintenance service that's due ${lead.deal.descriptiveNextServiceDate}. Even if you've less miles, this is recommended every 6 months. No cost (LexusCare covers this).

        Do you want me to schedule this for you, ${lead.contact.firstName}?

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_5K_NEW_RTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=CHEVY_5K_NEW; brand=CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        Hi ${lead.contact.firstName},

        ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). We spoke in ${lead.deal.descriptiveLastContactedMonth} about your ${lead.product.year?c} ${lead.product.model?capitalize}. <#if lead.deal.numberOfMonthsSinceSoldDate??>It's been ${lead.deal.numberOfMonthsSinceSoldDate} since you got your vehicleDTO.</#if> I reached out to remind you about your 1st maintenance service that ${lead.deal.nextServiceWasDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay}. Even if you have driven fewer than 5k miles, this service is recommended every 6 months.

        Do you want me to schedule this for you, ${lead.contact.firstName}?
        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}

    END_BODY
END_TEMPLATE

START_TEMPLATE FORD_5K_NEW_RTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=FORD_5K_NEW; brand=FORD; enterpriseId=76
	END_ATTR
	START_BODY

        Hi ${lead.contact.firstName},

        ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Center). We spoke in ${lead.deal.descriptiveLastContactedMonth} about your ${lead.product.year?c} ${lead.product.model?capitalize}. <#if lead.deal.numberOfMonthsSinceSoldDate??>It's been ${lead.deal.numberOfMonthsSinceSoldDate} since you got your vehicleDTO.</#if> I reached out to remind you about your 1st maintenance service that ${lead.deal.nextServiceWasDueOrMightBeDue} on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay}. Even if you have driven fewer than 5k miles, this service is recommended every 6 months<#switch "${lead.deal.vcpApplicable}"><#case "YES">. I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO">.<#break></#switch>

        Do you want me to schedule this for you, ${lead.contact.firstName}?
        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}

    END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_7500_NEW_NRTA_1ST_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_TEMP; serviceType=HONDA_7500_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Hello ${lead.contact.firstName?lower_case?cap_first},

        ${lead.agent.agentFirstName} here from ${lead.office.name} service team. I was talking to the Sales team and it seems like they might have tentatively set your first appt when you purchased your ${lead.product.year?c} ${lead.product.model?capitalize} on ${lead.deal.purchaseMonthInShortForm} ${lead.deal.purchaseOrdinalDay}. This was ${lead.deal.numberOfMonthsSinceSoldDate} ago and I am guessing you might prefer a new date and time that's more convenient for you depending on your schedule right now.
        Is it ok if I text you to discuss this.

        Prefiere Espanol?

        ${lead.agent.agentFirstName}
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_7500_NEW_NRTA_2ND_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP; serviceType=HONDA_7500_NEW; brand=HONDA; track=SCHEDULE_FOLLOWUP_NO_RESPONSE; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type OS">
                    Thanks, ${lead.contact.firstName},
                    I see that you got your last service back in ${lead.deal.descriptiveDeliveryMonth}.
                    I wanted to inform you that your first recommended service might be due soon. It includes tire rotation, engine oil and filter change @ No Cost. It is covered under Honda Service Pass. This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?
                <#break>
                <#case "Type NS">
                    Thanks, ${lead.contact.firstName},
                    I was looking at your records and I noticed you purchased your ${lead.product.year?c} ${lead.product.model?capitalize} back ${lead.deal.descriptiveDeliveryDate}(around ${lead.deal.soldDateOfMonth}).
                    I wanted to inform you that your first recommended service might be due soon. It includes tire rotation, engine oil and filter change @ No Cost. It is covered under Honda Service Pass. This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?
                <#break>
            </#switch>
        <#else>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type OS">
                    Thanks, ${lead.contact.firstName},
                    I noticed you were @ ${lead.deal.lastMileage} miles the last time you came in for the service. This was back in ${lead.deal.descriptiveLastServiceMonth} (${lead.deal.lastServiceMonthCount} months ago). If you have been driving a similar number of miles, your ${lead.product.year?c} ${lead.product.model?capitalize} might be due for first scheduled maintenance.
                    It includes tire rotation, engine oil and filter change. This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?
                 <#break>
                <#case "Type NS">
                    Thanks, ${lead.contact.firstName},
                    I was looking at your records and I noticed you purchased your ${lead.product.year?c} ${lead.product.model?capitalize} back ${lead.deal.descriptiveDeliveryDate}(around ${lead.deal.soldDateOfMonth}).
                    I wanted to inform you that your first recommended service might be due soon. It includes tire rotation, engine oil and filter change @ No Cost. It is covered under Honda Service Pass. This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?
                <#break>
            </#switch>
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_7500_NEW_NRTA_1ST_NRAA_TEMP
    START_SUBJECT
        Hello
    END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_NRAA_TEMP; serviceType=HONDA_7500_NEW
	END_ATTR
    START_BODY

        Hi ${lead.contact.firstName},
        Not sure if you got my previous text message. Sometimes I have bad reception. I reached out to remind you about your first complimentary scheduled maintenance. It is typically due when your oil life is at 15% or below.  What's the oil life percentage reading on your indicator?

        Prefiere Espanol?

        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
        ${lead.office.name}
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>${lead.contact.firstName}

    END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_7500_NEW_NRTA_2ND_NRAA_TEMP
    START_SUBJECT
        Hello
    END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_NRAA_TEMP; serviceType=HONDA_7500_NEW
	END_ATTR
    START_BODY

        ${lead.contact.firstName},
        It seems like the oil life percentage on your ${lead.product.year?c} ${lead.product.model?capitalize} is not yet close to 15% or below. That's OK. In case you have questions about the Honda Service Pass (Complimentary Maintenance Plan) or need assistance scheduling an appointment, please don't hesitate to reach out to me via text. Hope you have a great day, ${lead.contact.firstName}!

        Prefiere Espanol?

        ${lead.agent.agentFirstName}.
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

    END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_7500_NEW_RTA_1ST_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=HONDA_7500_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} from ${lead.office.name} (Service Department).
                    We spoke briefly back in ${lead.deal.descriptiveLastContactedMonth}.
                    I was looking at your ${lead.product.year?c} ${lead.product.model?capitalize} service records and it seems like you got your last service done ${lead.deal.descriptiveServiceDayWithMonth}.
                    I wanted to inform you that your first recommended service might be due soon. It includes tire rotation, engine oil and filter change @ No Cost. It is covered under Honda Service Pass.
                    This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?
                <#break>
                <#case "Type NS">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} from ${lead.office.name} (Service Department).
                    We spoke briefly back in ${lead.deal.descriptiveLastContactedMonth}.
                    I was looking at your records and I noticed you got your ${lead.product.year?c} ${lead.product.model?capitalize} back ${lead.deal.descriptiveDeliveryDate}(around ${lead.deal.soldDateOfMonth}).
                    I wanted to inform you that your first recommended service might be due soon. It includes tire rotation, engine oil and filter change @ No Cost. It is covered under Honda Service Pass.
                    This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?
                <#break>
            </#switch>
        <#else>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} from ${lead.office.name} (Service Department).
                    <#if lead.deal.lastServiceType == "90d_honda">We discussed the 90-day check for your ${lead.product.year?c} ${lead.product.model?capitalize} back in ${lead.deal.descriptiveLastContactedMonth}.<#else>We spoke briefly back in ${lead.deal.descriptiveLastContactedMonth}.</#if>
                    I noticed you were at ${lead.deal.lastMileage} miles the last time you came in for the service ${lead.deal.descriptiveLastServiceDate}.
                    If you have been driving a similar number of miles, your ${lead.product.model?capitalize} might be due for the first scheduled maintenance. This is covered under Honda Service Pass at No Cost.
                    This service is typically due when your oil life is at 15% or below. What's the oil life percentage reading on your indicator?
                <#break>
            </#switch>
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_7500_NEW_RTA_1ST_NRAA_TEMP
    START_SUBJECT
        Hello
    END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_NRAA_TEMP; serviceType=HONDA_7500_NEW
	END_ATTR
    START_BODY

        Hi ${lead.contact.firstName},
        Not sure if you got my previous text message. Sometimes I have bad reception. I reached out to remind you about your first complimentary scheduled maintenance. It is typically due when your oil life is at 15% or below.  What's the oil life percentage reading on your indicator?

        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
        ${lead.office.name}

    END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_7500_NEW_RTA_2ND_NRAA_TEMP
    START_SUBJECT
        Hello
    END_SUBJECT
    START_ATTR
	    intent=AN_RTA_2ND_NRAA_TEMP; serviceType=HONDA_7500_NEW
	END_ATTR
    START_BODY

        ${lead.contact.firstName},
        It seems like the oil life percentage on your ${lead.product.year?c} ${lead.product.model?capitalize} is not yet close to 15% or below. That's OK. In case you have questions about the Honda Service Pass (Complimentary Maintenance Plan) or need assistance scheduling an appointment, please don't hesitate to reach out to me via text. Hope you have a great day, ${lead.contact.firstName}!

        ${lead.agent.agentFirstName}.

    END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_90D_NEW_NRTA_1ST_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_TEMP; serviceType=HONDA_90D_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Hi ${lead.contact.firstName},

        This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Department). I noticed you purchased your ${lead.product.year?c} ${lead.product.model?capitalize} from our dealership in ${lead.deal.descriptiveDeliveryMonth} (around ${lead.deal.descriptiveDeliveryDayMonth}). I wanted to check in to ensure you're comfortable with all the technology in your new ${lead.product.model?capitalize}. Sometimes, we find that there might be certain features that need further setup or explanation. If you have any questions or concerns, I'm here to help.
        BTW, is it OK to text you so I can remind you about your Honda complimentary service?

        Prefiere Espanol?

        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_90D_NEW_NRTA_2ND_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP; serviceType=HONDA_90D_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Thanks, ${lead.contact.firstName}!
        Your ${lead.product.year?c} ${lead.product.model?capitalize} comes with complimentary first year maintenance. I'll remind you when your first service is recommended. To ensure you don't miss out on these benefits could you please share your mileage and oil life percentage?

        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_90D_NEW_RTA_1ST_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=HONDA_90D_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Hi ${lead.contact.firstName},

        It's ${lead.agent.agentFirstName} from ${lead.office.name} (Service Department). I hope you've been enjoying your ${lead.product.year?c} ${lead.product.model?capitalize} since our last conversation. I wanted to check in to ensure you're comfortable with all the technology in your new ${lead.product.model?capitalize}. Sometimes, we find that there might be certain features that need further setup or explanation. If you have any questions or concerns about your new Honda, I'm here to help, answer questions, or set up an appointment if your Honda needs to be seen by an Honda Certified Technician. Do you have any concerns?

        ${lead.agent.agentFirstName}.

	 END_BODY
END_TEMPLATE

//-----------------------------------Toyota 15k/20k/25k Templates for Autonation-----------------//

START_TEMPLATE AN_TOYOTA_15K_NEW_NRTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_TEMP; serviceType=TOYOTA_15K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},
        ${lead.agent.agentFirstName} here from ${lead.office.name}.<#switch "${lead.futureServiceInteraction.type}"><#case "Type B2">  I was looking at your ${lead.product.year?c} ${lead.product.model?capitalize} service records and it seems like you got the 5K Service done ${lead.deal.descriptiveServiceDate5k} (around ${lead.deal.descriptiveServiceDayMonth5k}).<#break><#case "Type C2"> I was looking at your ${lead.product.year?c} ${lead.product.model?capitalize} service records and it seems like you got the 10K Service done ${lead.deal.descriptiveServiceDate10k} (around ${lead.deal.descriptiveServiceDayMonth10k}).<#break><#case "Type OS"> I was looking at your ${lead.product.year?c} ${lead.product.model?capitalize} service records and it seems like you got your last service done ${lead.deal.descriptiveLastServiceDate} (around ${lead.deal.descriptiveLastServiceDayMonth}).<#break><#case "Type NS"> I was looking at your records, I noticed you got your ${lead.product.year?c} ${lead.product.model?capitalize} back in ${lead.deal.purchaseMonthInShortForm} ${lead.deal.purchaseYearThisYearOrLastYear} (around ${lead.deal.descriptiveDeliveryDayMonth}).<#break></#switch>
        But I had a quick question about 15K service on your ${lead.product.year?c} ${lead.product.model?capitalize}. Is it OK for me to text you?

        Prefiere Espanol?

        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_15K_NEW_NRTA_2ND_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP; serviceType=TOYOTA_15K_NEW; brand=TOYOTA; track=SCHEDULE_FOLLOWUP_NO_RESPONSE; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
        <#switch "${lead.futureServiceInteraction.type}"><#case "Type B2">Thanks, ${lead.contact.firstName}. I see that you already did your 5K Service  ${lead.deal.descriptiveServiceDate5k}. I wanted to let you know your 15K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate15k} even if you have fewer miles than 15k. Do you want me to schedule this for you, ${lead.contact.firstName}?<#break><#case "Type C2"> Thanks, ${lead.contact.firstName}. I see that you already did your 10K Service  ${lead.deal.descriptiveServiceDate10k}. I wanted to let you know your 15K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate15k} even if you have fewer miles than 15k. Do you want me to schedule this for you, ${lead.contact.firstName}?<#break><#case "Type OS"> Thanks, ${lead.contact.firstName}. I see that you did your last service ${lead.deal.descriptiveLastServiceDate}. I wanted to let you know your 15K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate15k} even if you have fewer miles than 15k. Do you want me to schedule this for you, ${lead.contact.firstName}?<#break><#case "Type NS"> Thanks, ${lead.contact.firstName}. When I was reviewing your records with our service advisors. We noticed your 15K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate15k} even if you have fewer miles than 15k. Did you already get the 15K Service done, ${lead.contact.firstName}?<#break><#default><#break></#switch>
        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
        <#else>
        <#switch "${lead.futureServiceInteraction.type}"><#case "Type B2">I noticed you were @${lead.deal.last5KMileage} miles the last time you came in for the 5K. This was ${lead.deal.descriptiveServiceDate5k} (on ${lead.deal.descriptiveLastServiceMonth} ${lead.deal.descriptiveLastServiceDayMonth}). <#break><#case "Type OS">I noticed you were @${lead.deal.lastMileage} miles the last time you came in for the service. This was in ${lead.deal.lastServiceDoneMonthInShortForm} (${lead.deal.lastServiceMonthCount} months ago). <#break><#case "Type C2"> I noticed you were @${lead.deal.last10KMileage} miles the last time you came in for the 10K. This was ${lead.deal.descriptiveServiceDate10k} (on ${lead.deal.descriptiveLastServiceMonth} ${lead.deal.descriptiveLastServiceDayMonth}). <#break><#default><#break></#switch>If you have been driving a similar no. of miles, your ${lead.product.model?capitalize} might be due for 15K service. How many miles do you have right now?
        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_15K_NEW_RTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=TOYOTA_15K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again.  We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I was looking at your records for ${lead.product.year?c} ${lead.product.model?capitalize} and it seems like you got your 5K Service ${lead.deal.descriptiveServiceDate5k} (around ${lead.deal.descriptiveServiceDayMonth5k}). BTW, Your 15K Service ${lead.deal.dueDateVerb15K} ${lead.deal.descriptiveDueDate15k} even if you have fewer miles than 15000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type C2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again.  We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I was looking at your records for ${lead.product.year?c} ${lead.product.model?capitalize} and it seems like you got your 10K Service done ${lead.deal.descriptiveServiceDayWithMonth10k}. BTW, Your 15K Service ${lead.deal.dueDateVerb15K} ${lead.deal.descriptiveDueDate15k} even if you have fewer miles than 15000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again.  We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I was looking at your records for ${lead.product.year?c} ${lead.product.model?capitalize} and it seems like you got your last service done at our dealership back in ${lead.deal.descriptiveLastServiceDayMonth}.<#break><#case "Type NS"> I was looking at your records, I noticed you got your ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveDeliveryDate} (around ${lead.deal.descriptiveDeliveryDayMonth}). BTW, Your 15K Service ${lead.deal.dueDateVerb15K} ${lead.deal.descriptiveDueDate15k} even if you have fewer miles than 15000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type NS">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again.  We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I was looking at your records, I noticed you got your ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveDeliveryDate} (around ${lead.deal.descriptiveDeliveryDayMonth}). BTW, Your 15K Service ${lead.deal.dueDateVerb15K} ${lead.deal.descriptiveDueDate15k} even if you have fewer miles than 15000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
            </#switch>
        <#else>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I noticed you were @ ${lead.deal.last5KMileage} miles the last time you came in for the 5K Service. If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for 15K service.
                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type C2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}.I noticed you were @ ${lead.deal.last10KMileage} miles the last time you came in for the 10K Service. If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for 15K service.
                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}.I noticed you were @ ${lead.deal.last10KMileage} miles the last time you came in for the last service. If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for 15K service.
                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
            </#switch>
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_20K_NEW_NRTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_TEMP; serviceType=TOYOTA_20K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},
        ${lead.agent.agentFirstName} here from ${lead.office.name}.<#switch "${lead.futureServiceInteraction.type}"><#case "Type B2">  I was looking at your ${lead.product.year?c} ${lead.product.model?capitalize} service records and it seems like you got the 5K Service done ${lead.deal.descriptiveServiceDayWithMonth5k}.<#break><#case "Type C2"> I was looking at your ${lead.product.year?c} ${lead.product.model?capitalize} service records and it seems like you got the 10K Service done ${lead.deal.descriptiveServiceDayWithMonth10k}.<#break><#case "Type D2"> I was looking at your ${lead.product.year?c} ${lead.product.model?capitalize} service records and it seems like you got the 15K Service done ${lead.deal.descriptiveServiceDayWithMonth15k}.<#break> <#case "Type OS"> I was looking at your ${lead.product.year?c} ${lead.product.model?capitalize} service records and it seems like you got your last service done ${lead.deal.descriptiveServiceDayWithMonth}.<#break><#case "Type NS"> I was looking at your records, I noticed you got your ${lead.product.year?c} ${lead.product.model?capitalize} back in ${lead.deal.purchaseMonthInShortForm} ${lead.deal.purchaseYearThisYearOrLastYear} (around ${lead.deal.descriptiveDeliveryDayMonth}).<#break><#default><#break></#switch>
        But I had a quick question about your 20K service. Is it OK for me to text you?

        Prefiere Espanol?

        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_20K_NEW_NRTA_2ND_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP; serviceType=TOYOTA_20K_NEW; brand=TOYOTA; track=SCHEDULE_FOLLOWUP_NO_RESPONSE; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
        <#switch "${lead.futureServiceInteraction.type}">
        <#case "Type B2">Thanks, ${lead.contact.firstName}. I see that you already did your 5K Service back in ${lead.deal.descriptiveServiceMonth5k} ${lead.deal.descriptiveServiceDayWithMonth5k}. I wanted to let you know your 20K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate20k} even if you have fewer miles than 20k<#if lead.deal.isTwoYearPassed>.<#else> at No Cost.</#if> Do you want me to schedule this for you, ${lead.contact.firstName}?<#break>
        <#case "Type C2"> Thanks, ${lead.contact.firstName}. I see that you already did your 10K Service  back in ${lead.deal.descriptiveServiceMonth10k} ${lead.deal.descriptiveServiceDayWithMonth10k}. I wanted to let you know your 20K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate20k} even if you have fewer miles than 20k<#if lead.deal.isTwoYearPassed>.<#else> at No Cost.</#if> Do you want me to schedule this for you, ${lead.contact.firstName}?<#break>
        <#case "Type D2"> Thanks, ${lead.contact.firstName}. I see that you already did your 15K Service  back in ${lead.deal.descriptiveServiceMonth15k} ${lead.deal.descriptiveServiceDayWithMonth15k}. I wanted to let you know your 20K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate20k} even if you have fewer miles than 20k<#if lead.deal.isTwoYearPassed>.<#else> at No Cost.</#if> Do you want me to schedule this for you, ${lead.contact.firstName}?<#break>
        <#case "Type OS"> Thanks, ${lead.contact.firstName}. I see that you already did your last service back in ${lead.deal.descriptiveLastServiceMonth} ${lead.deal.descriptiveServiceDayWithMonth}. I wanted to let you know your 20K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate20k} even if you have fewer miles than 20k<#if lead.deal.isTwoYearPassed>.<#else> at No Cost.</#if> Do you want me to schedule this for you, ${lead.contact.firstName}?<#break>
        <#case "Type NS"> Thanks ${lead.contact.firstName}, When I was reviewing your records with our service advisors, we noticed your 20K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate20k} even if you have fewer miles than 20k. Did you already get the 20K Service done, ${lead.contact.firstName}?<#break><#default><#break></#switch>
        <#else>
        <#switch "${lead.futureServiceInteraction.type}"><#case "Type B2">I noticed you were @${lead.deal.last5KMileage} miles the last time you came in for the 5K service. This was back in ${lead.deal.descriptiveServiceMonth5k} (${lead.deal.lastService5KMonthCount} months ago).<#break><#case "Type OS">I noticed you were @${lead.deal.lastMileage} miles the last time you came in for the service. This was in ${lead.deal.lastServiceDoneMonthInShortForm} (${lead.deal.lastServiceMonthCount} months ago). <#break><#case "Type C2"> I noticed you were @${lead.deal.last10KMileage} miles the last time you came in for the 10K service. This was back in ${lead.deal.descriptiveServiceMonth10k} (${lead.deal.lastService10KMonthCount} months ago).<#break><#case "Type D2"> I noticed you were @${lead.deal.last15KMileage} miles the last time you came in for the 15K service. This was back in ${lead.deal.descriptiveServiceMonth15k} (${lead.deal.lastService15KMonthCount} months ago).<#break><#default><#break></#switch> If you have been driving a similar no. of miles, your ${lead.product.year?c} ${lead.product.model?capitalize} might be due for 20K service. How many miles do you have right now?
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_20K_NEW_RTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=TOYOTA_20K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I was looking at your records for ${lead.product.year?c} ${lead.product.model?capitalize} and it seems like you got your 5K Service ${lead.deal.descriptiveServiceDate5k} (around ${lead.deal.descriptiveServiceDayMonth5k}).
                    BTW, Your 20K Service ${lead.deal.dueDateVerb20K} ${lead.deal.descriptiveDueDate20k} even if you have fewer miles than 20000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type C2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I was looking at your records for ${lead.product.year?c} ${lead.product.model?capitalize} and it seems like you got your 10K Service ${lead.deal.descriptiveServiceDate10k} (around ${lead.deal.descriptiveServiceDayMonth10k}). BTW, Your 20K Service ${lead.deal.dueDateVerb20K} ${lead.deal.descriptiveDueDate20k} even if you have fewer miles than 20000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type D2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I was looking at your records for ${lead.product.year?c} ${lead.product.model?capitalize} and it seems like you got your 15K Service ${lead.deal.descriptiveServiceDate15k} (around ${lead.deal.descriptiveServiceDayMonth15k}). BTW, Your 20K Service ${lead.deal.dueDateVerb20K} ${lead.deal.descriptiveDueDate20k} even if you have fewer miles than 20000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I was looking at your records for ${lead.product.year?c} ${lead.product.model?capitalize} and it seems like you got your last service done at our dealership back in ${lead.deal.descriptiveLastServiceDayMonth}. BTW, Your 20K Service ${lead.deal.dueDateVerb20K} ${lead.deal.descriptiveDueDate20k} even if you have fewer miles than 20000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type NS">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed about the Service for your ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I was looking at your records, I noticed you got your ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveDeliveryDate} (around ${lead.deal.descriptiveDeliveryDayMonth}). BTW, Your 20K Service ${lead.deal.dueDateVerb20K} ${lead.deal.descriptiveDueDate20k} even if you have fewer miles than 20000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
            </#switch>
        <#else>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I noticed you were @ ${lead.deal.last5KMileage} miles the last time you came in for the 5K Service. If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for 20K service.
                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type C2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I noticed you were @ ${lead.deal.last10KMileage} miles the last time you came in for the 10K Service. If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for 20K service.
                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type D2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I noticed you were @ ${lead.deal.last15KMileage} miles the last time you came in for the 15K Service. If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for 20K service.
                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I noticed you were @ ${lead.deal.last15KMileage} miles the last time you came in for the last Service. If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for 20K service.
                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
            </#switch>
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_25K_NEW_NRTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_TEMP; serviceType=TOYOTA_25K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},
        ${lead.agent.agentFirstName} here from ${lead.office.name}.<#switch "${lead.futureServiceInteraction.type}"><#case "Type B2">  I was looking at your ${lead.product.year?c} ${lead.product.model?capitalize} service records and it seems like you got the 5K Service done ${lead.deal.descriptiveServiceDayWithMonth5k}.<#break><#case "Type B2-AS">  I was looking at your ${lead.product.year?c} ${lead.product.model?capitalize} service records and it seems like you got the 5K Service done ${lead.deal.descriptiveServiceDayWithMonth5k}.<#break><#case "Type C2"> I was looking at your ${lead.product.year?c} ${lead.product.model?capitalize} service records and it seems like you got the 10K Service done ${lead.deal.descriptiveServiceDayWithMonth10k}.<#break><#case "Type D2"> I was looking at your ${lead.product.year?c} ${lead.product.model?capitalize} service records and it seems like you got the 15K Service done ${lead.deal.descriptiveServiceDayWithMonth15k}.<#break><#case "Type E2"> I was looking at your ${lead.product.year?c} ${lead.product.model?capitalize} service records and it seems like you got the 20K Service done ${lead.deal.descriptiveServiceDayWithMonth20k}.<#break><#case "Type OS"> I was looking at your ${lead.product.year?c} ${lead.product.model?capitalize} service records and it seems like you got your last service done ${lead.deal.descriptiveServiceDayWithMonth}.<#break><#case "Type NS"> I was looking at your records, I noticed you got your ${lead.product.year?c} ${lead.product.model?capitalize} back in ${lead.deal.purchaseMonthInShortForm} ${lead.deal.purchaseYearThisYearOrLastYear} (around ${lead.deal.descriptiveDeliveryDayMonth}).<#break><#default><#break></#switch>
        But I had a quick question about your 25K Service. Is it OK for me to text you?

        Prefiere Espanol?

        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_25K_NEW_NRTA_2ND_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP; serviceType=TOYOTA_25K_NEW; brand=TOYOTA; track=SCHEDULE_FOLLOWUP_NO_RESPONSE; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
        <#switch "${lead.futureServiceInteraction.type}">
        <#case "Type B2"> Thanks, ${lead.contact.firstName}. I see that you already did your 5K Service back in ${lead.deal.descriptiveServiceMonth5k} ${lead.deal.descriptiveServiceDayWithMonth5k}. I wanted to let you know your 25K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate25k} even if you have fewer miles than 25k<#if lead.deal.isTwoYearPassed>.<#else> at No Cost.</#if> Do you want me to schedule this for you, ${lead.contact.firstName}?<#break>
        <#case "Type C2"> Thanks, ${lead.contact.firstName}. I see that you already did your 10K Service back in ${lead.deal.descriptiveServiceMonth10k} ${lead.deal.descriptiveServiceDayWithMonth10k}. I wanted to let you know your 25K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate25k} even if you have fewer miles than 25k<#if lead.deal.isTwoYearPassed>.<#else> at No Cost.</#if> Do you want me to schedule this for you, ${lead.contact.firstName}?<#break>
        <#case "Type D2"> Thanks, ${lead.contact.firstName}. I see that you already did your 15K Service back in ${lead.deal.descriptiveServiceMonth15k} ${lead.deal.descriptiveServiceDayWithMonth15k}. I wanted to let you know your 25K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate25k} even if you have fewer miles than 25k<#if lead.deal.isTwoYearPassed>.<#else> at No Cost.</#if> Do you want me to schedule this for you, ${lead.contact.firstName}?<#break>
        <#case "Type E2"> Thanks, ${lead.contact.firstName}. I see that you already did your 20K Service back in ${lead.deal.descriptiveServiceMonth20k} ${lead.deal.descriptiveServiceDayWithMonth20k}. I wanted to let you know your 25K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate25k} even if you have fewer miles than 25k<#if lead.deal.isTwoYearPassed>.<#else> at No Cost.</#if> Do you want me to schedule this for you, ${lead.contact.firstName}?<#break>
        <#case "Type OS"> Thanks, ${lead.contact.firstName}. I see that you did your last service back in ${lead.deal.descriptiveLastServiceMonth} ${lead.deal.descriptiveServiceDayWithMonth}. I wanted to let you know your 25K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate25k} even if you have fewer miles than 25k<#if lead.deal.isTwoYearPassed>.<#else> at No Cost.</#if> Do you want me to schedule this for you, ${lead.contact.firstName}?<#break>
        <#case "Type NS"> Thanks, ${lead.contact.firstName}, When I was reviewing your records with our service advisors, we noticed your 25K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate25k}<#if lead.deal.isTwoYearPassed>.<#else> at No Cost.</#if> Do you want me to schedule this for you, ${lead.contact.firstName}?<#break><#default><#break></#switch>
        <#else>
        <#switch "${lead.futureServiceInteraction.type}">
        <#case "Type B2">I noticed you were @${lead.deal.last5KMileage} miles the last time you came in for the 5K back in ${lead.deal.descriptiveServiceMonth5k} (${lead.deal.lastService5KMonthCount} months ago). <#break>
        <#case "Type C2">I noticed you were @${lead.deal.last10KMileage} miles the last time you came in for the 10K back in ${lead.deal.descriptiveServiceMonth10k} (${lead.deal.lastService10KMonthCount} months ago). <#break>
        <#case "Type D2">I noticed you were @${lead.deal.last15KMileage} miles the last time you came in for the 15K back in ${lead.deal.descriptiveServiceMonth15k} (${lead.deal.lastService15KMonthCount} months ago). <#break>
        <#case "Type E2">I noticed you were @${lead.deal.last20KMileage} miles the last time you came in for the 20K back in ${lead.deal.descriptiveServiceMonth20k} (${lead.deal.lastService20KMonthCount} months ago). <#break>
        <#case "Type OS">I noticed you were @${lead.deal.lastMileage} miles the last time you came in for the service back in ${lead.deal.descriptiveLastServiceMonth} (${lead.deal.lastServiceMonthCount} months ago). <#break>
        <#default><#break></#switch>
         If you have been driving a similar no. of miles, your ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.nextServiceWasDueOrMightBeDue} for the 25K service on ${lead.deal.nextServiceMonthInShortForm} ${lead.deal.nextServiceOrdinalDay}. Would you like me to schedule it for you, ${lead.contact.firstName}?
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_25K_NEW_RTA_1ST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=TOYOTA_25K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.predictionBasedOn = 'TIME_BASED'>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I was looking at your records for ${lead.product.year?c} ${lead.product.model?capitalize} and it seems like you got your 5K Service ${lead.deal.descriptiveServiceDayWithMonth5k}. BTW, Your 25K Service ${lead.deal.dueDateVerb25K} ${lead.deal.descriptiveDueDate25k} even if you have fewer miles than 25000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type C2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I was looking at your records for ${lead.product.year?c} ${lead.product.model?capitalize} and it seems like you got your 10K Service ${lead.deal.descriptiveServiceDayWithMonth10k}. BTW, Your 25K Service ${lead.deal.dueDateVerb25K} ${lead.deal.descriptiveDueDate25k} even if you have fewer miles than 25000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type D2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I was looking at your records for ${lead.product.year?c} ${lead.product.model?capitalize} and it seems like you got your 15K Service ${lead.deal.descriptiveServiceDayWithMonth15k}. BTW, Your 25K Service ${lead.deal.dueDateVerb25K} ${lead.deal.descriptiveDueDate25k} even if you have fewer miles than 25000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type E2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I was looking at your records for ${lead.product.year?c} ${lead.product.model?capitalize} and it seems like you got your 20K Service ${lead.deal.descriptiveServiceDayWithMonth20k}. BTW, Your 25K Service ${lead.deal.dueDateVerb25K} ${lead.deal.descriptiveDueDate25k} even if you have fewer miles than 25000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I was looking at your records for ${lead.product.year?c} ${lead.product.model?capitalize} and it seems like you got your last service done ${lead.deal.descriptiveServiceDayWithMonth}. BTW, Your 25K Service ${lead.deal.dueDateVerb25K} ${lead.deal.descriptiveDueDate25k} even if you have fewer miles than 25000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type NS">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I was looking at your records, I noticed you got your ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveDeliveryDate} (around ${lead.deal.descriptiveDeliveryDayMonth}). BTW, Your 25K Service ${lead.deal.dueDateVerb25K} ${lead.deal.descriptiveDueDate25k} even if you have fewer miles than 25000.
                    Do you want me to schedule this for you, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
            </#switch>
        <#else>
            <#switch "${lead.futureServiceInteraction.type}">
                <#case "Type B2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I noticed you were @ ${lead.deal.last5KMileage} miles the last time you came in for the 5K Service ${lead.deal.descriptiveServiceDayWithMonth5k}. If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for 25K service.

                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type C2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I noticed you were @ ${lead.deal.last10KMileage} miles the last time you came in for the 10K Service ${lead.deal.descriptiveServiceDayWithMonth10k}. If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for 25K service.

                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type D2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I noticed you were @ ${lead.deal.last15KMileage} miles the last time you came in for the 15K Service ${lead.deal.descriptiveServiceDayWithMonth15k}. If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for 25K service.

                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type E2">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I noticed you were @ ${lead.deal.last20KMileage} miles the last time you came in for the 20K Service ${lead.deal.descriptiveServiceDayWithMonth20k}. If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for 25K service.

                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
                <#case "Type OS">
                    Hey ${lead.contact.firstName},
                    It's ${lead.agent.agentFirstName} Again. We discussed <#switch "${lead.deal.lastServiceType?lower_case}"><#case "toyo_5k_new">the 5k service for your<#break><#case "toyo_10k_new">the 10k service for your<#break><#case "toyo_15k_new">the 15k service for your<#break><#case "toyo_20k_new">the 20k service for your<#break><#case "toyo_25k_new">the 25k service for your<#break><#default>the service for your<#break></#switch> ${lead.product.year?c} ${lead.product.model?capitalize} ${lead.deal.descriptiveLastContacted}. I noticed you were @ ${lead.deal.lastMileage} miles the last time you came in for the 5K Service ${lead.deal.descriptiveServiceDayWithMonth}. If you have been driving a similar number of miles, your ${lead.product.model?capitalize} will soon be due for 25K service.

                    What's your current mileage, ${lead.contact.firstName}?
                    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
                    ${lead.office.name}
                <#break>
            </#switch>
        </#if>

	 END_BODY
END_TEMPLATE

//---------------------------------------------Generic Intent Templates for Autonation----------------------------------------//

START_TEMPLATE GENERIC_AN_SVC_DURATION_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_SVC_DURATION_TEMP; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW,TOYOTA_ERROR_ALERT,FORD_ERROR_ALERT; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76; track=CHECK_SVC_DURATION_FU_TRACK
	END_ATTR
	START_BODY

        Our target is to complete the Express Service in about an hour from the time the vehicleDTO goes in the shop, please ask your advisor at check-in for more accurate timing.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_ASK_2INCLUDE_ANOTHER_SVC_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_CUST_ASK_2INCLUDE_ANOTHER_SVC; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        Thank you for the additional information. I am going to let the service advisor know about your additional service request. You will receive a call from them before your maintenance appt to confirm the services that will be added.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_ASK_4CHECK_ENGINE_LIGHT_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_CUST_ASK_4CHECK_ENGINE_LIGHT; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; track=CUSTOMER_A_HANDOFF; enterpriseId=76
	END_ATTR
	START_BODY

        Thank you for the additional information. I am going to let the service advisor know about your check engine light. You will receive a call from them before your maintenance appt to discuss the check engine light.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_ASK_4DISCOUNT_OR_SPECIALS_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_CUST_ASK_4DISCOUNT_OR_SPECIALS; serviceType=TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,TOYOTA_5K_USED,TOYOTA_5K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA; track=CUSTOMER_A_HANDOFF_V2; enterpriseId=76
	END_ATTR
	START_BODY

        <#switch "${lead.storeId}">
            <#case "3PA10969~2231">I will need to get a hold of your Service Advisor to inquire about any discounts or specials. I will have them call you to discuss.<#break>
        </#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_LEXUS_GET_SHUTTLE_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_GET_SHUTTLE; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,LEXUS_5K_USED,LEXUS_5K_NEW,LEXUS_10K_NEW; brand=LEXUS; track=CUSTOMER_A_HANDOFF; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, I can set the appointment in the scheduler and have someone from our team reach out to you before the appointment to schedule your shuttle vehicleDTO.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_LEXUS_GET_RENTAL_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_GET_RENTAL; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,LEXUS_5K_USED,LEXUS_5K_NEW,LEXUS_10K_NEW; brand=LEXUS; track=CUSTOMER_A_HANDOFF; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, I can set the appointment in the scheduler and have someone from our team reach out to you before the appointment to schedule your rental vehicleDTO.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_LEXUS_GET_LYFT_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_GET_LYFT; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,LEXUS_5K_USED,LEXUS_5K_NEW,LEXUS_10K_NEW; brand=LEXUS; track=CUSTOMER_A_HANDOFF; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, I can set the appointment in the scheduler and have someone from our team reach out to you before the appointment to schedule your lyft vehicleDTO.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_LEXUS_GET_LOANER_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_GET_LOANER; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,LEXUS_5K_USED,LEXUS_5K_NEW,LEXUS_10K_NEW; brand=LEXUS; enterpriseId=76; track=MAKE_NLP_CALL_4LOANER_TRACK
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, I can set the appointment and will have someone from our team reach out to confirm loaner availability before your appointment.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_SHUTTLE_NOT_AVAILABLE_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_SHUTTLE_NOT_AVAILABLE; serviceType=TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_NEW,CHEVY_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,FORD_10K_NEW,CHEVY_10K_NEW,HONDA_15K_NEW,TOYOTA_10K_NEW,FORD_5K_NEW,CHEVY_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, ${lead.office.name} doesn't offer a shuttle service at this time.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_PICKUP_NOT_AVAILABLE_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_PICKUP_NOT_AVAILABLE; serviceType=TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_NEW,CHEVY_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,FORD_10K_NEW,CHEVY_10K_NEW,HONDA_15K_NEW,TOYOTA_10K_NEW,FORD_5K_NEW,CHEVY_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, ${lead.office.name} doesn't offer a pick up and dropoff service at this time.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_RENTAL_NOT_AVAILABLE_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RENTAL_NOT_AVAILABLE; serviceType=TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_NEW,CHEVY_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,FORD_10K_NEW,CHEVY_10K_NEW,HONDA_15K_NEW,TOYOTA_10K_NEW,FORD_5K_NEW,CHEVY_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, ${lead.office.name} doesn't offer a rental service at this time.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_LOANER_NOT_AVAILABLE_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_LOANER_NOT_AVAILABLE; serviceType=TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_NEW,CHEVY_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,FORD_10K_NEW,CHEVY_10K_NEW,HONDA_15K_NEW,TOYOTA_10K_NEW,FORD_5K_NEW,CHEVY_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,FORD,HONDA,CHEVROLET; enterpriseId=76; track=MAKE_NLP_CALL_4LOANER_TRACK
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, ${lead.office.name} does not typically offer loaner vehicleDTOS for Express Service, I can set your appointment on the schedule and have our loaner coordinator call you before your appointment to confirm if there is a loaner available.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_LYFT_NOT_AVAILABLE_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_LYFT_NOT_AVAILABLE; serviceType=TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,CHEVY_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,FORD_10K_NEW,CHEVY_10K_NEW,HONDA_15K_NEW,TOYOTA_10K_NEW,FORD_5K_NEW,CHEVY_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, ${lead.office.name} doesn't offer lyft at this time.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_NOT_HAPPY_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_CUST_COMPLAINT; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; track=CUSTOMER_A_HANDOFF_V2; enterpriseId=76
	END_ATTR
	START_BODY

        I am genuinely sorry to learn that your experience at ${lead.office.name} was less than satisfactory. I'll make sure to bring this to the attention of our management and have a member of the team give you a call to discuss.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_SVC_DIFFERENT_LOC_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_SVC_DIFFERENT_LOC; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; track=LD_TASK_INSIGHT; enterpriseId=76
	END_ATTR
	START_BODY

        Thank you for letting us know, we were hoping to see you again but understand. We hope you will continue to use AutoNation for your future vehicleDTO sales and service need.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_ENQUIRES_4SALES_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_CUST_ENQUIRES_4SALES; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; track=CUSTOMER_A_HANDOFF_V2; enterpriseId=76
	END_ATTR
	START_BODY

        Great! Thank your for considering us for your sales needs. I will have one of my Sales Colleagues call you to discuss.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_ASK_4RECALL_SVC_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_CUST_ASK_4RECALL_SVC; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        Thank you for the additional information. I am going to let your Service Advisor know about your Recall. You will receive a call from them before your maintenance appt to confirm that the Recall will be added.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_ALREDAY_PERFORMED_RECALL_SVC_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_ALREDAY_PERFORMED_RECALL; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; track=CUSTOMER_A_HANDOFF; enterpriseId=76
	END_ATTR
	START_BODY

        I'm happy to hear your maintenance service has been completed. I will need to get a hold of one of my colleagues to assist me. I will have someone call you to discuss the recall appt.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_ASK_4DIAGNOSIS_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_CUST_ASK_4DIAGNOSIS; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; track=CUSTOMER_A_HANDOFF; enterpriseId=76
	END_ATTR
	START_BODY

        I understand, I will need to get a hold of one of my colleagues to assist me. Let me go ahead and have someone call you to discuss.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_ASK_4WALKIN_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_CUST_ASK_4WALKIN; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        Walk in appointments are accepted, we do recommend setting an appointment as the wait times for light maintenance may be lengthy and we cannot guarantee that your vehicleDTO could be seen or completed on the same day.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_LEXUS_CUST_ASK_4PICKUP_SVC_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_CUST_ASK_4PICKUP_SVC; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,LEXUS_5K_USED,LEXUS_10K_NEW,LEXUS_5K_NEW; brand=LEXUS; track=CUSTOMER_A_HANDOFF_V2; enterpriseId=76
	END_ATTR
	START_BODY

        In order to set a pick up and delivery appointment I am going to have a member of our customer experience team give you a call to ensure a great experience. I will go ahead and do that now

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_WHEN_MILEAGE_EXCEEDED_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
        intent=WHEN_MILEAGE_EXCEED; serviceType=LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
    END_ATTR
	START_BODY

        OK, ${lead.contact.firstName}. Based on your current mileage, I think you are already past due for your ${lead.deal.serviceInteractionDescription}. I recommend you get this done as soon as possible. Would you like me to set up an appt for you?

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_WHEN_MILEAGE_ARE_EXACT_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
        intent=WHEN_MILEAGE_IS_EQUAL_TO_DUEMILEAGE; serviceType=LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
    END_ATTR
	START_BODY

        OK, ${lead.contact.firstName}. Based on your current mileage, I think you are already due for your ${lead.deal.serviceInteractionDescription}. I recommend you get this done as soon as possible. Would you like me to set up an Appt for you?

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_UNDER_LIMIT_15K_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=OBJECTION_LOW_MILEAGE; serviceType=TOYOTA_15K_NEW; brand=TOYOTA; track=SCHEDULE_FOLLOW_UP_DD_M; enterpriseId=76
	END_ATTR
	START_BODY

        <#switch "${lead.deal.predictionBasedOn}">
            <#case "TIME_BASED">
                I understand that you have fewer miles on your ${lead.product.year?c} ${lead.product.model?capitalize}. However, the 15K service is recommended every 15K miles or 18 months, whichever comes first. Your 15K Service ${lead.deal.dueDateVerb15K} ${lead.deal.descriptiveDueDate15k} even if you have fewer miles than 15000. Would you like me to set this up for you, ${lead.contact.firstName}?
            <#break>
            <#case "MILEAGE_BASED">
                I understand that you have fewer miles on your ${lead.product.year?c} ${lead.product.model?capitalize}. However, the 15K service is recommended at 18 months or at 15K miles. This includes fluid adjustment, multi-point inspection, and tire rotation. Would you like me to schedule an appointment for you?
            <#break>
            <#default>
            <#break>
        </#switch>

    END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_UNDER_LIMIT_20K_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=OBJECTION_LOW_MILEAGE; serviceType=TOYOTA_20K_NEW; brand=TOYOTA; track=SCHEDULE_FOLLOW_UP_DD_M; enterpriseId=76
	END_ATTR
	START_BODY

        <#switch "${lead.deal.predictionBasedOn}">
            <#case "TIME_BASED">
                I understand that you have fewer miles on your ${lead.product.year?c} ${lead.product.model?capitalize}. However, the 20K service is recommended every 20K miles or 24 months, whichever comes first. Your 20K Service ${lead.deal.dueDateVerb20K} ${lead.deal.descriptiveDueDate20k} even if you have fewer miles than 20000. Would you like me to set this up for you, ${lead.contact.firstName}?
            <#break>
            <#case "MILEAGE_BASED">
                I understand that you have fewer miles on your ${lead.product.year?c} ${lead.product.model?capitalize}. However, the 20K service is recommended at 24 months or at 20K miles. This includes oil and filter change, multi-point inspection, and tire rotation. Would you like me to schedule an appointment for you?
            <#break>
            <#default>
            <#break>
        </#switch>

	 END_BODY
END_TEMPLATE

//We are going to use this template on Chevrolet/Ford
START_TEMPLATE GENERIC_AN_UNDER_LIMIT_10K_V1
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=OBJECTION_LOW_MILEAGE; serviceType=CHEVY_10K_NEW,FORD_10K_NEW; brand=FORD,CHEVROLET; track=SCHEDULE_FOLLOW_UP_DD_M; enterpriseId=76
	END_ATTR
	START_BODY

        <#switch "${lead.deal.predictionBasedOn}">
            <#case "TIME_BASED">
                    I understand that you have fewer miles on your ${lead.product.year?c} ${lead.product.model?capitalize}. However, the 10K service is recommended every 10K miles or 12 months, whichever comes first. Your 10K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate10k} even if you have fewer miles than 10k. Would you like me to set this up for you, ${lead.contact.firstName}?
            <#break>
            <#case "MILEAGE_BASED">
                    I understand that you have fewer miles on your ${lead.product.year?c} ${lead.product.model?capitalize}. However, the 10K service is recommended at 12 months or at 10K miles. This includes oil and filter change, and multi-point inspection. Would you like me to schedule an appointment for you?
            <#break>
        </#switch>

    END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_SVC_COST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_GENERIC_SVC_COST; serviceType=TOYOTA_5K_USED,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,TOYOTA_ERROR_ALERT,FORD_ERROR_ALERT,FORD_5K_USED,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_10K_NEW,FORD_5K_NEW,CHEVY_5K_USED,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,CHEVY_10K_NEW,LEXUS_5K_USED,LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,HONDA_15K_NEW,HONDA_5K_USED,GM_ALERT; brand=TOYOTA,FORD,HONDA,LEXUS,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY
        #priceMessage
    END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_SVC_COST_ASK_APT_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_GENERIC_SVC_COST_ASK_APT; serviceType=TOYOTA_5K_USED,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,TOYOTA_ERROR_ALERT,FORD_ERROR_ALERT,FORD_5K_USED,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_10K_NEW,FORD_5K_NEW,CHEVY_5K_USED,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,CHEVY_10K_NEW,LEXUS_5K_USED,LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,HONDA_15K_NEW,HONDA_5K_USED,GM_ALERT; brand=TOYOTA,FORD,HONDA,LEXUS,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY
        #priceMessage Would you like me to schedule an appt for you?
    END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_VCP_CUST_ASK_4COST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_VCP_CUST_ASK_4COST; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW,GM_ALERT; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_ASK_4TIRE_PRICING_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_CUST_ASK_4TIRE_PRICING; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        Thank you for your question. I am going to let your Service Advisor know and ask them to call you before your maintenance appointment to discuss your tire pricing.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_ASK_4WINDSHIELD_PRICING_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_CUST_ASK_4WINDSHIELD_PRICING; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        Thank you for your question. I am going to let your Service Advisor know and ask them to call you before your maintenance appointment to discuss your windshield pricing.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_ASK_4FLUID_PRICING_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_CUST_ASK_4FLUID_PRICING; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        Thank you for your question. I am going to let your Service Advisor know and ask them to call you before your maintenance appointment to discuss your fluid flush pricing.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_SVC_DETAILS_5K_10K_15K_20K_25K_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_SVC_DETAILS; serviceType=TOYOTA_5K_NEW,TOYOTA_15K_NEW,TOYOTA_25K_NEW,TOYOTA_10K_NEW,TOYOTA_20K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.isTwoYearPassed>
            <#switch "${lead.deal.plannedServiceType?lower_case}"><#case "toyo_5k_new">The 5k service includes fluid adjustment, tire rotation, and multi point inspection.<#break><#case "toyo_10k_new">The 10k service includes oil and filter change plus multi point inspection.<#break><#case "toyo_15k_new">The 15k service includes fluid adjustment, tire rotation, and multi point inspection.<#break><#case "toyo_20k_new">The 20k service includes oil and filter change plus multi point inspection.<#break><#case "toyo_25k_new">The 25k service includes fluid adjustment, tire rotation, and multi point inspection.<#break></#switch> Would you like me to set this up for you?
        <#else>
            <#switch "${lead.deal.plannedServiceType?lower_case}"><#case "toyo_5k_new">The 5k service is covered by Toyota Care so you can have it done at NO COST. It includes fluid adjustment, tire rotation, and multi point inspection.<#break><#case "toyo_10k_new">The 10k service is covered by Toyota Care so you can have it done at NO COST. It includes oil and filter change plus multi point inspection.<#break><#case "toyo_15k_new">The 15k service is covered by Toyota Care so you can have it done at NO COST. It includes fluid adjustment, tire rotation, and multi point inspection.<#break><#case "toyo_20k_new">The 20k service is covered by Toyota Care so you can have it done at NO COST. It includes oil and filter change plus multi point inspection.<#break><#case "toyo_25k_new">The 25k service is covered by Toyota Care so you can have it done at NO COST. It includes fluid adjustment, tire rotation, and multi point inspection.<#break></#switch> Would you like me to set this up for you?
        </#if>

	END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_SVC_DETAILS_N_LOCATION_5K_10K_15K_20K_25K_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_SVC_DETAILS_N_LOCATION; serviceType=TOYOTA_5K_NEW,TOYOTA_15K_NEW,TOYOTA_25K_NEW,TOYOTA_10K_NEW,TOYOTA_20K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.isTwoYearPassed>
            <#switch "${lead.deal.plannedServiceType?lower_case}"><#case "toyo_5k_new">The 5k service includes fluid adjustment, tire rotation, and multi point inspection.<#break><#case "toyo_10k_new">The 10k service includes oil and filter change plus multi point inspection.<#break><#case "toyo_15k_new">The 15k service includes fluid adjustment, tire rotation, and multi point inspection.<#break><#case "toyo_20k_new">The 20k service includes oil and filter change plus multi point inspection.<#break><#case "toyo_25k_new">The 25k service includes fluid adjustment, tire rotation, and multi point inspection.<#break></#switch> Would you like me to set this up for you at ${lead.office.name} located at ${lead.office.fullAddress}?
        <#else>
            <#switch "${lead.deal.plannedServiceType?lower_case}"><#case "toyo_5k_new">The 5k service is covered by Toyota Care so you can have it done at NO COST. It includes fluid adjustment, tire rotation, and multi point inspection.<#break><#case "toyo_10k_new">The 10k service is covered by Toyota Care so you can have it done at NO COST. It includes oil and filter change plus multi point inspection.<#break><#case "toyo_15k_new">The 15k service is covered by Toyota Care so you can have it done at NO COST. It includes fluid adjustment, tire rotation, and multi point inspection.<#break><#case "toyo_20k_new">The 20k service is covered by Toyota Care so you can have it done at NO COST. It includes oil and filter change plus multi point inspection.<#break><#case "toyo_25k_new">The 25k service is covered by Toyota Care so you can have it done at NO COST. It includes fluid adjustment, tire rotation, and multi point inspection.<#break></#switch> Would you like me to set this up for you at ${lead.office.name} located at ${lead.office.fullAddress}?
        </#if>

	END_BODY
END_TEMPLATE

START_TEMPLATE AN_LEXUS_SVC_DETAILS_5K_10K_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_SVC_DETAILS; serviceType=LEXUS_5K_NEW,LEXUS_10K_NEW; brand=LEXUS; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.deal.isTwoYearPassed>
            <#switch "${lead.deal.plannedServiceType?lower_case}"><#case "lx_5k_new">The first service includes fluid adjustment, tire rotation, and multi point inspection.<#break><#case "lx_10k_new">The second service includes, oil and filter change, <#if lead.storeId = '3PA0005633~2341'><#else>tire rotation </#if>and multi point inspection.<#break></#switch> Would you like me to set this up for you?
        <#else>
            <#switch "${lead.deal.plannedServiceType?lower_case}"><#case "lx_5k_new">The first service is covered by Lexus Care so you can have it done at NO COST. It includes fluid adjustment, tire rotation, and multi point inspection.<#break><#case "lx_10k_new">The second service is covered by Lexus Care so you can have it done at NO COST. It includes, oil and filter change, <#if lead.storeId = '3PA0005633~2341'><#else>tire rotation </#if>and multi point inspection.<#break></#switch> Would you like me to set this up for you?
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_GENERIC_SVC_DETAILS_4USED_N_NEXTSERVICE_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_SVC_DETAILS; serviceType=LEXUS_5K_USED,HONDA_5K_USED,TOYOTA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,FORD_10K_NEW,CHEVY_10K_NEW,FORD_5K_NEW; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        <#switch "${lead.deal.vcpApplicable}">
            <#case "YES">
                The service includes Oil and filter change, multipoint inspection and tire rotation. Would you like me to schedule an appointment for you?
            <#break>
            <#case "NO">
                The service includes Oil and filter change plus multipoint inspection. Would you like me to schedule an appointment for you?
            <#break>
        </#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_CHEVY_5K_NEW_SVC_DETAILS_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_SVC_DETAILS; serviceType=CHEVY_5K_NEW; brand=CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.storeId = '3PA10966~2060'>
            The service includes Oil change, multipoint inspection and tire rotation. Would you like me to schedule an appointment for you?
        <#else>
            The service includes Oil and filter change, multipoint inspection and tire rotation. Would you like me to schedule an appointment for you?
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_90D_7500_NEW_SVC_COST_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_HONDA_SVC_COST; serviceType=HONDA_90D_NEW,HONDA_7500_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, The first recommended service is covered under Honda Service Pass. It includes oil and filter change with tire rotation @ No Cost. Would you like me to schedule an appt for you?

	END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_90D_7500_NEW_SVC_DETAILS_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_SVC_DETAILS; serviceType=HONDA_90D_NEW,HONDA_7500_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        The first recommended service is complimentary (covered under Honda Service Pass). It includes an oil and filter change and tire rotation. What day would work best for you ${lead.contact.firstName}?

	END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_15K_NEW_SVC_DETAILS_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_SVC_DETAILS; serviceType=HONDA_15K_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        The service includes Oil and filter change, multipoint inspection and tire rotation. Would you like me to schedule an appointment for you?

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_ASK_ABOUT_VIN_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=ABOUT_VIN; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, It's about your ${lead.product.year?c} ${lead.product.model?capitalize} with VIN (${lead.product.vin?substring(13)}).

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_OBJECTION_LOW_MILEAGE_10K_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
        intent=OBJECTION_LOW_MILEAGE; serviceType=CHEVY_10K_NEW,LEXUS_10K_NEW,FORD_10K_NEW; brand=TOYOTA,LEXUS,FORD,CHEVROLET; track=SCHEDULE_FOLLOW_UP_DD_M; enterpriseId=76
    END_ATTR
	START_BODY

        <#switch "${lead.deal.predictionBasedOn}">
            <#case "TIME_BASED">
                    I understand that you have fewer miles on your ${lead.product.year?c} ${lead.product.model?capitalize}. However, the 10K service is recommended every 10K miles or 12 months, whichever comes first. Your 10K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate10k} even if you have fewer miles than 10k. Would you like me to set this up for you, ${lead.contact.firstName}?
            <#break>
            <#case "MILEAGE_BASED">
                    I understand that you have fewer miles on your ${lead.product.year?c} ${lead.product.model?capitalize}. However, the 10K service is recommended at 12 months or at 10K miles. <#if lead.storeId = '3PA0005633~2341'>This includes Oil and filter change plus multipoint inspection.<#else>This includes Oil and filter change, tire rotation, and multi point inspection.</#if> Would you like me to schedule an appointment for you?
            <#break>
        </#switch>

    END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_OBJECTION_LOW_MILEAGE_10K_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
        intent=OBJECTION_LOW_MILEAGE; serviceType=TOYOTA_10K_NEW; brand=TOYOTA; track=SCHEDULE_FOLLOW_UP_DD_M; enterpriseId=76
    END_ATTR
	START_BODY

        <#switch "${lead.deal.predictionBasedOn}">
            <#case "TIME_BASED">
                    I understand that you have fewer miles on your ${lead.product.year?c} ${lead.product.model?capitalize}. However, the 10K service is recommended every 10K miles or 12 months, whichever comes first. Your 10K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate10k} even if you have fewer miles than 10k. Would you like me to set this up for you, ${lead.contact.firstName}?
            <#break>
            <#case "MILEAGE_BASED">
                    I understand that you have fewer miles on your ${lead.product.year?c} ${lead.product.model?capitalize}. However, the 10K service is recommended at 12 months or at 10K miles. This includes your Toyota's First Oil and filter change, and multi point inspection. Would you like me to schedule an appointment for you?
            <#break>
        </#switch>

    END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_ASKS_IF5K_INCLUDE_OILCHNG_TEMP
	START_SUBJECT
	    Hello
	END_SUBJECT
START_ATTR
	    intent=CUST_ASKS_IF5K_INCLUDE_OILCHNG; serviceType=TOYOTA_5K_NEW,TOYOTA_25K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        The ToyotaCare includes oil change. If your vehicleDTO uses Synthetic oil, this is recommended at 10K and 20K. But the <#switch "${lead.deal.plannedServiceType?lower_case}"><#case "toyo_5k_new">5k<#break><#case "toyo_25k_new">25k<#break></#switch> Service also includes services such as tire rotation, fluid level adjustment, and brake inspection and won't cost you anything.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_REFER_PREVIOUSSVC_OFFER_NEXTSVC_TEMP
    START_SUBJECT
        Hello
    END_SUBJECT
    START_ATTR
	    intent=REFER_PREVIOUSSVC_OFFER_NEXTSVC; serviceType=TOYOTA_5K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
    START_BODY

        I see the <#switch "${lead.futureServiceInteraction.type}"><#case "Type B2">5k<#break><#case "Type C2">10k<#break><#case "Type D2">15k<#break><#case "Type E2">20k<#break><#case "Type F2">25k<#break><#case "Type OS">last<#break></#switch> service on your ${lead.product.year?c} ${lead.product.model?capitalize} was done ${lead.deal.descriptiveLastServiceDate} at ${lead.deal.lastMileage} miles. The next service will be due at <#switch "${lead.deal.plannedServiceType?lower_case}"><#case "toyo_5k_new">5K miles or 5 months <#break><#case "toyo_10k_new">10K miles or 12 months <#break><#case "toyo_15k_new">15K miles or 18 months <#break><#case "toyo_20k_new">20K miles or 24 months <#break><#case "toyo_25k_new">25K miles or 24 months <#break></#switch>whichever comes first. Would you like me to schedule this for you?

    END_BODY
END_TEMPLATE

START_TEMPLATE AN_FORD_CAR_WASH_NOT_AVAILABLE_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_CAR_WASH_NOT_AVAILABLE; serviceType=FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,FORD_5K_USED,FORD_10K_NEW,FORD_5K_NEW; brand=FORD; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.office.name} does not offer a car wash service at this time.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_GENERIC_CAR_WASH_AVAILABLE_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_CAR_WASH_AVAILABLE; serviceType=TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,TOYOTA_5K_USED,HONDA_5K_USED,CHEVY_5K_USED,CHEVY_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,HONDA_15K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.office.name} offers a complimentary car wash service.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_LEXUS_CAR_WASH_AVAILABLE_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_CAR_WASH_AVAILABLE; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,LEXUS_5K_USED,LEXUS_10K_NEW,LEXUS_5K_NEW; brand=LEXUS; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.office.name} offers a complimentary car wash Mon-Sat from 9am to 3pm. It includes an automatic wash, drying, vacuuming of the front seats, and tire shine.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_CUST_DOESNT_SPECIFY_MINDER_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=CUST_DOESNT_SPECIFY_MINDER; serviceType=HONDA_7500_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Honda recommends an oil and filter change when the oil life indicator reaches 15% or lower. Can you please share your current oil life percentage? So, I can remind you when it's time for your first service.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_CUST_DOESNT_SPECIFY_MINDER_15K_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=CUST_DOESNT_SPECIFY_MINDER; serviceType=HONDA_15K_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Honda recommends an oil and filter change when the oil life indicator reaches 15% or lower. Can you please share your current oil life percentage? So, I can remind you when it's time for your service.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_HONDA_CUST_WILL_CHECK_MINDER_LATER_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=CUST_WILL_CHECK_MINDER_LATER; serviceType=HONDA_15K_NEW,HONDA_7500_NEW,HONDA_90D_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Thank you for letting me know. When you get a chance, please check the oil life percentage and I will be happy to schedule an appointment for you if it's 15% or lower.

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_REFER_LAST_PREFER_NEXT_4NEXTSERVICE_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=REFER_LAST_PREFER_NEXT_4NEXTSERVICE; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        I see the last service on your ${lead.product.year?c} ${lead.product.model?capitalize} was done on ${lead.deal.lastServiceDoneMonthInShortForm} ${lead.deal.lastServiceDoneOrdinalDay} at ${lead.deal.lastMileage} miles<#switch "${lead.deal.oilChangedPerformedV2?lower_case}"><#case "yes"> including oil change.<#break><#case "no">.<#break></#switch> <#if lead.brand?seq_contains("TOYOTA")>We recommend service every 6 months or 5k miles for optimal engine performance.<#elseif lead.brand?seq_contains("LEXUS")>We recommend service every 6 months or 5k miles for optimal engine performance.<#elseif lead.brand?seq_contains("MAZDA")>We recommend service every 6 months or 5k miles for optimal engine performance.<#elseif lead.brand?seq_contains("KIA")>We recommend service every 6 months or 5k miles for optimal engine performance.<#elseif lead.brand?seq_contains("NISSAN")>We recommend service every 6 months or 5k miles for optimal engine performance.<#elseif lead.brand?seq_contains("HONDA")>We recommend service every 6 months or 7.5k miles for optimal engine performance.<#elseif lead.brand?seq_contains("ACURA")>We recommend service every 6 months or 5k miles for optimal engine performance.<#elseif lead.brand?seq_contains("DODGE_JEEP_RAM")>We recommend service every 6 months or 5k miles for optimal engine performance.<#elseif lead.brand?seq_contains("HYUNDAI")>We recommend service every 6 months or 5k miles for optimal engine performance.<#elseif lead.brand?seq_contains("SUBARU")>We recommend service every 6 months or 6k miles for optimal engine performance.<#elseif lead.brand?seq_contains("FORD")>We recommend service every 6 months or 5k miles for optimal engine performance.<#elseif lead.brand?seq_contains("CHEVROLET")>We recommend service every 6 months or 5k miles for optimal engine performance.<#elseif lead.brand?seq_contains("GMC")>We recommend service every 6 months or 5k miles for optimal engine performance.<#elseif lead.brand?seq_contains("BUICK")>We recommend service every 6 months or 5k miles for optimal engine performance.<#elseif lead.brand?seq_contains("INFINITI")>We recommend service every 6 months or 5k miles for optimal engine performance.<#elseif lead.brand?seq_contains("CADILLAC")>We recommend service every 6 months or 5k miles for optimal engine performance.</#if> Would you like me to schedule this for you, ${lead.contact.firstName}?

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_HONDA_PASS_PLAN_FOR_15K_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=HONDA_PASS_PLAN; serviceType=HONDA_15K_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.product.year == 2023>
            Honda Service Pass is a complimentary plan that covers factory scheduled maintenance. It includes oil changes, tire rotations and multi-point inspections for 2 years or 24,000 miles, whichever comes first.
        <#elseif lead.product.year == 2024>
            Honda Service Pass is a complimentary plan that covers factory scheduled maintenance. It includes oil changes, tire rotations and multi-point inspections for 2 years or 24,000 miles, whichever comes first.
        </#if>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_HONDA_PASS_PLAN_FOR_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=HONDA_PASS_PLAN; serviceType=HONDA_90D_NEW,HONDA_7500_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        <#if lead.product.year == 2023>
            Honda Service Pass is a complimentary plan that covers factory scheduled maintenance. It includes oil change and tire rotation for 2 years or 24,000 miles, whichever comes first.
        <#elseif lead.product.year == 2024>
            Honda Service Pass is a complimentary plan that covers factory scheduled maintenance. It includes oil change and tire rotation for 2 years or 24,000 miles, whichever comes first.
        <#elseif lead.product.year == 2025>
            Honda Service Pass is a complimentary plan that covers factory scheduled maintenance. It includes oil change and tire rotation for 1 year or 12,000 miles, whichever comes first.
        </#if>

	 END_BODY

END_TEMPLATE

START_TEMPLATE GENERIC_AN_PREFER_ALTERNATE_LOCATION_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=PREFER_ALTERNATE_LOCATION; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=LEXUS,TOYOTA,HONDA,CHEVROLET,FORD; track=CPAL_TASK_INSIGHT; enterpriseId=76
	END_ATTR
	START_BODY

        I understand you might prefer to get the service done at a nearby location that's more convenient. I work for ${lead.office.name} and I am unable to book appointments for other Dealerships. You will actually need to call them and talk to someone. If you are OK to book an appointment with ${lead.office.name}, I can do it right away over text message and send you a confirmation. Let me know whatever is more convenient.

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_APPOINTMENT_CONFIRMATION_HANDOFF_TEMP
	START_SUBJECT
        Appointment handoff for ${lead.contact.firstName} ${lead.contact.lastName} - Scheduled on ${lead.deal.descriptiveAppointmentDate} at ${lead.deal.descriptiveAppointmentTime}
	END_SUBJECT
	START_BODY

        Hi,

        The customer is scheduled for an appointment. Please find the details below:

        Customer Name: ${lead.contact.firstName} ${lead.contact.lastName}
        Phone: ${lead.contact.phoneNumber}
        Email: ${(lead.contact.email)!""}
        VIN: ${(lead.product.vin)!""}
        Appointment Date: ${lead.deal.descriptiveAppointmentDate}
        Appointment Time: ${lead.deal.descriptiveAppointmentTime}

        Regards,
        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
        ${lead.office.name}

	 END_BODY
     START_ATTACHMENT
        Transcript
     END_ATTACHMENT
END_TEMPLATE

START_TEMPLATE AUTONATION_HANDOFF_IF_FIWIP_IS_F_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=HANDOFF_IF_FIWIP_IS_F; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW,FORD_0K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        I will get a hold of one of my colleagues to complete the booking. Due to some technical issues, I am not able to schedule this from my end.

	END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_HANDOFF_SECOND_TIME_GENERIC
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=HANDOFF_SECOND_TIME_GENERIC; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW,FORD_0K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        Let me talk to one of my teammates and arrange for a manager to call you. I apologize for the inconvenience.

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_NEXT_SVC_MISSED_APPT_DUE2_CDK_ERROR_V2
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=NEXT_SVC_MISSED_APPT_DUE2_CDK_ERROR_V2; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, I apologize I missed this service when looking at your service history, I do see that you did have an oil change service completed. I will update my records and reach out to you when your next service is due.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_2ND_KEY_FOB_QUERY_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=2ND_KEY_FOB_QUERY; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,LEXUS_5K_NEW,TOYOTA_5K_NEW,LEXUS_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS; enterpriseId=76
	END_ATTR
	START_BODY

        Unfortunately, due to the chip shortage it can take up to few months for the second key fob to come in. You will be contacted when it is available.

	END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_HANDOFF1_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_HANDOFF1_TEMP; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW,FORD_0K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        Let me talk to one of my colleagues to get that answered for you. Let me go ahead and do that.

	END_BODY
END_TEMPLATE

START_TEMPLATE AN_FORD_0K_NRTA_1ST_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=NRTA_1ST_TEMP; serviceType=FORD_0K_NEW; brand=FORD; enterpriseId=76
	END_ATTR
	START_BODY

        Hi ${lead.contact.firstName?lower_case?cap_first},
        This is ${lead.agent.agentFirstName} from ${lead.office.name} (Customer Experience Team). I noticed that you recently took delivery of a ${lead.product.year?c} ${lead.product.model?capitalize} and wanted to Congratulate you!! Also, If there is anything we could have done better, pls let me know. BTW, is it OK to text you so I can remind you about your 1st scheduled maintenance?

        Prefiere Espanol?

        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	END_BODY
END_TEMPLATE

START_TEMPLATE AN_FORD_0K_NRTA_2ND_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=NRTA_2ND_TEMP; serviceType=FORD_0K_NEW; brand=FORD; enterpriseId=76
	END_ATTR
	START_BODY

        Thanks, ${lead.contact.firstName?lower_case?cap_first}. If you need any assistance regarding your ${lead.product.model?capitalize}, feel free to text me and I can help you set up an appointment (Just so you don't have to call and wait).

	END_BODY
END_TEMPLATE

START_TEMPLATE AN_GENERIC_TIRE_ROTATION_COST_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_TIRE_ROTATION_COST; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW,FORD_ERROR_ALERT; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        <#switch "${lead.storeId}">
            <#case "3PA25440~2945">The cost for a tire rotation is $49.99.<#break>
            <#case "3PA11166~2930">The cost for a tire rotation is $34.95.<#break>
            <#case "3PA0000104~2420">The cost for a tire rotation is $32.95.<#break>
            <#case "3PA10154~2539">The cost for a tire rotation is $80.00.<#break>
            <#case "3PA10966~2060">The cost for a tire rotation is $39.99.<#break>
            <#case "3PA11148~2140">The cost for a tire rotation is $24.95 .<#break>
            <#case "3PA10969~2231">The cost for a tire rotation is $34.95.<#break>
            <#case "3PA31462~2045">The cost for a tire rotation is $41.93.<#break>
            <#case "3PA20037~2130">The cost for a tire rotation is $69.99.<#break>
            <#case "3PA0005633~2341">The cost for a tire rotation is $49.99.<#break>
        </#switch>

	END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CUST_ASK_4APPT_EMAIL_CONFIRMATION_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=CUST_ASK_4APPT_EMAIL_CONFIRMATION; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        Yes you will receive an email from the dealership confirming this appointment.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_TENTATIVE_BOOKING_NOT_AVAILABLE_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=TENTATIVE_BOOKING_NOT_AVAILABLE; serviceType=FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        It looks like the Sales team may have tentatively set an appointment when you purchased your ${lead.product.year?c} ${lead.product.model?capitalize}, but I don't see a confirmed appt in our system. I reached out because your ${lead.deal.serviceInteractionDescription} ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveNextServiceDate} and I wanted to check if you would like to schedule it at a convenient time.

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_FIRSTSERVICE_NRTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_NRAA_TEMP; serviceType=FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        <#switch "${lead.deal.appointmentStatus}">
            <#case "BOOKED">
                Hi ${lead.contact.firstName},

                The sales dept scheduled a First Service Appt for your ${lead.product.year?c} ${lead.product.model?capitalize} on ${lead.deal.descriptiveAppointmentDate}, when you purchased your ${lead.product.year?c} ${lead.product.model?capitalize} in ${lead.deal.purchaseMonthInShortForm} (${lead.deal.numberOfMonthsSinceSoldDate} ago). You may not have been notified of this appt, so as a courtesy, I am reaching out to see if that date still works for you. If you would prefer a different day, just let me know a date and time and I will take care of the rest.

                Prefiere Espanol?

                ${lead.agent.agentFirstName}
                <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
            <#break>
            <#case "NOT_BOOKED">
                Hello ${lead.contact.firstName},

                Taking a closer look at your records with our advisors, we noticed that a first service appt was not set by the sales dept when you purchased your ${lead.product.year?c} ${lead.product.model?capitalize} back in ${lead.deal.purchaseMonthInShortForm} (${lead.deal.numberOfMonthsSinceSoldDate} ago). <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend this service at 6 months or 7,500 miles<#break><#case "3PA31462~2045">We recommend this service at 6 months or 7,500 miles<#break><#default>We recommend this service at <#switch "${lead.deal.plannedServiceType?lower_case}"><#case "toyo_5k_new">5 months<#break><#default>6 months<#break></#switch> or 5,000 miles<#break></#switch>. If you would like to schedule your first service appointment, all I need is a date and time that works for you and I will take care of the rest.

                Prefiere Espanol?

                ${lead.agent.agentFirstName}
                <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
            <#break>
        </#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_FIRSTSERVICE_NRTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_NRAA_TEMP; serviceType=FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

            Hello ${lead.contact.firstName},

            I am not sure if you received my previous text about your First Service Appointment because sometimes I have bad cell reception. I was reaching out to discuss your first service for your ${lead.product.year?c} ${lead.product.model?capitalize}, which ${lead.deal.nextServiceWasDueOrMightBeDue} around ${lead.deal.descriptiveNextServiceDate}. Is it ok if I text you to discuss this ${lead.contact.firstName}?

            Prefiere Espanol?

            ${lead.agent.agentFirstName}
            <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_FIRSTSERVICE_NRTA_3RD_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_3RD_NRAA_TEMP; serviceType=FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

            Hey ${lead.contact.firstName},

            It's ${lead.agent.agentFirstName} again. Not sure if you saw the last message I sent you a month ago (on ${lead.deal.lastContactedMonthOrdinalDate}). I may have contacted you too early for the first service appt on your ${lead.product.year?c} ${lead.product.model?capitalize}, I hope now is a better time. If it's easy to set your appt via text, I can help you (unless U prefer to call). Do you want me to schedule it for you?

            Prefiere Espanol?

            ${lead.agent.agentFirstName}
            <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_FIRSTSERVICE_RTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_NRAA_TEMP; serviceType=FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

	<#switch "${lead.deal.appointmentStatus}">
        <#case "BOOKED">
            Hi ${lead.contact.firstName},

            The sales dept scheduled a First Service Appt for your ${lead.product.year?c} ${lead.product.model?capitalize} on ${lead.deal.descriptiveAppointmentDate}, when you purchased your ${lead.product.year?c} ${lead.product.model?capitalize} in ${lead.deal.purchaseMonthInShortForm} (${lead.deal.numberOfMonthsSinceSoldDate} ago). You may not have been notified of this appt, so as a courtesy, I am reaching out to see if that date still works for you.If you would prefer a different day, just let me know a date and time and I will take care of the rest.

            ${lead.agent.agentFirstName}
        <#break>
        <#case "NOT_BOOKED">
            Hello ${lead.contact.firstName},

            Taking a closer look at your records with our advisors, we noticed that a first service appt was not set by the sales dept when you purchased your ${lead.product.year?c} ${lead.product.model?capitalize} back in ${lead.deal.purchaseMonthInShortForm} (${lead.deal.numberOfMonthsSinceSoldDate} ago). <#switch "${lead.storeId}"><#case "3PA0000104~2420">We recommend this service at 6 months or 7,500 miles<#break><#case "3PA31462~2045">We recommend this service at 6 months or 7,500 miles<#break><#default>We recommend this service at 6 months or 5,000 miles<#break></#switch>. If you would like to schedule your first service appointment, all I need is a date and time that works for you and I will take care of the rest.

            ${lead.agent.agentFirstName}
        <#break>
    </#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_FIRSTSERVICE_RTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_2ND_NRAA_TEMP; serviceType=FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Hello ${lead.contact.firstName},

        I am not sure if you received my previous text about your First Service Appointment because sometimes I have bad cell reception. I was reaching out to discuss your first service for your ${lead.product.year?c} ${lead.product.model?capitalize}, which ${lead.deal.nextServiceWasDueOrMightBeDue} around ${lead.deal.descriptiveNextServiceDate}. Is it ok if I text you to discuss this ${lead.contact.firstName}?

        ${lead.agent.agentFirstName}

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_FIRSTSERVICE_RTA_3RD_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_3RD_NRAA_TEMP; serviceType=FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},

        It's ${lead.agent.agentFirstName} again. Not sure if you saw the last message I sent you a month ago (on ${lead.deal.lastContactedMonthOrdinalDate}). I may have contacted you too early for the first service appt on your ${lead.product.year?c} ${lead.product.model?capitalize}, I hope now is a better time. If it's easy to set your appt via text, I can help you (unless U prefer to call). Do you want me to schedule it for you?

        ${lead.agent.agentFirstName}

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_ASK_MAINTENACE_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
        intent=AN_ASK_MAINTENACE_SCHEDULE; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; track=CUSTOMER_A_HANDOFF_V2; enterpriseId=76
    END_ATTR
	START_BODY

      Your specific maintenance schedule should be in your owner's manual. I'll also check with a colleague who can help with any specific questions.

	 END_BODY
END_TEMPLATE

START_TEMPLATE TOYOTA_CARE_PLAN_DOCUMENTATION
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
        intent=TOYOTA_CARE_PLAN_DOCUMENTATION; serviceType=TOYOTA_5K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA; enterpriseId=76
    END_ATTR
	START_BODY

        The Toyota Care service comes with the vehicleDTO purchase, is connected to the vehicleDTO serial number. There is no additional documentation needed.

	END_BODY
END_TEMPLATE

START_TEMPLATE TENTATIVE_APPT_NOT_VISIBLE
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
        intent=TENTATIVE_APPT_NOT_VISIBLE; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; track=CUSTOMER_A_HANDOFF; enterpriseId=76
    END_ATTR
	START_BODY

         It looks like the Sales team may have tentatively set an appointment when you purchased your ${lead.product.year?c} ${lead.product.model?capitalize}, but I don't see a confirmed appt in our system. I reached out because your recommended service might be due soon and I wanted to check if you would like to schedule it at a convenient time.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_GENERIC_DISCOUNT_PRICE_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_DISCOUNT_PRICE_TEMP; serviceType=LEXUS_NEXTSERVICE1,LEXUS_5K_USED,TOYOTA_5K_USED,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_15K_NEW,HONDA_5K_USED,HONDA_NEXTSERVICE1,FORD_5K_NEW,FORD_10K_NEW,FORD_5K_USED,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_10K_NEW,CHEVY_5K_USED,CHEVY_NEXTSERVICE1; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76; track=GENERIC_DISCOUNT_PRICE_TRACK
	END_ATTR
	START_BODY

        <#switch "${lead.storeId}">
            <#case "3PA25440~2945">We're actually running an oil change special right now for $89.99. You can see this and other offers on our website. [https://www.lexusofpalmbeach.com/servicespecials/] If you would like to set an appointment all I need is a date and time and I set it up for you, its that easy.<#break>
            <#case "3PA11166~2930">We're actually running an oil change special right now for $69.95. You can see this and other offers on our website. [https://www.autonationtoyotaweston.com/specials/service.htm] If you would like to set an appointment all I need is a date and time and I set it up for you, its that easy.<#break>
            <#case "3PA0000104~2420">We're actually running an oil change special right now for $74.95. You can see this and other offers on our website. [https://www.autonationhondaclearwater.com/specials/service.htm] If you would like to set an appointment all I need is a date and time and I set it up for you, its that easy.<#break>
            <#case "3PA10154~2539">We're actually running an oil change special right now for $74.95. You can see this and other offers on our website. [https://www.autonationfordbradenton.com/specials/service.htm] If you would like to set an appointment all I need is a date and time and I set it up for you, its that easy.<#break>
            <#case "3PA10966~2060">We're actually running an oil change special right now for $69.95. You can see this and other offers on our website. [https://www.autonationchevroletclearwater.com/Service-And-Parts-Specials] If you would like to set an appointment all I need is a date and time and I set it up for you, its that easy.<#break>
            <#case "3PA11148~2140">We're actually running a 10% discount on a full synthetic oil change. You can see this and other offers on our website. [https://www.autonationchevroletgreenacres.com/Service-And-Parts-Specials] If you would like to set an appointment all I need is a date and time and I set it up for you, its that easy.<#break>
            <#case "3PA31462~2045">Yes, we do have a special $79.99 for full synthetic oil change. Would you like me to schedule it for you?<#break>
            <#case "3PA20037~2130">Yes, we're offering a special 10% off on a full synthetic oil change. Would you like me to schedule it for you?<#break>
            <#case "3PA0005633~2341">Yes, we do have a special $89.95 for full synthetic oil change. Would you like me to schedule it for you?<#break>
        </#switch>

	END_BODY
END_TEMPLATE

START_TEMPLATE AN_CUST_SHOWS_CONCERN_AFTER_DISCOUNT_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=CUST_SHOWS_CONCERN_AFTER_DISCOUNT; serviceType=LEXUS_NEXTSERVICE1,LEXUS_5K_USED,TOYOTA_5K_USED,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_15K_NEW,HONDA_5K_USED,HONDA_NEXTSERVICE1,FORD_5K_NEW,FORD_10K_NEW,FORD_5K_USED,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_10K_NEW,CHEVY_5K_USED,CHEVY_NEXTSERVICE1; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; track=CUSTOMER_A_HANDOFF_V2; enterpriseId=76
	END_ATTR
	START_BODY

        I will review your concern with the manager and have someone follow up as soon as possible.

	END_BODY
END_TEMPLATE

START_TEMPLATE HONDA_PASS_PLAN_DOCUMENTATION_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
        intent=HONDA_PASS_PLAN_DOCUMENTATION; serviceType=HONDA_7500_NEW; brand=HONDA; enterpriseId=76
    END_ATTR
	START_BODY

        The Honda Service Pass comes with the vehicleDTO purchase, is connected to the vehicleDTO serial number. There is no additional documentation needed.

	END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_TOYOTACARE_FUTURE_EXPIRY_DATE_25K
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=TOYOTACARE_FUTURE_EXPIRY_DATE; serviceType=TOYOTA_25K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, ToyotaCare provides five scheduled maintenance services during the initial 2 year period from the date of purchase. I noticed you bought your ${lead.product.year?c} ${lead.product.model?capitalize} on ${lead.deal.purchaseMonthInShortForm} ${lead.deal.purchaseOrdinalDay}, ${lead.deal.purchaseDateYear}. Your complimentary ToyotaCare benefits will expire on ${lead.deal.careExpireMonthInShortForm} ${lead.deal.careExpireOrdinalDay}, ${lead.deal.careExpireYear}, So if you book your Appt before that, you won't lose benefits for the 25K Service!

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_WHAT_OIL_IS_USED_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=WHAT_OIL_IS_USED; serviceType=TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,TOYOTA_5K_USED,TOYOTA_10K_NEW,TOYOTA_5K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW,LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,LEXUS_5K_USED,LEXUS_5K_NEW,LEXUS_10K_NEW,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,HONDA_5K_USED,HONDA_15K_NEW,HONDA_7500_NEW,HONDA_90D_NEW; brand=HONDA,TOYOTA,LEXUS; enterpriseId=76
	END_ATTR
	START_BODY

        Your vehicleDTO uses synthetic oil which means you can schedule oil changes at extended intervals.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_CONFIRMATION_CODE_VIA_EMAIL_OR_TEXT_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=CONFIRMATION_CODE_VIA_EMAIL_OR_TEXT; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        You're all set. No code or reservation number is needed. We have your appointment on file, so just check in with your name when you arrive.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_SERVICE_BEFORE_OILCHANGE_IFOIL_SYNTHETIC_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_SERVICE_BEFORE_OILCHANGE_IFOIL_SYNTHETIC; serviceType=TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,TOYOTA_5K_USED,TOYOTA_5K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        The service recommended on your ${lead.product.year?c} ${lead.product.model?capitalize} is fluid adjustment, tire rotation, and complete multipoint inspection. Rotating the tires between oil changes will extend the life of your tires as well as ensure your tires are performing up to specifications.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_CHEVY_5K_NEW_SVC_COST_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_SVC_COST; serviceType=CHEVY_5K_NEW; brand=CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        The first service is covered by ${lead.office.name} so you can have it done at NO COST. It includes an oil and filter change, tire rotation, and multi-point inspection.

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_NRTA_4TH_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_4TH_NRAA_TEMP; serviceType=FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW,LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

            ${lead.contact.firstName},
            I don't mean to be a bother. I am sure you might have already done the maintenance on your ${lead.product.year?c} ${lead.product.model?capitalize}. No worries. If you can confirm the same, I will update your records. If you have any questions or need any help in the future, just save my number. U already have my first name. My last name is ${lead.agent.agentLastName}.

            Prefiere Espanol?

            ${lead.agent.agentFirstName}
            <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_AN_RTA_4TH_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_4TH_NRAA_TEMP; serviceType=FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW,LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2; brand=CHEVROLET,FORD,LEXUS,TOYOTA,HONDA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName},
        I don't mean to be a bother. I am sure you might have already done the maintenance on your ${lead.product.year?c} ${lead.product.model?capitalize}. No worries. If you can confirm the same, I will update your records. If you have any questions or need any help in the future, just save my number. U already have my first name. My last name is ${lead.agent.agentLastName}.

        ${lead.agent.agentFirstName}

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_SECONDSERVICE_NRTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_NRAA_TEMP; serviceType=TOYOTA_10K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName}, I'm just checking in to remind you of your 2nd service which Toyota recommends to be done at 10k miles or 12 months from purchase whichever comes first. If you'd like to set up an appt, all I need is a date and time that works for you, and I'll take care of the rest.

        Prefiere Espanol?

        ${lead.agent.agentFirstName}.
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_SECONDSERVICE_NRTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_NRAA_TEMP; serviceType=TOYOTA_10K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},
        I hope you receive my text this time. It's ${lead.agent.agentFirstName}, I am reaching out to you for the 2nd service on your ${lead.product.year?c} ${lead.product.model?capitalize}. The 10k mile service includes oil and filter change at no cost to you, it is provided by Toyota. Text may be easier & faster for booking an appt, if you would like to schedule using text I can help you.

        Prefiere Espanol?

        ${lead.agent.agentFirstName}
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_SECONDSERVICE_NRTA_3RD_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_3RD_NRAA_TEMP; serviceType=TOYOTA_10K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},

        It's ${lead.agent.agentFirstName} again. Not sure if you saw the last message I sent you a month ago (on ${lead.deal.lastContactedMonthOrdinalDate}). I may have contacted you too early for the second service appt on your ${lead.product.year?c} ${lead.product.model?capitalize}, I hope now is a better time. If it's easy to set your appt via text, I can help you (unless U prefer to call). Do you want me to schedule it for you?

        Prefiere Espanol?

        ${lead.agent.agentFirstName}
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_SECONDSERVICE_RTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_NRAA_TEMP; serviceType=TOYOTA_10K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName}, I'm just checking in to remind you of your 2nd service which Toyota recommends to be done at 10k miles or 12 months from purchase whichever comes first. If you'd like to set up an appt, all I need is a date and time that works for you, and I'll take care of the rest.

        ${lead.agent.agentFirstName}.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_SECONDSERVICE_RTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_2ND_NRAA_TEMP; serviceType=TOYOTA_10K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},
        I hope you receive my text this time. It's ${lead.agent.agentFirstName}, I am reaching out to you for the 2nd service on your ${lead.product.year?c} ${lead.product.model?capitalize}. The 10k mile service includes oil and filter change at no cost to you, it is provided by Toyota. Text may be easier & faster for booking an appt, if you would like to schedule using text I can help you.

        ${lead.agent.agentFirstName}

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_SECONDSERVICE_RTA_3RD_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_3RD_NRAA_TEMP; serviceType=TOYOTA_10K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},

        It's ${lead.agent.agentFirstName} again. Not sure if you saw the last message I sent you a month ago (on ${lead.deal.lastContactedMonthOrdinalDate}). I may have contacted you too early for the second service appt on your ${lead.product.year?c} ${lead.product.model?capitalize}, I hope now is a better time. If it's easy to set your appt via text, I can help you (unless U prefer to call). Do you want me to schedule it for you?

        ${lead.agent.agentFirstName}

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_15K_NRTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_NRAA_TEMP; serviceType=TOYOTA_15K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},

        I'm just checking in to remind you of your 15k service which includes tire rotation, fluid adjustments, multi-point inspection. This service is provided by Toyota Care at no cost to you. If you'd like to set up an appointment, all I need is a date and time that works for you, and I'll take care of the rest.

        Prefiere Espanol?

        ${lead.agent.agentFirstName}.
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_15K_NRTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_NRAA_TEMP; serviceType=TOYOTA_15K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName},
        Not sure if you have already done the 15k service on your ${lead.product.year?c} ${lead.product.model?capitalize} or you don't need an appt at this time. If you have any questions or you need any assistance in setting a maintenance appt, please feel free to text me. Have a great day.

        Prefiere Espanol?

        ${lead.agent.agentFirstName}.
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_15K_NRTA_3RD_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_3RD_NRAA_TEMP; serviceType=TOYOTA_15K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, It's ${lead.agent.agentFirstName} again. Not sure if you saw the last message I sent you a month ago (on ${lead.deal.lastContactedMonthOrdinalDate}). I may have contacted you too early for the 15k maintenance on your ${lead.product.year?c} ${lead.product.model?capitalize}, I hope now is a better time. If it's easy to set your appt via text, I can help you (unless U prefer to call). Do you want me to schedule it for you?

        Prefiere Espanol?

        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_15K_RTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_NRAA_TEMP; serviceType=TOYOTA_15K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},

        I'm just checking in to remind you of your 15k service which includes tire rotation, fluid adjustments, multi-point inspection. This service is provided by Toyota Care at no cost to you. If you'd like to set up an appointment, all I need is a date and time that works for you, and I'll take care of the rest.

        ${lead.agent.agentFirstName}.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_15K_RTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_2ND_NRAA_TEMP; serviceType=TOYOTA_15K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName},
        Not sure if you have already done the 15k service on your ${lead.product.year?c} ${lead.product.model?capitalize} or you don't need an appt at this time. If you have any questions or you need any assistance in setting a maintenance appt, please feel free to text me. Have a great day.

        ${lead.agent.agentFirstName}.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_15K_RTA_3RD_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_3RD_NRAA_TEMP; serviceType=TOYOTA_15K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, It's ${lead.agent.agentFirstName} again. Not sure if you saw the last message I sent you a month ago (on ${lead.deal.lastContactedMonthOrdinalDate}). I may have contacted you too early for the 15k maintenance on your ${lead.product.year?c} ${lead.product.model?capitalize}, I hope now is a better time. If it's easy to set your appt via text, I can help you (unless U prefer to call). Do you want me to schedule it for you?

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_20K_NRTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_NRAA_TEMP; serviceType=TOYOTA_20K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},

        I'm just checking in to remind you of your 20k service, which includes your ${lead.product.model?capitalize}'s next service. Toyota recommends the service at 20k miles. If you'd like to set up an appointment, all I need is a date and time that works for you, and I'll take care of the rest.

        Prefiere Espanol?

        ${lead.agent.agentFirstName}.
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_20K_NRTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_NRAA_TEMP; serviceType=TOYOTA_20K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName},

        Not sure if you have already done the 20k service on your ${lead.product.model?capitalize} or you don't need an appt at this time. The 20k mile service is provided by Toyota at no cost. If you would like to set an appt I can help. Hope you have a great day, ${lead.contact.firstName}.

        Prefiere Espanol?

        ${lead.agent.agentFirstName}.
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_20K_NRTA_3RD_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_3RD_NRAA_TEMP; serviceType=TOYOTA_20K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName},

        It's ${lead.agent.agentFirstName} again. Not sure if you saw the last message I sent you a month ago (on ${lead.deal.lastContactedMonthOrdinalDate}). I may have contacted you too early for the 20k maintenance on your ${lead.product.year?c} ${lead.product.model?capitalize}, I hope now is a better time. If it's easy to set your appt via text, I can help you (unless U prefer to call). Do you want me to schedule it for you?

        Prefiere Espanol?

        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_20K_RTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_NRAA_TEMP; serviceType=TOYOTA_20K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},

        I'm just checking in to remind you of your 20k service, which includes your ${lead.product.model?capitalize}'s next service. Toyota recommends the service at 20k miles. If you'd like to set up an appointment, all I need is a date and time that works for you, and I'll take care of the rest.

        ${lead.agent.agentFirstName}.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_20K_RTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_2ND_NRAA_TEMP; serviceType=TOYOTA_20K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName},

        Not sure if you have already done the 20k service on your ${lead.product.model?capitalize} or you don't need an appt at this time. The 20k mile service is provided by Toyota at no cost. If you would like to set an appt I can help. Hope you have a great day, ${lead.contact.firstName}.

        ${lead.agent.agentFirstName}.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_20K_RTA_3RD_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_3RD_NRAA_TEMP; serviceType=TOYOTA_20K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName},

        It's ${lead.agent.agentFirstName} again. Not sure if you saw the last message I sent you a month ago (on ${lead.deal.lastContactedMonthOrdinalDate}). I may have contacted you too early for the 20k maintenance on your ${lead.product.year?c} ${lead.product.model?capitalize}, I hope now is a better time. If it's easy to set your appt via text, I can help you (unless U prefer to call). Do you want me to schedule it for you?

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_25K_NRTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_NRAA_TEMP; serviceType=TOYOTA_25K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},

        I'm just checking in to remind you of your 25k service which includes tire rotation, fluid adjustments, multi-point inspection. This service is provided by Toyota Care at no cost to you. If you'd like to set up an appointment, all I need is a date and time that works for you, and I'll take care of the rest.

        Prefiere Espanol?

        ${lead.agent.agentFirstName}.
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_25K_NRTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_NRAA_TEMP; serviceType=TOYOTA_25K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName},
        Not sure if you have already done the 25k service on your ${lead.product.year?c} ${lead.product.model?capitalize} or you don't need an appt at this time. If you have any questions or you need any assistance in setting a maintenance appt, please feel free to text me. Have a great day.

        Prefiere Espanol?

        ${lead.agent.agentFirstName}.
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_25K_NRTA_3RD_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_3RD_NRAA_TEMP; serviceType=TOYOTA_25K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, It's ${lead.agent.agentFirstName} again. Not sure if you saw the last message I sent you a month ago (on ${lead.deal.lastContactedMonthOrdinalDate}). I may have contacted you too early for the 25k maintenance on your ${lead.product.year?c} ${lead.product.model?capitalize}, I hope now is a better time. If it's easy to set your appt via text, I can help you (unless U prefer to call). Do you want me to schedule it for you?

        Prefiere Espanol?

        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_25K_RTA_1ST_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_NRAA_TEMP; serviceType=TOYOTA_25K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Hey ${lead.contact.firstName},

        I'm just checking in to remind you of your 25k service which includes tire rotation, fluid adjustments, multi-point inspection. This service is provided by Toyota Care at no cost to you. If you'd like to set up an appointment, all I need is a date and time that works for you, and I'll take care of the rest.

        ${lead.agent.agentFirstName}.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_25K_RTA_2ND_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_2ND_NRAA_TEMP; serviceType=TOYOTA_25K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName},
        Not sure if you have already done the 25k service on your ${lead.product.year?c} ${lead.product.model?capitalize} or you don't need an appt at this time. If you have any questions or you need any assistance in setting a maintenance appt, please feel free to text me. Have a great day.

        ${lead.agent.agentFirstName}.

	 END_BODY
END_TEMPLATE

START_TEMPLATE AN_TOYOTA_25K_RTA_3RD_NRAA_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=AN_RTA_3RD_NRAA_TEMP; serviceType=TOYOTA_25K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, It's ${lead.agent.agentFirstName} again. Not sure if you saw the last message I sent you a month ago (on ${lead.deal.lastContactedMonthOrdinalDate}). I may have contacted you too early for the 25k maintenance on your ${lead.product.year?c} ${lead.product.model?capitalize}, I hope now is a better time. If it's easy to set your appt via text, I can help you (unless U prefer to call). Do you want me to schedule it for you?

	 END_BODY
END_TEMPLATE

START_TEMPLATE FORD_ERROR_ALERT_NRTA_1ST_TEMP
    START_SUBJECT
         Hello
    END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_TEMP; serviceType=FORD_ERROR_ALERT; brand=FORD; enterpriseId=76
	END_ATTR

    START_BODY
<#switch "${lead.warning}">
  <#case "Time to Plan your Next Oil Change">
  Hello ${lead.contact.firstName},

  This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Dept). I just received a notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. I was reading the notes and it seems like your vehicleDTO is due for an engine oil service soon.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch>

  Is it OK for me to text you to discuss this further?

  Prefiere Espanol?

  ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
  <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
  <#break>
  <#case "Oil Change Required">
  Hi ${lead.contact.firstName},

  ${lead.agent.agentFirstName} here from the Service Dept @ ${lead.office.name}. I just got another notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. This is different from the last time. It seems like your engine oil-life is fully used, and it needs to be changed IMMEDIATELY.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch>

  Are you OK with me texting you so we can go over this?

  Prefiere Espanol?

  ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
  <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
  <#break>
  <#case "Urgent - Oil Change Past Due">
  Hey ${lead.contact.firstName},

  ${lead.agent.agentFirstName} again from ${lead.office.name} (Service Team). You are not going to believe this. Ford Reached out to us for the third time about your ${lead.product.year?c} ${lead.product.model?capitalize}. Perhaps you see the light on your dashboard? In their notes, they have stated your vehicleDTO is OVERDUE for an oil change.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch>

  Would it be fine for us to discuss this via text?

  Prefiere Espanol?

  ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
  <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
  <#break>
  <#case "Change Engine Oil Soon">
  ${lead.contact.firstName},

  ${lead.agent.agentFirstName} ${lead.agent.agentLastName} here from ${lead.office.name}. I didn't mean to bother you. This time, we got a message from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. To be specific, they said you have 5% or LESS OIL-LIFE REMAINING.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch>

  Can we chat real quick via SMS Text?

  ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
  <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
  <#break>
  <#case "Time to plan your next recommended service">
    Hello ${lead.contact.firstName},

    This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Dept). I just received a notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. I was reading the notes and based on your mileage, it's time to perform your next recommended service soon, you may have seen the light on your dashboard.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch>

    Is it OK for me to text you to discuss this further?

    Prefiere Espanol?

    ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
    <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
  <#break>
  <#case "Perform recommended service soon">
     Hi ${lead.contact.firstName},

     ${lead.agent.agentFirstName} here from Service Dept @ ${lead.office.name}. I just got another notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. This is different from the last time. It seems your upcoming recommended service will be due soon based on your current mileage.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch>

     Are you OK with me texting you so we can go over this?

     Prefiere Espanol?

     ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
     <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
  <#break>
  <#case "Service Engine Soon">
       Hi ${lead.contact.firstName},

       ${lead.agent.agentFirstName} here from Service Dept @ ${lead.office.name}. I just got a notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. I was reading the notes and it seems like your vehicleDTO's engine will require servicing soon.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch>

       Are you OK with me texting you so we can go over this?

       Prefiere Espanol?

       ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
       <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
  <#break>
  <#case "Possible Tire Leak Detected">
       Hi ${lead.contact.firstName},

       ${lead.agent.agentFirstName} here from Service Dept @ ${lead.office.name}. I just got a notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. I was reading the notes and it seems like a possible tire leak has been detected, and should be diagnosed.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch>

       Are you OK with me texting you so we can go over this?

       Prefiere Espanol?

       ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
       <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
  <#break>
  <#case "Recommended service required">
       Hi ${lead.contact.firstName}, it's ${lead.agent.agentFirstName} here from Service Dept @ ${lead.office.name}. I received a notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize} that's due for recommended service maintenance.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch> Is it okay for me to text you to discuss this further?

       ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
       <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
  <#break>
  <#case "Vehicle Maintenance Is Due Soon">
       Hi ${lead.contact.firstName},
       ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Dept). I just received a notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. I was reading the notes and it seems like your vehicleDTO is due for maintenance soon.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch>
       Is it Okay for me to text you to discuss this further?

       Prefiere Espanol?

       ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
       <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
  <#break>
  <#case "Oil Change and Regular Maintenance Needed">
       Hello ${lead.contact.firstName},
       ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Dept). I just received a notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. I was reading the notes and it seems like your vehicleDTO needs Oil Change and Regular Maintenance.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch>
       Is it OK for me to text you to discuss this further?

       Prefiere Espanol?

       ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
       <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
  <#break>
  <#case "Reminder: Vehicle Maintenance Is Due">
       Hi ${lead.contact.firstName},
       ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Dept). I just received a notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. I was reading the notes and it seems like your vehicleDTO is due for maintenance.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch>
       Is it Okay for me to text you to discuss this further?

       Prefiere Espanol?

       ${lead.agent.agentFirstName} ${lead.agent.agentLastName}
       <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>
  <#break>
</#switch>

    END_BODY
END_TEMPLATE

START_TEMPLATE FORD_ERROR_ALERT_NRTA_2ND_TEMP
    START_SUBJECT
         Hello
    END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_TEMP ; serviceType=FORD_ERROR_ALERT; brand=FORD; track=SCHEDULE_FOLLOWUP_NO_RESPONSE; enterpriseId=76
	END_ATTR
    START_BODY

        Thanks, ${lead.contact.firstName}. <#switch "${lead.warning}">
            <#case "Time to Plan your Next Oil Change">According to the notes, it looks like your vehicleDTO is due for an engine oil and filter change soon.<#break>
            <#case "Oil Change Required">It seems like your engine oil-life is fully used, and it needs to be changed immediately, it is crucial to change the engine oil to maintain the engine's performance and longevity.<#break>
            <#case "Urgent - Oil Change Past Due">It seems like your vehicleDTO is overdue for an oil change. Regular  Oil change intervals are crucial to keeping your  engine in peak condition and avoiding potential issues related to oil breakdown.<#break>
            <#case "Change Engine Oil Soon">It seems like you have 5% or less oil-life remaining. Regular Oil change intervals are  essential to, reducing wear and tear, and ensuring your engine's overall health.<#break>
            <#case "Time to plan your next recommended service">Based on your mileage, it’s time to plan for your next recommended service to keep your vehicleDTO running at its best. Perhaps you see the light on your dashboard?<#break>
            <#case "Perform recommended service soon">Based on your mileage, it’s time to plan for your next recommended service to keep your vehicleDTO running at its best. Perhaps you see the light on your dashboard?<#break>
            <#case "Service Engine Soon">Like I said, It seems like your vehicleDTO engine will require servicing soon.<#break>
            <#case "Recommended service required">I got a notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize} thats due for the recommended service maintenance. Ford recommends service at every 7500 miles to 10000 miles or every 6 to 12 months, whichever comes first.<#break>
            <#case "Possible Tire Leak Detected">I received a notification from Ford for your ${lead.product.year?c} ${lead.product.model?capitalize} It seems like a possible tire leak has been detected.<#break>
            <#case "Vehicle Maintenance Is Due Soon">We received a notification from Ford that based on your vehicleDTO's mileage, it's time for your next recommended maintenance service.<#break>
            <#case "Reminder: Vehicle Maintenance Is Due">We received a notification from Ford that based on your vehicleDTO's mileage, your next recommended maintenance service is due.<#break>
            <#case "Oil Change and Regular Maintenance Needed">We received a notification from Ford that your vehicleDTO's connected data indicates it's time for recommended services, including oil change.<#break>
           </#switch>
           <#switch "${lead.warning}">
                 <#case "Possible Tire Leak Detected"> Would you like to get it checked at the service center?<#break>
          <#default> Would you like me to set up a service appointment for you?<#break>
          </#switch>

    END_BODY
END_TEMPLATE

START_TEMPLATE FORD_ERROR_ALERT_RTA_1ST_TEMP
    START_SUBJECT
         Hello
    END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=FORD_ERROR_ALERT; brand=FORD; enterpriseId=76
	END_ATTR
    START_BODY

        <#switch "${lead.warning}">
          <#case "Time to Plan your Next Oil Change">
                Hi ${lead.contact.firstName},

                This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Dept). I just received a notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. I was reading the notes and it seems like your vehicleDTO’s engine oil will require servicing soon.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}.
                ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
          <#break>
          <#case "Oil Change Required">
              Hi ${lead.contact.firstName},
              ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Dept). I just got another notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. This is different from the last time. It seems like your engine oil-life is fully used, and it needs to be changed IMMEDIATELY.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}.
              ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
          <#break>
          <#case "Urgent - Oil Change Past Due">
              Hi ${lead.contact.firstName},
              ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Dept). You are not going to believe this. Ford Reached out to us for the third time about your ${lead.product.year?c} ${lead.product.model?capitalize}. In their notes, they have clearly Stated your vehicleDTO is OVERDUE for an oil change.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}.

              ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
          <#break>
          <#case "Change Engine Oil Soon">
                ${lead.contact.firstName},

                ${lead.agent.agentFirstName} ${lead.agent.agentLastName} here from ${lead.office.name}. I didn't mean to bother you. This time, we got a message from the Ford Diagnostics team about your ${lead.product.year?c} ${lead.product.model?capitalize}. To be specific, they said you have 5% or LESS OIL-LIFE REMAINING.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}.

                ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
          <#break>
          <#case "Time to plan your next recommended service">
                Hello ${lead.contact.firstName},

                This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Dept). I just received a notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. I was reading the notes and based on your mileage, it's time to perform your next recommended service soon.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}.

                ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
          <#break>
          <#case "Perform recommended service soon">
                Hi ${lead.contact.firstName},

                This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Dept). I just got another notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. This is different from the last time. It seems your upcoming recommended service will be due soon based on your current mileage.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}.
                ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
          <#break>
          <#case "Service Engine Soon">
                Hi ${lead.contact.firstName},
                This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Dept). I just got a notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. I was reading the notes and it seems like your vehicleDTO's engine will require servicing soon.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}.
                ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
          <#break>
          <#case "Possible Tire Leak Detected">
                Hi ${lead.contact.firstName},
                This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Dept). I just got a notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. I was reading the notes and it seems like a possible tire leak has been detected.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch> Would you like to get your Vehicle inspected? if so I can assist you in setting up a service appointment, ${lead.contact.firstName}.
                ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
          <#break>
          <#case "Recommended service required">
                Hi ${lead.contact.firstName},

                ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Dept). I just got another notification from Ford about your ${lead.product.year?c} ${lead.product.model?capitalize}. This is different from the last time. Based on your mileage, it's time to perform your next recommended service IMMEDIATELY.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}.

                ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
          <#break>
          <#case "Vehicle Maintenance Is Due Soon">
                Hi ${lead.contact.firstName},
                ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Dept). I just received a notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. I was reading the notes and it seems like your vehicleDTO is due for maintenance soon.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}.
                ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
          <#break>
          <#case "Reminder: Vehicle Maintenance Is Due">
                Hi ${lead.contact.firstName},
                ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Dept). I just received a notification from Ford about your ${lead.product.year?c} ${lead.product.model?capitalize}. I was reading the notes and it seems like your vehicleDTO is due for maintenance.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}.
                ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
          <#break>
          <#case "Oil Change and Regular Maintenance Needed">
                Hello ${lead.contact.firstName},
                ${lead.agent.agentFirstName} here from ${lead.office.name} (Service Dept). I just received a notification from the Ford Alert System about your ${lead.product.year?c} ${lead.product.model?capitalize}. I was reading the notes and it seems like your vehicleDTO needs Oil Change and Regular Maintenance.<#switch "${lead.deal.vcpApplicable}"><#case "YES"> I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you.<#break><#case "NO"><#break></#switch> Would you like me to schedule this for you, ${lead.contact.firstName}.
                ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
          <#break>
        </#switch>

    END_BODY
END_TEMPLATE

START_TEMPLATE FORD_ERROR_ALERT_NRTA_1ST_NRAA_TEMP
    START_SUBJECT
         Hello
    END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_NRAA_TEMP; serviceType=FORD_ERROR_ALERT; brand=FORD; enterpriseId=76
	END_ATTR
    START_BODY

        Hi ${lead.contact.firstName},

        I'm just checking in on my earlier message regarding your ${lead.product.year?c} ${lead.product.model?capitalize}.
        <#switch "${lead.warning}">
        <#case "Time to Plan your Next Oil Change">Ford notified us that your ${lead.product.model?capitalize} is due for an engine oil service soon. Perhaps you see the light on your dash? <#break>
        <#case "Oil Change Required">Ford notified us that your ${lead.product.model?capitalize}'s engine oil life has reached its limit and needs to be changed right away. Perhaps you see the light on your dash? <#break>
        <#case "Urgent - Oil Change Past Due">Ford notified us that your ${lead.product.model?capitalize}'s oil change is overdue and should be taken care of soon. Perhaps you see the light on your dash? <#break>
        <#case "Change Engine Oil Soon">Ford notified us that your ${lead.product.model?capitalize}'s oil life is critically low, it's 5% or less remaining. Perhaps you see the light on your dash? <#break>
        <#case "Time to plan your next recommended service">Ford notified us that based on your  mileage, it's now time for your next recommended service. Perhaps you see the light on your dash? <#break>
        <#case "Perform recommended service soon">Ford notified us that your next recommended service will be due soon. Perhaps you see the light on your dash? <#break>
        <#case "Service Engine Soon">Ford notified us that your ${lead.product.model?capitalize} might need engine service soon. Perhaps you see the light on your dash? <#break>
        <#case "Possible Tire Leak Detected">Ford notified us about a potential tire leak that may need attention. Perhaps you see the light on your dash? <#break>
        <#case "Recommended service required">Ford notified us that your ${lead.product.model?capitalize} is due for its recommended service now, based on your mileage. Perhaps you see the light on your dash? <#break>
        <#case "Vehicle Maintenance Is Due Soon">Ford notified us that your ${lead.product.model?capitalize} needs maintenance soon. Perhaps you see the light on your dash? <#break>
        <#case "Reminder: Vehicle Maintenance Is Due">Ford notified us that your ${lead.product.model?capitalize} needs maintenance soon. Perhaps you see the light on your dash? <#break>
        <#case "Oil Change and Regular Maintenance Needed">Ford notified us that your ${lead.product.model?capitalize} is due for both an oil change and regular maintenance. Perhaps you see the light on your dash? <#break>
        </#switch>
         If you'd like to set up an appointment, all I need is a date and time that works for you, and I'll take care of the rest.

         Prefiere Espanol?

         ${lead.agent.agentFirstName}.
         <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

    END_BODY
END_TEMPLATE

START_TEMPLATE FORD_ERROR_ALERT_NRTA_2ND_NRAA_TEMP
    START_SUBJECT
         Hello
    END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_2ND_NRAA_TEMP; serviceType=FORD_ERROR_ALERT; brand=FORD; enterpriseId=76
	END_ATTR
    START_BODY

         ${lead.contact.firstName},

         Not sure if you have already done the <#switch "${lead.warning}"><#case "Time to Plan your Next Oil Change">oil change service<#break><#case "Oil Change Required">oil change service<#break><#case "Urgent - Oil Change Past Due">oil change service<#break><#case "Change Engine Oil Soon">oil change service<#break><#case "Time to plan your next recommended service">recommended scheduled maintenance<#break><#case "Perform recommended service soon">recommended scheduled maintenance<#break><#case "Service Engine Soon">engine service<#break><#case "Possible Tire Leak Detected">tire inspected<#break><#case "Recommended service required">recommended scheduled maintenance<#break><#case "Vehicle Maintenance Is Due Soon">recommended scheduled maintenance<#break><#case "Reminder: Vehicle Maintenance Is Due">recommended scheduled maintenance<#break><#case "Oil Change and Regular Maintenance Needed">regular maintenance and oil change<#break></#switch> on your ${lead.product.year?c} ${lead.product.model?capitalize} or you don't need an appt at this time. If you have any questions or you need any assistance in setting a service appointment, please feel free to text me. Have a great day.

         Prefiere Espanol?

         ${lead.agent.agentFirstName}.
         <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

    END_BODY
END_TEMPLATE

START_TEMPLATE FORD_ERROR_ALERT_RTA_1ST_NRAA_TEMP
    START_SUBJECT
         Hello
    END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_NRAA_TEMP; serviceType=FORD_ERROR_ALERT; brand=FORD; enterpriseId=76
	END_ATTR
    START_BODY

        Hi ${lead.contact.firstName},

        I'm just checking in on my earlier message regarding your ${lead.product.year?c} ${lead.product.model?capitalize}.
        <#switch "${lead.warning}">
        <#case "Time to Plan your Next Oil Change">Ford notified us that your ${lead.product.model?capitalize} is due for an engine oil service soon. Perhaps you see the light on your dash? <#break>
        <#case "Oil Change Required">Ford notified us that your ${lead.product.model?capitalize}'s engine oil life has reached its limit and needs to be changed right away. Perhaps you see the light on your dash? <#break>
        <#case "Urgent - Oil Change Past Due">Ford notified us that your ${lead.product.model?capitalize}'s oil change is overdue and should be taken care of soon. Perhaps you see the light on your dash? <#break>
        <#case "Change Engine Oil Soon">Ford notified us that your ${lead.product.model?capitalize}'s oil life is critically low, it's 5% or less remaining. Perhaps you see the light on your dash? <#break>
        <#case "Time to plan your next recommended service">Ford notified us that based on your  mileage, it's now time for your next recommended service. Perhaps you see the light on your dash? <#break>
        <#case "Perform recommended service soon">Ford notified us that your next recommended service will be due soon. Perhaps you see the light on your dash? <#break>
        <#case "Service Engine Soon">Ford notified us that your ${lead.product.model?capitalize} might need engine service soon. Perhaps you see the light on your dash? <#break>
        <#case "Possible Tire Leak Detected">Ford notified us about a potential tire leak that may need attention. Perhaps you see the light on your dash? <#break>
        <#case "Recommended service required">Ford notified us that your ${lead.product.model?capitalize} is due for its recommended service now, based on your mileage. Perhaps you see the light on your dash? <#break>
        <#case "Vehicle Maintenance Is Due Soon">Ford notified us that your ${lead.product.model?capitalize} needs maintenance soon. Perhaps you see the light on your dash? <#break>
        <#case "Reminder: Vehicle Maintenance Is Due">Ford notified us that your ${lead.product.model?capitalize} needs maintenance soon. Perhaps you see the light on your dash? <#break>
        <#case "Oil Change and Regular Maintenance Needed">Ford notified us that your ${lead.product.model?capitalize} is due for both an oil change and regular maintenance. Perhaps you see the light on your dash? <#break>
        </#switch>
         If you'd like to set up an appointment, all I need is a date and time that works for you, and I'll take care of the rest.

         ${lead.agent.agentFirstName}.

    END_BODY
END_TEMPLATE

START_TEMPLATE FORD_ERROR_ALERT_RTA_2ND_NRAA_TEMP
    START_SUBJECT
         Hello
    END_SUBJECT
    START_ATTR
	    intent=AN_RTA_2ND_NRAA_TEMP; serviceType=FORD_ERROR_ALERT; brand=FORD; enterpriseId=76
	END_ATTR
    START_BODY

         ${lead.contact.firstName},

         Not sure if you have already done the <#switch "${lead.warning}"><#case "Time to Plan your Next Oil Change">oil change service<#break><#case "Oil Change Required">oil change service<#break><#case "Urgent - Oil Change Past Due">oil change service<#break><#case "Change Engine Oil Soon">oil change service<#break><#case "Time to plan your next recommended service">recommended scheduled maintenance<#break><#case "Perform recommended service soon">recommended scheduled maintenance<#break><#case "Service Engine Soon">engine service<#break><#case "Possible Tire Leak Detected">tire inspected<#break><#case "Recommended service required">recommended scheduled maintenance<#break><#case "Vehicle Maintenance Is Due Soon">recommended scheduled maintenance<#break><#case "Reminder: Vehicle Maintenance Is Due">recommended scheduled maintenance<#break><#case "Oil Change and Regular Maintenance Needed">regular maintenance and oil change<#break></#switch> on your ${lead.product.year?c} ${lead.product.model?capitalize} or you don't need an appt at this time. If you have any questions or you need any assistance in setting a service appointment, please feel free to text me. Have a great day.

         ${lead.agent.agentFirstName}.

    END_BODY
END_TEMPLATE

START_TEMPLATE FORD_ERROR_ALERT_RTA_2ND_NRAA_TEMP
    START_SUBJECT
         Hello
    END_SUBJECT
    START_ATTR
	    intent=AN_RTA_2ND_NRAA_TEMP; serviceType=FORD_ERROR_ALERT; brand=FORD; enterpriseId=76
	END_ATTR
    START_BODY

         ${lead.contact.firstName},

         Not sure if you have already done the <#switch "${lead.warning}"><#case "Time to Plan your Next Oil Change">oil change service<#break><#case "Oil Change Required">oil change service<#break><#case "Urgent - Oil Change Past Due">oil change service<#break><#case "Change Engine Oil Soon">oil change service<#break><#case "Time to plan your next recommended service">recommended scheduled maintenance<#break><#case "Perform recommended service soon">recommended scheduled maintenance<#break><#case "Service Engine Soon">engine service<#break><#case "Possible Tire Leak Detected">tire inspected<#break><#case "Recommended service required">recommended scheduled maintenance<#break><#case "Vehicle Maintenance Is Due Soon">recommended scheduled maintenance<#break><#case "Reminder: Vehicle Maintenance Is Due">recommended scheduled maintenance<#break><#case "Oil Change and Regular Maintenance Needed">regular maintenance and oil change<#break></#switch> on your ${lead.product.year?c} ${lead.product.model?capitalize} or you don't need an appt at this time. If you have any questions or you need any assistance in setting a service appointment, please feel free to text me. Have a great day.

         ${lead.agent.agentFirstName}.

    END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_TOYOTACARE_NATIONWIDE_TEMP
    START_SUBJECT
         Hello
    END_SUBJECT
    START_ATTR
	    intent=TOYOTACARE_NATIONWIDE; serviceType=TOYOTA_5K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
    START_BODY

        We were looking forward to seeing you again, but if our dealership is out of the way, keep in mind that the service is complimentary at any Toyota dealership nationwide. Thank you for purchasing your vehicleDTO from ${lead.office.name} and have a great day!

    END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_HONDACARE_NATIONWIDE_TEMP
    START_SUBJECT
         Hello
    END_SUBJECT
    START_ATTR
	    intent=HONDACARE_NATIONWIDE; serviceType=HONDA_7500_NEW; brand=HONDA; enterpriseId=76
	END_ATTR
    START_BODY

        We were looking forward to seeing you again, but if our dealership is out of the way, keep in mind that the service is complimentary at any Honda dealership nationwide. Thank you for purchasing your vehicleDTO from ${lead.office.name} and have a great day!

    END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_TOYOTA_CARE_PLAN_TOYOTA_5K_NEW_TEMP
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=TOYOTA_CARE_PLAN; serviceType=TOYOTA_5K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        <#switch "${lead.deal.plannedServiceType?lower_case}">
            <#case "tea">
                <#if lead.storeId = '3PA106208'>
                    ToyotaCare provides up to 5 scheduled Maintenance services during the initial 2 year period. This is typically recommended every 5 months or every 5000 miles whichever is earlier.
                <#else>
                    ToyotaCare provides up to 5 scheduled Maintenance services during the initial 2 year period. This is typically due every 5 months or every 5000 miles whichever is earlier.
                </#if>
            <#break>
            <#default>
                <#if lead.storeId = '3PA106208'>
                    ToyotaCare provides up to 5 scheduled Maintenance services during the initial 2 year period. This is typically recommended every 5 months or every 5000 miles whichever is earlier. I didn't want you to lose out on any of these intervals.
                <#else>
                    ToyotaCare provides up to 5 scheduled Maintenance services during the initial 2 year period. This is typically due every 5 months or every 5000 miles whichever is earlier. I didn't want you to lose out on any of these intervals.
                </#if>
            <#break>
        </#switch>

	 END_BODY
END_TEMPLATE

START_TEMPLATE AUTONATION_OBJECTION_LOW_MILEAGE_V2_5K_TEMP
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=OBJECTION_LOW_MILEAGE_V2_5K; serviceType=TOYOTA_5K_NEW; brand=TOYOTA; track=SCHEDULE_FOLLOW_UP_DD_M; enterpriseId=76
	END_ATTR
	START_BODY

        I understand that you have fewer miles on your ${lead.product.year?c} ${lead.product.model?capitalize}. However, the 5k service is recommended at <#switch "${lead.deal.plannedServiceType?lower_case}"><#case "toyo_5k_new">5 months<#break><#default>6 months<#break></#switch> or at 5K miles, whichever comes first. Your 5K Service ${lead.deal.nextServiceWasDueOrMightBeDue} ${lead.deal.descriptiveDueDate5k} even if you have fewer miles than 5k. Would you like me to set this up for you, ${lead.contact.firstName}?

	 END_BODY
END_TEMPLATE

START_TEMPLATE TOYOTA_ERROR_ALERT_NRTA_1ST_TEMP
    START_SUBJECT
         Hello
    END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_TEMP; serviceType=TOYOTA_ERROR_ALERT; brand=TOYOTA; enterpriseId=76
	END_ATTR
    START_BODY

        Hi ${lead.contact.firstName},

        This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Dept). I received a notification from Toyota about your ${lead.product.year?c} ${lead.product.model?capitalize}. <#switch "${lead.warning}">
            <#case "BLVW">I was reading the notes and It seems like brake fluid level is low, continuing to drive may be dangerous.<#break>
            <#case "BAT1">I was reading the notes and It seems like Hybrid battery maintenance is required.<#break>
            <#case "BAT2">I was reading the notes and It seems like your Hybrid battery requires maintenance, continuing to drive may be dangerous.<#break>
            <#case "BAT3">I was reading the notes and It seems like your Hybrid battery requires maintenance. Continuing to drive may be dangerous.<#break>
            <#case "ISSW">It seems like there is a malfunction in the start and stop system. Continuing to drive may be dangerous.<#break>
            <#case "CCW">It seems like there is a malfunction in the Cruise Control System. Deactivate cruise control by pressing the "ON-OFF" button once, press again to reactivate it.<#break>
            <#case "TRCW">It seems like the Traction Control System has been deactivated. Press the traction control button to turn it on.<#break>
            <#case "EGF">It seems like there is a malfunction in the electronic control of the engine, throttle, or automatic transmission.<#break>
            <#case "ABSW">It seems like there is a malfunction in the Anti-Lock Brake System or brake assist system. This could be dangerous in certain conditions.<#break>
            <#case "VSCW">It seems like there is a malfunction in the VSC, TRAC, or hill-start assist control system, do not rely on this system until inspected.<#break>
            <#case "FWSW">It seems like there is a malfunction in the Dynamic Rear Steering System.<#break>
            <#case "OMPW">It seems like the vehicleDTO engine oil maintenance is required soon. Do you see the notification on your dashboard?<#break>
            <#case "OMDW">It seems like the vehicleDTO engine oil maintenance is required soon. Do you see the notification on your dashboard?<#break>
            <#case "MCMW">It seems like there is a malfunction in the Secondary Crash Mitigation Support Brake System.<#break>
            <#case "VPNW">It seems like there is a malfunction in the Vehicle Proximity Notification System.<#break>
            <#case "OPW">It seems like the engine oil pressure is low, continuing to drive may be dangerous.<#break>
            <#case "OLW">It seems like the engine oil level is low, you may need to add engine oil as necessary.<#break>
            <#case "LW">It seems like there is a malfunction in the Charging System, continuing to drive may be dangerous.<#break>
            <#case "LFW">It seems like there is a malfunction in the Rear Light System, which may be dangerous in certain driving conditions.<#break>
            <#case "FSRS">It seems like there is a malfunction in the SRS Airbag System.<#break>
            <#case "HALW">It seems like there is a malfunction in the Automatic Headlight Leveling System.<#break>
            <#case "EPSW">It seems like there is a malfunction in the Electric Power Steering System.<#break>
            <#case "BRW">It seems like there is a malfunction in the Brake System, continuing to drive may be dangerous.<#break>
            <#case "TIRW">It seems like there is a malfunction in the Tire Pressure Warning System, do not rely on this system until inspected.<#break>
            <#case "ECBW">It seems like there is a malfunction in the Electric Control Braking System, tis may be dangerous in certain drving conditions.<#break>
            <#case "FWW">It seems like there is a malfunction in the All-Wheel Drive System.<#break>
            <#case "AFSW">It seems like there is a malfunction in the Adaptive Front-Lighting System.<#break>
            <#case "SUSW">It seems like there is a malfunction in the Air Suspension System, this could be dangerous in certain conditions.<#break>
            <#case "NVW">It seems like there is a malfunction in the Night View System, do not rely on this system until inspected.<#break>
            <#case "VGRW">It seems like there is a malfunction in the Variable Gear Ratio Steering System.<#break>
            <#case "BPAW">I was reading the notes and It seems like your brake pads are worn and need to be inspected.<#break>
            <#case "LKAW">It seems like there is a malfunction in the Lane-Keeping Assist System, do not rely on this system until inspected.<#break>
            <#case "DABW">It seems like there is a malfunction in the Driver-assist Braking Control System.<#break>
            <#case "METPCSW">It seems like there is a malfunction in the Pre-Collision System, do not rely on this system until inspected.<#break>
            <#case "WTPW">I was reading the notes and It seems like your vehicleDTO engine is overheating, continuing to drive may be dangerous.<#break>
            <#case "ASTW">It seems like there is a malfunction in the Active Stabilizer Suspension System, do not rely on this system.<#break>
            <#case "HVSW">It seems like there is a malfunction in the Hybrid System.<#break>
            <#case "MIHW">I was reading the notes and It seems like Hybrid System is overheating.<#break>
            <#case "EPBW">It seems like there is a malfunction in the Parking Brake System, do not rely on this system until inspected.<#break>
            <#case "ESLW">It seems like there is a malfunction in the Steering Lock System.<#break>
            <#case "RRLW">It seems like there is a malfunction in the Rear Light System, which may be dangerous in certain driving conditions.<#break>
            <#case "PMSW">It seems like there is a malfunction in the Electric Power Control System.<#break>
            <#case "CSOW">It seems like there is a malfunction in the Sonar System, do not rely on this system until inspected.<#break>
            <#case "AHSW">It seems like there is a malfunction in the Brake Hold System, do not rely on this system.<#break>
            <#case "LHLW">It seems like there is a malfunction in the LED Head Light System.<#break>
            <#case "SBWW">It seems like there is a malfunction in the Shift Lock System.<#break>
            <#case "MTPW">It seems like there is a malfunction in the Convertible Roof System.<#break>
            <#case "SMBW">It seems like there is a malfunction in the Automatic High Beam System, this could be dangerous in certain driving conditions.<#break>
            <#case "KDSW">It seems like there is a malfunction in the Kinetic Dynamic Suspension System.<#break>
            <#case "OMRW">I was reading the notes and It seems like your vehicleDTO requires maintainance. Do you see the notification on your dashboard?<#break>
            <#case "SMTW">It seems like there is a malfunction in the Transmission System, are you experiencing any issues?<#break>
            <#case "OCW">It seems like there is a malfunction in the ATF (Automatic Transmission Fluid) Cooler.<#break>
            <#case "FCTW">It seems like there is a malfunction in the Active Rear Wing System.<#break>
            <#case "REVWW">It seems like there is a malfunction in the Wiper System.<#break>
            <#case "EXSW">It seems like there is a malfunction in the Seat Control System.<#break>
            <#case "INJW">I was reading the notes and It seems like Injector maintenance is required.<#break>
            <#case "SSW">It seems like there is a malfunction in the Smart Access System with Push-button Start.<#break>
            <#case "BSDW">It seems like there is a malfunction in the Blind Spot Monitor System. do not rely on the system for lane changing.<#break>
            <#case "GSW">It seems like there is a malfunction in the Grill Shutter System.<#break>
            <#case "AZBW">It seems like there is a malfunction in the Headlight System, which may be dangerous during night driving.<#break>
            <#case "PUHW">It seems like there is a malfunction in the Pop Up Hood System.<#break>
            <#case "METLDW">I was reading the notes and It seems like the Lane Departure Alert System has been suspended, do not rely on the system for lane changing until inspected.<#break>
            <#case "MTSW">It seems like there is a malfunction in the Multi-Terrain Select System.<#break>
            <#case "EVSW">It seems like there is a malfunction in the EV System.<#break>
            <#case "ATSW">It seems like there is a malfunction in the Automatic Transmission System, this may need immediate inspection.<#break>
            <#case "EVHW">I was reading the notes and It seems like the EV System may be overheating. This may be dangerous.<#break>
            <#case "GOSW">It seems like there is a malfunction in the Drive Start Control System.<#break>
            <#case "BOSW">It seems like there is a malfunction in the Smart Stop System.<#break>
            <#case "HVBW">I was reading the notes and It seems like your Hybrid System requires maintenance.<#break>
            <#case "ASSW">It seems like there is a malfunction in the Intelligent Clearance Sonar System.<#break>
            <#case "TVDW">It seems like there is a malfunction in the Differential System.<#break>
            <#case "HVSW2">It seems like there is a malfunction in the Hybrid System.<#break>
            <#case "SBWW1">It seems like there is a malfunction in the Shift Control System.<#break>
            <#case "SBWW2">It seems like there is a malfunction in the Shift Control System.<#break>
            <#case "SBWW3">It seems like there is a malfunction in the Shift Control System.<#break>
            <#case "FCW1">It seems like there is a malfunction in the Fuel Cell System.<#break>
            <#case "FCW2">It seems like there is a malfunction in the Fuel Cell System and the Fuel Cell System has stopped.<#break>
            <#case "H2W1">I was reading the notes and It seems like there is a Hydrogen Leakage.<#break>
            <#case "H2W2">I was reading the notes and It seems like there is a Hydrogen Leakage and Fuel cell system stopped. This requires inspection.<#break>
            <#case "H2SW">It seems like there is a malfunction in the Hydrogen Detection System.<#break>
            <#case "IONW">I was reading the notes and It seems like Ion filter replacement is required.<#break>
            <#case "FCHW">I was reading the notes and It seems like Fuel System may be overheating.<#break>
            <#case "IPAFAIL">I was reading the notes and It seems like Intelligent Parking Assist is out of service.<#break>
            <#default>
            <#break>
        </#switch> <#switch "${lead.deal.vcpApplicable}"><#case "YES">I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Is it OK for me to text you to discuss this further?

        Prefiere Espanol?

        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.
        <#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

    END_BODY
END_TEMPLATE

START_TEMPLATE TOYOTA_ERROR_ALERT_NRTA_1ST_NRAA_TEMP
    START_SUBJECT
         Hello
    END_SUBJECT
    START_ATTR
	    intent=AN_NRTA_1ST_NRAA_TEMP; serviceType=TOYOTA_ERROR_ALERT; brand=TOYOTA; enterpriseId=76
	END_ATTR

    START_BODY

<#if lead.warning = 'OMRW'>
${lead.contact.firstName}, Not sure if you got my previous text about the regular maintenance (because sometimes I have bad reception). If this is not a good time, just let me know and I will follow up later. If you are ready to book an appointment, all I need is a date and time that works for you (No need to call). It's that easy.

Prefiere Espanol?

<#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

<#else>
${lead.contact.firstName}, Not sure if you got my previous text about the notification I received from Toyota about your ${lead.product.year?c} ${lead.product.model} (because sometimes I have bad reception). If this is not a good time, just let me know and I will follow up later. If you are ready to book an appointment, all I need is a date and time that works for you (No need to call). It's that easy.

Prefiere Espanol?

<#switch "${lead.deal.lastTransactionType}"><#case "PostDec2024">P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break><#case "PreDec2024">Reply YES to consent to automated texts (not required for purchase). STOP anytime. Msg & data rates may apply.<#break><#default>P.S. If you prefer not to use text, you can reply stop to opt out anytime.<#break></#switch>

</#if>

    END_BODY

END_TEMPLATE

START_TEMPLATE TOYOTA_ERROR_ALERT_RTA_1ST_TEMP
    START_SUBJECT
         Hello
    END_SUBJECT
    START_ATTR
	    intent=AN_RTA_1ST_TEMP; serviceType=TOYOTA_ERROR_ALERT; brand=TOYOTA; enterpriseId=76
	END_ATTR
    START_BODY

        Hi ${lead.contact.firstName},

        This is ${lead.agent.agentFirstName} from ${lead.office.name} (Service Dept). I received a notification from Toyota about your ${lead.product.year?c} ${lead.product.model?capitalize}. <#switch "${lead.warning}">
            <#case "BLVW">I was reading the notes and It seems like brake fluid level is low, continuing to drive may be dangerous.<#break>
            <#case "BAT1">I was reading the notes and It seems like Hybrid battery maintenance is required.<#break>
            <#case "BAT2">I was reading the notes and It seems like your Hybrid battery requires maintenance, continuing to drive may be dangerous.<#break>
            <#case "BAT3">I was reading the notes and It seems like your Hybrid battery requires maintenance. Continuing to drive may be dangerous.<#break>
            <#case "ISSW">It seems like there is a malfunction in the start and stop system. Continuing to drive may be dangerous.<#break>
            <#case "CCW">It seems like there is a malfunction in the Cruise Control System. Deactivate cruise control by pressing the "ON-OFF" button once, press again to reactivate it.<#break>
            <#case "TRCW">It seems like the Traction Control System has been deactivated. Press the traction control button to turn it on.<#break>
            <#case "EGF">It seems like there is a malfunction in the electronic control of the engine, throttle, or automatic transmission.<#break>
            <#case "ABSW">It seems like there is a malfunction in the Anti-Lock Brake System or brake assist system. This could be dangerous in certain conditions.<#break>
            <#case "VSCW">It seems like there is a malfunction in the VSC, TRAC, or hill-start assist control system, do not rely on this system until inspected.<#break>
            <#case "FWSW">It seems like there is a malfunction in the Dynamic Rear Steering System.<#break>
            <#case "OMPW">It seems like the vehicleDTO engine oil maintenance is required soon. Do you see the notification on your dashboard?<#break>
            <#case "OMDW">It seems like the vehicleDTO engine oil maintenance is required soon. Do you see the notification on your dashboard?<#break>
            <#case "MCMW">It seems like there is a malfunction in the Secondary Crash Mitigation Support Brake System.<#break>
            <#case "VPNW">It seems like there is a malfunction in the Vehicle Proximity Notification System.<#break>
            <#case "OPW">It seems like the engine oil pressure is low, continuing to drive may be dangerous.<#break>
            <#case "OLW">It seems like the engine oil level is low, you may need to add engine oil as necessary.<#break>
            <#case "LW">It seems like there is a malfunction in the Charging System, continuing to drive may be dangerous.<#break>
            <#case "LFW">It seems like there is a malfunction in the Rear Light System, which may be dangerous in certain driving conditions.<#break>
            <#case "FSRS">It seems like there is a malfunction in the SRS Airbag System.<#break>
            <#case "HALW">It seems like there is a malfunction in the Automatic Headlight Leveling System.<#break>
            <#case "EPSW">It seems like there is a malfunction in the Electric Power Steering System.<#break>
            <#case "BRW">It seems like there is a malfunction in the Brake System, continuing to drive may be dangerous.<#break>
            <#case "TIRW">It seems like there is a malfunction in the Tire Pressure Warning System, do not rely on this system until inspected.<#break>
            <#case "ECBW">It seems like there is a malfunction in the Electric Control Braking System, tis may be dangerous in certain drving conditions.<#break>
            <#case "FWW">It seems like there is a malfunction in the All-Wheel Drive System.<#break>
            <#case "AFSW">It seems like there is a malfunction in the Adaptive Front-Lighting System.<#break>
            <#case "SUSW">It seems like there is a malfunction in the Air Suspension System, this could be dangerous in certain conditions.<#break>
            <#case "NVW">It seems like there is a malfunction in the Night View System, do not rely on this system until inspected.<#break>
            <#case "VGRW">It seems like there is a malfunction in the Variable Gear Ratio Steering System.<#break>
            <#case "BPAW">I was reading the notes and It seems like your brake pads are worn and need to be inspected.<#break>
            <#case "LKAW">It seems like there is a malfunction in the Lane-Keeping Assist System, do not rely on this system until inspected.<#break>
            <#case "DABW">It seems like there is a malfunction in the Driver-assist Braking Control System.<#break>
            <#case "METPCSW">It seems like there is a malfunction in the Pre-Collision System, do not rely on this system until inspected.<#break>
            <#case "WTPW">I was reading the notes and It seems like your vehicleDTO engine is overheating, continuing to drive may be dangerous.<#break>
            <#case "ASTW">It seems like there is a malfunction in the Active Stabilizer Suspension System, do not rely on this system.<#break>
            <#case "HVSW">It seems like there is a malfunction in the Hybrid System.<#break>
            <#case "MIHW">I was reading the notes and It seems like Hybrid System is overheating.<#break>
            <#case "EPBW">It seems like there is a malfunction in the Parking Brake System, do not rely on this system until inspected.<#break>
            <#case "ESLW">It seems like there is a malfunction in the Steering Lock System.<#break>
            <#case "RRLW">It seems like there is a malfunction in the Rear Light System, which may be dangerous in certain driving conditions.<#break>
            <#case "PMSW">It seems like there is a malfunction in the Electric Power Control System.<#break>
            <#case "CSOW">It seems like there is a malfunction in the Sonar System, do not rely on this system until inspected.<#break>
            <#case "AHSW">It seems like there is a malfunction in the Brake Hold System, do not rely on this system.<#break>
            <#case "LHLW">It seems like there is a malfunction in the LED Head Light System.<#break>
            <#case "SBWW">It seems like there is a malfunction in the Shift Lock System.<#break>
            <#case "MTPW">It seems like there is a malfunction in the Convertible Roof System.<#break>
            <#case "SMBW">It seems like there is a malfunction in the Automatic High Beam System, this could be dangerous in certain driving conditions.<#break>
            <#case "KDSW">It seems like there is a malfunction in the Kinetic Dynamic Suspension System.<#break>
            <#case "OMRW">I was reading the notes and It seems like your vehicleDTO requires maintainance. Do you see the notification on your dashboard?<#break>
            <#case "SMTW">It seems like there is a malfunction in the Transmission System, are you experiencing any issues?<#break>
            <#case "OCW">It seems like there is a malfunction in the ATF (Automatic Transmission Fluid) Cooler.<#break>
            <#case "FCTW">It seems like there is a malfunction in the Active Rear Wing System.<#break>
            <#case "REVWW">It seems like there is a malfunction in the Wiper System.<#break>
            <#case "EXSW">It seems like there is a malfunction in the Seat Control System.<#break>
            <#case "INJW">I was reading the notes and It seems like Injector maintenance is required.<#break>
            <#case "SSW">It seems like there is a malfunction in the Smart Access System with Push-button Start.<#break>
            <#case "BSDW">It seems like there is a malfunction in the Blind Spot Monitor System. do not rely on the system for lane changing.<#break>
            <#case "GSW">It seems like there is a malfunction in the Grill Shutter System.<#break>
            <#case "AZBW">It seems like there is a malfunction in the Headlight System, which may be dangerous during night driving.<#break>
            <#case "PUHW">It seems like there is a malfunction in the Pop Up Hood System.<#break>
            <#case "METLDW">I was reading the notes and It seems like the Lane Departure Alert System has been suspended, do not rely on the system for lane changing until inspected.<#break>
            <#case "MTSW">It seems like there is a malfunction in the Multi-Terrain Select System.<#break>
            <#case "EVSW">It seems like there is a malfunction in the EV System.<#break>
            <#case "ATSW">It seems like there is a malfunction in the Automatic Transmission System, this may need immediate inspection.<#break>
            <#case "EVHW">I was reading the notes and It seems like the EV System may be overheating. This may be dangerous.<#break>
            <#case "GOSW">It seems like there is a malfunction in the Drive Start Control System.<#break>
            <#case "BOSW">It seems like there is a malfunction in the Smart Stop System.<#break>
            <#case "HVBW">I was reading the notes and It seems like your Hybrid System requires maintenance.<#break>
            <#case "ASSW">It seems like there is a malfunction in the Intelligent Clearance Sonar System.<#break>
            <#case "TVDW">It seems like there is a malfunction in the Differential System.<#break>
            <#case "HVSW2">It seems like there is a malfunction in the Hybrid System.<#break>
            <#case "SBWW1">It seems like there is a malfunction in the Shift Control System.<#break>
            <#case "SBWW2">It seems like there is a malfunction in the Shift Control System.<#break>
            <#case "SBWW3">It seems like there is a malfunction in the Shift Control System.<#break>
            <#case "FCW1">It seems like there is a malfunction in the Fuel Cell System.<#break>
            <#case "FCW2">It seems like there is a malfunction in the Fuel Cell System and the Fuel Cell System has stopped.<#break>
            <#case "H2W1">I was reading the notes and It seems like there is a Hydrogen Leakage.<#break>
            <#case "H2W2">I was reading the notes and It seems like there is a Hydrogen Leakage and Fuel cell system stopped. This requires inspection.<#break>
            <#case "H2SW">It seems like there is a malfunction in the Hydrogen Detection System.<#break>
            <#case "IONW">I was reading the notes and It seems like Ion filter replacement is required.<#break>
            <#case "FCHW">I was reading the notes and It seems like Fuel System may be overheating.<#break>
            <#case "IPAFAIL">I was reading the notes and It seems like Intelligent Parking Assist is out of service.<#break>
            <#default>
            <#break>
        </#switch>
         <#switch "${lead.warning}">
              <#case "OMRW"> <#switch "${lead.deal.vcpApplicable}"><#case "YES">I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Would you like me to schedule this for you, ${lead.contact.firstName}.<#break>
         <#default> <#switch "${lead.deal.vcpApplicable}"><#case "YES">I see you have ${lead.deal.vcpRemainingCount} available on your AutoNation Vehicle Care (exp ${lead.deal.vcpExpireDate}), So it wont cost you. <#break><#case "NO"> <#break></#switch>Would you like to get your Vehicle inspected so we can now diagnose the problem?<#break>
         </#switch>

        ${lead.agent.agentFirstName} ${lead.agent.agentLastName}.

    END_BODY
END_TEMPLATE

START_TEMPLATE AN_FORD_CUSTOMER_A_PERFORM_SERVICE_BY_OWN
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=CUST_PERFORM_SVC_BY_OWN; serviceType=FORD_ERROR_ALERT; brand=FORD; enterpriseId=76
	END_ATTR
	START_BODY

        I understand that you prefer to do the maintenance on your own. However, every auto model has its particular quirks. Mechanics at Ford dealers are well-versed in how Ford vehicleDTOS are made and have specific knowledge of common issues or quirks of your ${lead.product.year?c} ${lead.product.model?capitalize}.

    END_BODY
END_TEMPLATE

START_TEMPLATE CUST_ASK_ANA_IDENTITY_WITH_PHONENUMBER
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=ASK_ANA_IDENTITY_WITH_PHONENUMBER; serviceType=LEXUS_NEXTSERVICE1,LEXUS_NEXTSERVICE2,TOYOTA_NEXTSERVICE1,TOYOTA_NEXTSERVICE2,HONDA_NEXTSERVICE1,HONDA_NEXTSERVICE2,FORD_NEXTSERVICE1,FORD_NEXTSERVICE2,FORD_ERROR_ALERT,GM_ALERT,TOYOTA_ERROR_ALERT,CHEVY_NEXTSERVICE1,CHEVY_NEXTSERVICE2,LEXUS_5K_USED,TOYOTA_5K_USED,HONDA_5K_USED,FORD_5K_USED,CHEVY_5K_USED,FORD_5K_NEW,CHEVY_5K_NEW,LEXUS_5K_NEW,TOYOTA_5K_NEW,HONDA_7500_NEW,HONDA_90D_NEW,CHEVY_10K_NEW,LEXUS_10K_NEW,HONDA_15K_NEW,FORD_10K_NEW,TOYOTA_10K_NEW,TOYOTA_15K_NEW,TOYOTA_20K_NEW,TOYOTA_25K_NEW; brand=TOYOTA,LEXUS,FORD,HONDA,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        ${lead.contact.firstName}, ${lead.agent.agentFirstName} here from ${lead.office.name} and the phone is ${lead.agent.agentPhoneNumber}.

	END_BODY
END_TEMPLATE

START_TEMPLATE GENERIC_OILCHANGE_CUSTOMER_A_PERFORM_SERVICE_OILCHANGE_15k
	START_SUBJECT
        Hello
	END_SUBJECT
    START_ATTR
	    intent=DOES_IT_INCLUDE_OIL_CHANGE_TOYOTA_15K; serviceType=TOYOTA_15K_NEW; brand=TOYOTA; enterpriseId=76
	END_ATTR
	START_BODY

        Yes, the ToyotaCare includes oil change. If your vehicleDTO uses Synthetic oil, this is recommended at 10K and 20K. But the 15K Service also includes services such as tire rotation, fluid level adjustment, and brake inspection and won't cost you anything. Let me know if you would like to set up an appointment.

    END_BODY
END_TEMPLATE

START_TEMPLATE OIL_AND_CABIN_AIR_FILTER_COST_4GM_ALERT
	START_SUBJECT
		Hello
	END_SUBJECT
    START_ATTR
	    intent=OIL_AND_CABIN_AIR_FILTER_COST; serviceType=GM_ALERT; brand=BUICK,GMC,CHEVROLET; enterpriseId=76
	END_ATTR
	START_BODY

        Oil change, filter change, multi point inspection, for up to 5 quartz synthetic oil is $99.95. Cabin air filters will range from $90 to $130 depending on filter.

	 END_BODY
END_TEMPLATE