def mandelstep(z_r, z_i, c_r, c_i):
    z_r_new = z_r*z_r - z_i*z_i + c_r
    z_i_new = 2 * z_r * z_i + c_i
    return z_r_new, z_i_new

def isMandel(z_r, z_i, c_r, c_i, N_iter):
    if N_iter == 0:
        return True
    elif z_r * z_r + z_i * z_i > 4:
        return False
    else:
        return isMandel(*mandelstep(z_r, z_i, c_r, c_i), c_r, c_i, N_iter-1)

N_plotsize = 4
N_iter = 4
for i in range(1,N_plotsize):
    for j in range(1,N_plotsize):
        c_r = -3.0 + 4.0/N_plotsize*i
        c_i = -1.0 + 2.0/N_plotsize*j

        z_r = 0
        z_i = 0

        if isMandel(z_r, z_i, c_r, c_i, N_iter):
            print("*", end="")
        else:
            print(" ", end="")
    print()
