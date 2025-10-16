package org.example.entities.enums;

public enum BloodGroup {
    O_NEG , O_POS , A_NEG , A_POS , B_NEG , B_POS , AB_NEG  , AB_POS ;

    public boolean canDonateTo(BloodGroup receiver) {
        switch (this) {
            case O_NEG:
                return true;
            case O_POS:
                return receiver == O_POS || receiver == A_POS || receiver == B_POS || receiver == AB_POS;
            case A_NEG:
                return receiver == A_NEG || receiver == A_POS || receiver == AB_NEG || receiver == AB_POS;
            case A_POS:
                return receiver == A_POS || receiver == AB_POS;
            case B_NEG:
                return receiver == B_NEG || receiver == B_POS || receiver == AB_NEG || receiver == AB_POS;
            case B_POS:
                return receiver == B_POS || receiver == AB_POS;
            case AB_NEG:
                return receiver == AB_NEG || receiver == AB_POS;
            case AB_POS:
                return receiver == AB_POS;
            default:
                return false;
        }
    }
}
