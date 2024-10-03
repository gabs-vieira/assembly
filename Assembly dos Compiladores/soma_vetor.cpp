int somaVetor(short vetor[], int elementos){
    int i, soma=0;
    for (i=0;i<elementos;i++) 
    soma += vetor[i];
    return soma;
}  

int main() {
    short vetor[5] = {1,2,3,4,5};
    int soma;
    soma = somaVetor(vetor,5) * 2;
    return 0;
}