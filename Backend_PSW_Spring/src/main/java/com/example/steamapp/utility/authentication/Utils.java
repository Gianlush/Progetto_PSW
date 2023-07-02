package com.example.steamapp.utility.authentication;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.experimental.UtilityClass;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;


@UtilityClass
@Log4j2
public class Utils {


    public Jwt getPrincipal() {
        SecurityContext s = SecurityContextHolder.getContext();
        Authentication a = s.getAuthentication();
        Object o = a.getPrincipal();
        Jwt j = (Jwt) o;
        return j;
    }

    public String getAuthServerId() {
        return getTokenNode().get("subject").asText();
    }

    public String getName() {
        return getTokenNode().get("claims").get("name").asText();
    }

    public String getEmail() {
        JsonNode n = getTokenNode();
        JsonNode n1 = n.get("claims");
        JsonNode n2 = n1.get("preferred_username");
        String x = n2.asText();
        System.out.println(x);
        return getTokenNode().get("claims").get("preferred_username").asText();
    }

    private JsonNode getTokenNode() {
        Jwt jwt = getPrincipal();
        ObjectMapper objectMapper = new ObjectMapper();
        String jwtAsString;
        JsonNode jsonNode;
        try {
            jwtAsString = objectMapper.writeValueAsString(jwt);
            jsonNode = objectMapper.readTree(jwtAsString);
        } catch (JsonProcessingException e) {
            log.error(e.getMessage());
            throw new RuntimeException("Unable to retrieve user's info!");
        }
        return jsonNode;
    }


}