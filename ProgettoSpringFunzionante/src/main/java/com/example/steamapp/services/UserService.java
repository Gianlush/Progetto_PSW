package com.example.steamapp.services;

import com.example.steamapp.entities.User;
import com.example.steamapp.repositories.UserRepository;
import com.example.steamapp.utility.exceptions.EmailAlreadyUsedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;


    @Transactional
    public User registerUser(User user) {
        if(userRepository.existsByEmail(user.getEmail()))
            throw new EmailAlreadyUsedException();
        return userRepository.save(user);
    }

    @Transactional(readOnly = true)
    public List<User> showAllUsers(){
        return userRepository.findAll();
    }


    @Transactional(readOnly = true)
    public User showByEmail(String email){
        return userRepository.findByEmail(email);
    }


    @Transactional(readOnly = true)
    public List<User> showByName(String name){
        return userRepository.findByNameContaining(name);
    }



    @Transactional(readOnly = true)
    public List<User> showBySurname(String surname){
        return userRepository.findBySurnameContaining(surname);
    }
    

}
