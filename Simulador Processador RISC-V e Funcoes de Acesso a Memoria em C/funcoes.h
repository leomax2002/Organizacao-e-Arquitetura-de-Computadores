#ifndef FUNCOES_H_INCLUDED
#define FUNCOES_H_INCLUDED

#include <stdint.h>
#include <stdio.h>

#define Num_reg 32

int32_t R[Num_reg];

void add(rs1,rs2,rd){
    if (rd != ZERO){
    R[rd] = R[rs1] + R[rs2];
    }
}

void addi(rs1,imm,rd){
    if(rd != ZERO){
    R[rd] = R[rs1] + imm;
    }

}

void and(rs1,rs2,rd){
    if (rd != ZERO){
    R[rd] = R[rs1] & R[rs2];
    }
}

void andi(rs1,imm,rd){
   if (rd != ZERO){
    R[rd] = R[rs1] & imm;
   }
}
//Observação: AUIPC Não altera o PC e nunca interrompe o fluxo de controle
void auipc(PC,imm,rd){
    if (rd != ZERO){
    R[rd] = PC + imm;
    }
}

void beq(rs1,rs2,PC,imm){
    if(R[rs1] == R[rs2]){
        pc = PC + imm;
    }
}

void bne(rs1,rs2,PC,imm){
    if(R[rs1] != R[rs2]){
        pc = PC + imm;
    }
}

void bge(rs1,rs2,PC,imm){
    if(R[rs1] >= R[rs2]){
        pc = PC + imm;
    }
}

void bgeu(rs1,rs2,PC,imm){
    if((uint32_t)R[rs1] >= (uint32_t)R[rs2]){
        pc = PC + imm;
    }
}

void blt(rs1,rs2,PC,imm){
    if(R[rs1] < R[rs2]){
        pc = PC + imm;
    }

}

void bltu(rs1,rs2,PC,imm){
    if((uint32_t)R[rs1] < (uint32_t)R[rs2]){
        pc = PC + imm;
    }
}

void jal(PC,imm,rd){
    if (rd != ZERO){
    R[rd] = PC + 4;
    }
    pc = PC + imm;
}

void jalr(rs1,PC,imm,rd){
    if (rd != ZERO){
    R[rd] = PC + 4;
    }
    pc = R[rs1] + imm;
}

void or(rs1,rs2,rd){
   if (rd != ZERO){
    R[rd] = R[rs1] | R[rs2];
   }
}

void lui(imm,rd){
   R[rd] = imm;
}

void slt(rs1,rs2,rd){
    if (rd != ZERO){
    R[rd] = (R[rs1] < R[rs2]) ? 1:0;
    }
}

void sltu(rs1,rs2,rd){
   if (rd != ZERO){
    R[rd] = ((uint32_t)R[rs1] < (uint32_t)R[rs2]) ? 1:0;
   }
}

void ori(rs1,imm,rd){
   if (rd != ZERO){
    R[rd] = R[rs1] | imm;
   }
}

void slli(rs1,imm,rd){
    if (rd != ZERO){
    R[rd] = R[rs1] << imm;
    }
}

void srai(rs1,imm,rd){
    if (rd != ZERO){
    R[rd] = R[rs1] >> imm;
    }
}

void srli(rs1,imm,rd){
    uint32_t aux = (uint32_t) R[rs1];
    if (rd != ZERO){
    R[rd] = aux >> imm;
    }
}

void sub(rs1,rs2,rd){
    if (rd != ZERO){
    R[rd] = R[rs1] - R[rs2];
    }
}

void xor(rs1,rs2,rd){
    if (rd != ZERO){
    R[rd] = R[rs1]^R[rs2];
    }
}

void ecall(A0,A7){
   int32_t auxmem = R[A0];

    int32_t aux_ecall = R[A7];
    char aux2;
    if(aux_ecall == 1){
        printf("%d",R[A0]);
    }
    else if(aux_ecall == 4){
        for(int32_t i = 0; lb(auxmem,i) != 0; i++){
            aux2 = (char)lb(auxmem,i);
            printf("%c", aux2);
    }
    }
    else if(aux_ecall == 10){
        stop_prg = 1;
        return stop_prg;
    }
}
#endif // FUNCOES_H_INCLUDED
