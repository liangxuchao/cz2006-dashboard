package com.hellokoding.springboot.view.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class AccountController {
    @GetMapping("/login")
    public String login(Model model) {

        model.addAttribute("headerName","Login");

        return "login";
    }


    @PostMapping("/register")
    public String register(Model model) {

        model.addAttribute("headerName","Login");
        return "register";
    }


}
