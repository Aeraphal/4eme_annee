#include <iostream>
#include <string>
#include <list>

using std::string;
using std::cout;
using std::endl;

struct Conteneur
{
    int N;
    string M;
    void affiche()
    {
        cout<<"Je contiens l'entier "<<N<<" et le mot "<<M<<"."<<endl;
    }
};

struct Personne
{
    string Nom;
    string Prenom;
    int Note;
    Personne()
    {
        Nom="Inconnu";Prenom="Inconnu";Note=0;
    }
    Personne(string V_Nom, string V_Prenom):Nom(V_Nom),Prenom(V_Prenom)
    {
        // Nom=V_Nom;Prenom=V_Prenom;
    }

};

struct Etudiant : public Personne
{
    int Note;
    Etudiant(string Nom, string Prenom, int V_Note) : Personne(Nom, Prenom),Note(V_Note){}
    int V_Note() const {return Note;}
};

void denomer(const Personne& p)
{
    cout<<p.Nom<<" "<<p.Prenom<<" "<<endl; 
} 

void denomer(const Etudiant& p)
{
    cout<<p.Nom<<" "<<p.Prenom<<" "<<p.V_Note()<<endl; 
} 

int main()
{
    Etudiant A("Franck","Ribery",2);
    Etudiant B("Einstein","Albert",18);
    Etudiant C("Huster","Francis", 5);
    std::list<Etudiant> L;
    L.push_back(A);
    L.push_front(B);
    L.push_front(C);
    for(const Etudiant& p : L)
        denomer(p);  
    return 0;
}
