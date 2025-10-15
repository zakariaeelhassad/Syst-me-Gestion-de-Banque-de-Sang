package org.example.entities.models;

import entities.enums.ReceiverPriority;
import entities.enums.ReceiverState;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "receveurs")
public class Receveur extends Person {

    @NotNull
    @Column(name = "besoin_poches", nullable = false)
    private Integer besoinPoches;

    @Enumerated(EnumType.STRING)
    @Column(name = "receiver_priority", nullable = false)
    private ReceiverPriority receiverPriority;

    @Enumerated(EnumType.STRING)
    @Column(name = "receiver_state", nullable = false)
    private ReceiverState receiverState;
}
