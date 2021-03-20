package com.hellokoding.springboot.view.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class VeterinarianController {
    @Autowired
    private Environment env;
    @GetMapping("/veterinarian")
    public String veterinarian(Model model) {
        model.addAttribute("headerName","Veterinarian Listing");
        model.addAttribute("user", SecurityContextHolder.getContext().getAuthentication().getPrincipal());
        return "veterinarian";
    }


}
