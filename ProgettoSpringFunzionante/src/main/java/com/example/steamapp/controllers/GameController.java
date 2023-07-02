package com.example.steamapp.controllers;


import com.example.steamapp.entities.Game;
import com.example.steamapp.services.GameService;
import com.example.steamapp.utility.exceptions.GameAlreadyExistException;
import com.example.steamapp.utility.exceptions.GameNotExistingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/games")
public class GameController {

    @Autowired
    private GameService gameService;


    @PostMapping("/new")
    public ResponseEntity create(@RequestBody @Valid Game game){
        try {
            Game result = gameService.addGame(game);
            return new ResponseEntity(result, HttpStatus.OK);
        } catch (GameAlreadyExistException e) {
            return new ResponseEntity("ERROR_GAME_ALREADY_EXIST",HttpStatus.BAD_REQUEST);
        }
    }


    @GetMapping("/restock")
    public ResponseEntity update(@RequestParam String name, @RequestParam int quantity){
        try {
            Game result = gameService.restockGame(name,quantity);
            return new ResponseEntity(result,HttpStatus.OK);
        } catch (GameNotExistingException e) {
            return new ResponseEntity("ERROR_GAME_NOT_EXIST",HttpStatus.BAD_REQUEST);
        }
    }


    @GetMapping("/name")
    public List<Game> getByName(@RequestParam String name, @RequestParam int pageNumber, @RequestParam int pageSize, @RequestParam String sortBy){
        return gameService.showAllByNameContaining(name,pageNumber,pageSize,sortBy);
    }

    @GetMapping("/genre")
    public List<Game> getByGenre(@RequestParam String genre, @RequestParam int pageNumber, @RequestParam int pageSize, @RequestParam String sortBy){
        return gameService.showGameByGenreContaining(genre,pageNumber,pageSize,sortBy);
    }


    @GetMapping("/{pageNumber}/{pageSize}/{sortBy}")
    public List<Game> getAllGames(@PathVariable int pageNumber, @PathVariable int pageSize, @PathVariable String sortBy){
        return gameService.showAllGames(pageNumber,pageSize,sortBy);
    }

}
