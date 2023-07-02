package com.example.steamapp.services;

import com.example.steamapp.entities.Game;
import com.example.steamapp.entities.GamePerOrder;
import com.example.steamapp.entities.Purchase;
import com.example.steamapp.entities.User;
import com.example.steamapp.repositories.GamePerOrderRepository;
import com.example.steamapp.repositories.PurchaseRepository;
import com.example.steamapp.utility.exceptions.GameUnavailableException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.util.Date;
import java.util.List;

@Service
public class PurchaseService {

    @Autowired
    private PurchaseRepository purchaseRepository;

    @Autowired
    private GamePerOrderRepository gamePerOrderRepository;

    @Autowired
    private EntityManager entityManager;


    @Transactional
    public Purchase addOrder(Purchase purchase)  {
        Purchase insert = purchaseRepository.save(purchase);
        float total = 0;
        for(GamePerOrder x : insert.getGamePerOrder()){
            x.setPurchase(insert);
            GamePerOrder justAdded = gamePerOrderRepository.save(x);
            entityManager.refresh(justAdded);
            Game game = justAdded.getGame();
            int newQuantity = game.getQuantity() - x.getQuantity();
            if(newQuantity < 0)
                throw new GameUnavailableException();
            game.setQuantity(newQuantity);
            total+=game.getPrice();
        }
        entityManager.refresh(insert);
        insert.setTotal(total);
        return insert;
    }


    @Transactional(readOnly = true)
    public List<Purchase> showOrderByUser(User user){
        return purchaseRepository.findByUserOrderByShopDateDesc(user);
    }



    @Transactional(readOnly = true)
    public List<Purchase> showOrderByUserInPeriod(Date start, Date end, User user){
        return purchaseRepository.findByUserInPeriod(start,end,user);
    }

}
