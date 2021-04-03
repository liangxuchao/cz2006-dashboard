package com.hellokoding.springboot.view.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
/**
 * Controller handle for access pages related to appointment
 */
@Controller
public class AppointmentController {

    @Autowired
    private Environment env;

    /**
     * This method is end point for view appointment listin page
     *
     * @param request
     * @param model Store values to return in page
     * @return The web view for appointment page
     */
    @GetMapping("/appointment")
    public String dashboard( HttpServletRequest request,Model model) {
        model.addAttribute("headerName","Appointment Listing");
        model.addAttribute("apirooturl",env.getProperty("backendapi.rooturl"));
        model.addAttribute("user",SecurityContextHolder.getContext().getAuthentication().getPrincipal());
        return "appointment";
    }



}
