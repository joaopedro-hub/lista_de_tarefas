/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import Model.Tarefa;
import Repository.TarefaRepository;

/**
 *
 * @author joaopedro
 */
public class TarefaService {
    
    private TarefaRepository rep = new TarefaRepository();
    
    public void markAsDone(Tarefa tarefa){
        
        for(Tarefa t : rep.read()){
            if(t.getId().intValue() == tarefa.getId().intValue()){
                t.setDone(true);
                break;
            }
        }
    }
    
    public void markAsNotDone(Tarefa tarefa){
        for(Tarefa t : rep.read()){
            if(t.getId().intValue() == tarefa.getId().intValue()){
                t.setDone(false);
                break;
            }
        }
    }
}
