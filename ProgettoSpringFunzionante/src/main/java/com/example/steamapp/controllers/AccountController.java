package com.example.steamapp.controllers;

import com.example.steamapp.utility.exceptions.EmailAlreadyUsedException;
import org.springframework.http.*;
import com.example.steamapp.entities.User;
import com.example.steamapp.services.UserService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.persistence.Version;
import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/users")
public class AccountController {

    @Autowired
    private UserService userService;


    @PostMapping
    public ResponseEntity create(@RequestBody @Valid User user){
        try {
            User result = userService.registerUser(user);
            return new ResponseEntity(result, HttpStatus.OK);
        } catch (EmailAlreadyUsedException e) {
            return new ResponseEntity("ERROR_MAIL_ALREADY_EXIST",HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping()
    public List<User> getAll() {
        return userService.showAllUsers();
    }


    @PostMapping("/name")
    public List<User> getByName(@RequestBody User user){
        return userService.showByName(user.getName());
    }


    @PostMapping("/surname")
    public List<User> getBySurname(@RequestBody User user){
        return userService.showBySurname(user.getSurname());
    }


    @PostMapping("/email")
    public User getByEmail(@RequestBody User user){
        return userService.showByEmail(user.getEmail());
    }

}
