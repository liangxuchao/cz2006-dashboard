package com.hellokoding.springboot.view.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
/**
 * Controller handle for access pages related to veterinarian
 */
@Controller
public class VeterController {
    @Autowired
    private Environment env;

    /**
     * This method is end point for view veterinarian listing page
     *
     * @param model
     * @return The web view for view veterinarian listing page
     */
    @GetMapping("/veter")
    public String veterinarian(Model model) {
        model.addAttribute("headerName","Veterinarian Listing");
        model.addAttribute("apirooturl",env.getProperty("backendapi.rooturl"));
        model.addAttribute("user", SecurityContextHolder.getContext().getAuthentication().getPrincipal());
        return "veterinarian";
    }




}
