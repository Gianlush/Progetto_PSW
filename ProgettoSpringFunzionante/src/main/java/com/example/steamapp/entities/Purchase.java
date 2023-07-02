package com.example.steamapp.entities;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.CreationTimestamp;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

@Getter
@Setter
@EqualsAndHashCode
@ToString
@Entity
@Table(name = "purchase", schema = "my_database")

public class Purchase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;


    @ManyToOne
    @JoinColumn(name = "user")
    private User user;


    @Basic
    @CreationTimestamp
    @JsonFormat(pattern = "yyyy-MM-dd-HH-mm")
    @Column(name = "shop_date")
    private Date shopDate;


    @Basic
    @Column(name = "payment_method")
    private String paymentMethod;

    @Basic
    @Column(name = "total")
    private float total;

    @OneToMany(mappedBy = "purchase")
    private List<GamePerOrder> gamePerOrder;

}
