package com.example.steamapp.entities;


import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import javax.persistence.*;

@Getter
@Setter
@EqualsAndHashCode
@ToString
@Entity
@Table(name = "game_per_purchase", schema = "my_database")

public class GamePerOrder {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;


    @Basic
    @Column(name = "quantity")
    private int quantity;


    @ManyToOne
    @ToString.Exclude
    @JsonIgnore
    @JoinColumn(name = "purchase")
    private Purchase purchase;


    @ManyToOne
    @JoinColumn(name = "game")
    private Game game;
}
