package com.hellokoding.springboot.view.config;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hellokoding.springboot.view.model.UserModel;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.core.env.Environment;
import org.springframework.http.*;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Service
@Configurable
public class AuthenticateConfig implements AuthenticationProvider {
    @Autowired
    private Environment env;

    /**
     * This method override the default authentication method
     * Using our self-develop api to authenticate the user
     *
     * @param auth
     * @return
     * @throws AuthenticationException
     */
    @Override
    public Authentication authenticate(Authentication auth)  throws AuthenticationException {
        String username = auth.getName();
        String password = auth.getCredentials().toString();
        // to add more logic

        String url = env.getProperty("backendapi.rooturl") + "/dashaccount/user/login";


        try {

            RestTemplate restTemplate = new RestTemplate();

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

            Map<String, Object> map = new HashMap<>();
            map.put("username", username);
            map.put("password", password);

            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(map, headers);

            ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);
            List<GrantedAuthority> grantedAuths = new ArrayList<>();

            if (response.getStatusCode() == HttpStatus.OK) {
                String user = response.getBody();
                grantedAuths.add(new SimpleGrantedAuthority("ROLE_USER"));

                JSONParser parser = new JSONParser();
                JSONObject json = (JSONObject) parser.parse(user);

                UserModel userinfo = new UserModel();
                userinfo.setUsername((String) json.get("userName"));
                userinfo.setDisplayName((String) json.get("displayName"));


                long userid = (long) json.get("userID");
                userinfo.setUserID((int) userid);

                System.out.println(json);
                long vetid = (long) json.get("vetID");
                userinfo.setVetID((int) vetid);

                return new UsernamePasswordAuthenticationToken(userinfo, password, grantedAuths);

            }else{

                return null;
            }
        } catch (Exception e){

            return null;
        }


    }

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }

}
