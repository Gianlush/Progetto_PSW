package com.example.steamapp.controllers;

import com.example.steamapp.entities.Purchase;
import com.example.steamapp.entities.User;
import com.example.steamapp.services.PurchaseService;
import com.example.steamapp.utility.exceptions.GameUnavailableException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/orders")
public class PurchaseController {

    @Autowired
    private PurchaseService purchaseService;


    @PostMapping
    public ResponseEntity create(@RequestBody @Valid Purchase purchase){
        try {
            Purchase result = purchaseService.addOrder(purchase);
            return new ResponseEntity(result, HttpStatus.OK);
        } catch (GameUnavailableException e) {
            return new ResponseEntity("ERROR_GAME_NOT_AVAILABLE", HttpStatus.BAD_REQUEST);
        }
    }


    @GetMapping
    public List<Purchase> getByUser(@RequestParam User user){
        List<Purchase> x = purchaseService.showOrderByUser(user);
        return purchaseService.showOrderByUser(user);
    }


    @GetMapping("/{start}/{end}")
    public List<Purchase> getByUserInPeriod(@RequestBody @Valid User user, @PathVariable @DateTimeFormat(pattern = "dd-MM-yyyy") Date start, @PathVariable @DateTimeFormat(pattern = "dd-MM-yyyy") Date end){
        return purchaseService.showOrderByUserInPeriod(start,end,user);
    }

}
