
import time
import numpy
from bokeh.plotting import figure
from bokeh.io import show, output_file
import MyProducts


verbose=False
sanity_check=True
# List for storing the sizes. Initially empty
sizes=[]
# A list with three empty lists for storing the running times
running_times=( [], [], [] )
#
size_step=1000
repetitions=100
for s in range( size_step, repetitions*size_step+size_step, size_step ):
    print( "Input size %6d" % s )
    # Creates a two random arrays
    v1 = numpy.random.randn( s )
    v2 = numpy.random.randn( s )
    # Converts them to a Python list
    l1 = v1.tolist()
    l2 = v2.tolist()

    # Measures the running time for scalar product of lists
    t1 = time.time()
    sp1 = MyProducts.vector_vector_product( l1, l2 )
    t1 = time.time()-t1

    # Measures the running time for scalar product of vectors
    t2 = time.time()
    sp2 = MyProducts.vector_vector_product( v1, v2 )
    t2 = time.time()-t2

    # Measures the running time for scalar product with numpy
    sp3 = v1.dot(v2)
    t3 = time.time()
    sp3 = v1.dot(v2)
    t3 = time.time()-t3

    # Appends the size and the running times
    sizes.append( s )
    running_times[0].append( t1 )
    running_times[1].append( t2 )
    running_times[2].append( t3 )
    if verbose  and  s < 20 :
        print( v1 )
        print( v2 )
        print( v3 )
    if sanity_check :
        if abs(sp1 - sp2) > 10e-4 :
            print( sp1, sp2, sp3 )
            raise Exception( 'Results of scalar products 1 and 2 differ' )
        if abs(sp3 - sp2) > 10e-4 :
            print( sp1, sp2, sp3 )
            raise Exception( 'Results of scalar products 2 and 3 differ' )
        if abs(sp1 - sp3) > 10e-4 :
            print( sp1, sp2, sp3 )
            raise Exception( 'Results of scalar products 1 and 3 differ' )


output_file( 'scalar_product_plot.html' )

fig = figure( title='Comparative of running times',
              plot_width=1000, plot_height=800,
              x_axis_label='Input size',
              y_axis_label='Running time in seconds' )

lw=1
# Trivial sort, the slowest one
fig.line( sizes, running_times[0], color='red', line_width=lw )
fig.circle( sizes, running_times[0], line_color='red', fill_color='white', size=10, legend='Selection sort - pure Python code' )

# Trivial sort using 'argmin()' of Numpy
fig.line( sizes, running_times[1], color='green', line_width=lw )
fig.diamond( sizes, running_times[1], line_color='green', fill_color='white', size=10, legend='Selection sort - combined with Numpy' )

# Efficient sort algorithm -- QuickSort or MergeSort
fig.line( sizes, running_times[2], color='blue', line_width=lw )
fig.triangle( sizes, running_times[2], line_color='blue', fill_color='white', size=10, legend='Efficient sort algorithm by Numpy' )

fig.legend.location='top_left'

show(fig)
