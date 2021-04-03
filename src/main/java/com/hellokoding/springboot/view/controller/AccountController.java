package com.hellokoding.springboot.view.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * Controller handle for access pages related to account
 */
@Controller
public class AccountController {
    /**
     * This Method is end point for login page
     *
     * @param model Store values to return in page
     * @return The web view for login page
     */
    @GetMapping("/login")
    public String login(Model model) {

        model.addAttribute("headerName","Login");

        return "login";
    }



}
