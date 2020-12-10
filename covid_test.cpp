#include <iostream>
#include <stdio.h>
using namespace std;
const long long datasize=50000000;
bool samples[datasize];
int remaining_samples[datasize]; // stores indices of the samples which have not been eliminated yet. A sample is eliminated if it is guaranteed to be negative.
int unshuffled_remaining_samples[datasize];
int num_remaining_samples = datasize;
    
void datagen(float prob){
    for (int i=0;i<datasize;i++){
        samples[i]=false;
        remaining_samples[i] = i;
    }
    int index;
    for (int j=0;j<datasize*prob;j++){
        float r = static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
        index = static_cast <int> (r*datasize);
        samples[index] = true;
    }
}

void count_positives(){
    int num = 0;
    for (int i=0;i<num_remaining_samples;i++){
        if (samples[remaining_samples[i]]){
            num++;
        }
    }
    cout<< "Num +ves remaining is "<< num<< endl;
}
void count_unshuffled_positives(){
    int num = 0;
    for (int i=0;i<num_remaining_samples;i++){
        if (samples[unshuffled_remaining_samples[i]]){
            num++;
        }
    }
    cout<< "Num +ves remaining is "<< num<< endl;
}

int optimal_set_size(float prob){
    //For a given probability of positive test in 1 sample, gives the set size that has 50% probability of containing atleast 1 positive 
    float full_prob = 1;
    int set_size = 0;
    while(full_prob>0.5){
        full_prob*=(1-prob);
        set_size+=1;
    }
    if (set_size>1){
        set_size-=1;  // This gives marginally better result
    }
    cout<< "For prob "<< prob<< ", optimal set_size is "<< set_size<< endl;; 
    return set_size;
}

int num_tests_done = 0;
int run_test(int start_index, int end_index){
    num_tests_done++;
    for (int i=start_index;i<end_index;i++){
        if (samples[remaining_samples[i]]){
            // cout<< "Positive at "<< remaining_samples[i]<< endl;
            return true;
        }
    }
    return false;
}
int minimum(int a, int b){
    if (a<b){
        return a;
    }
    // cout<< "minimum of "<<a<<" "<< b<< " is "<< b;
    return b;
}

int main(){
    float prob = 0.001;
    datagen(prob);
    int expected_positives = prob*datasize;  //approximate expected number of positives. Used to calculate probailities later
    
    count_positives();
    float curr_prob = prob;
    int set_size=693;
    int start_index, end_index;
    bool shuffle = true;
    while(set_size>1){
        // We do tests on sets and throw away sets with no positives. 
        // We keep testing on smaller sets till we have tested on sets with size 1.
        // We dont just split sets in half. 
        // Instead, we put all remaining data in an array and find a new optimal set_size to eliminate half of total data for next iteration
        curr_prob = static_cast<float>(expected_positives)/static_cast<float>(num_remaining_samples);
        // cout<< "Current probability is "<< curr_prob<< endl;
        set_size = optimal_set_size(curr_prob);
        int num_remaining_sets = 0;
        int copy_index=0;
        for (int i=0;i*set_size<num_remaining_samples;i++){
            // set from data index start_index to end_index
            start_index = i*set_size;
            end_index = minimum((i+1)*set_size, num_remaining_samples);
            if (run_test(start_index, end_index)){
                num_remaining_sets++;
                for (int j=0; j<end_index-start_index; j++){
                    unshuffled_remaining_samples[copy_index+j] = remaining_samples[start_index+j];
                }
                copy_index+=end_index-start_index;
            }
        }
        num_remaining_samples = copy_index;
        cout<<endl << "Remaining num samples is "<< num_remaining_samples<< endl;
        // count_unshuffled_positives();
        // Next, we shuffle/distribute data order. If we dont shuffle, data is evenly spread out through our array-NOT RANDOMLY SPREAD. 
        // so every consecutive chunk of data is more likely to contain atleast 1 +ve compared to a randomly chosen set of same size. 
        // This makes the probability of positive>50%
        // Result improves by shuffling
        if (shuffle){ 
            copy_index = 0;
            for (int j=0; (j<set_size); j++){
                for (int i=0; (i<num_remaining_sets) || (i*set_size+j<num_remaining_samples); i++){
                    remaining_samples[copy_index] = unshuffled_remaining_samples[i*set_size+j];
                    // cout<<i*set_size+j<< " ";
                    copy_index++;
                }
            }
        }
        else{
            copy_index = 0;
            for (int i=0; i<num_remaining_samples; i++){
                remaining_samples[copy_index] = unshuffled_remaining_samples[copy_index];
                // cout<<i*set_size+j<< " ";
                copy_index++;
            }
            
        }
    }
    cout<< "Total num tests is "<< num_tests_done<< endl;
    // cout<< "Remaining num samples is "<< num_remaining_samples<< endl;
}
