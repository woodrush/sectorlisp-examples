def isMandel(z_r, z_i, c_r, c_i, N_iter):
    if N_iter == 0:
        return True
    elif z_r * z_r + z_i * z_i > 4:
        return False
    else:
        return isMandel(
            z_r*z_r - z_i*z_i + c_r,
            2 * z_r * z_i + c_i,
            c_r, c_i, N_iter-1)

N_plotsize = 8
N_iter = 4
delta_r = 1.0/N_plotsize
delta_i = 2.0/N_plotsize
c_i = -1.25
while c_i <= 1.25:
    c_r = -2.25
    while c_r <= 0.5:
        z_r = 0
        z_i = 0

        if isMandel(z_r, z_i, c_r, c_i, N_iter):
            print("*", end="")
        else:
            print(" ", end="")
        c_r += delta_r
    print()
    c_i += delta_i
