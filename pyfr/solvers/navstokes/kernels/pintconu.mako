<%inherit file='base'/>
<%namespace module='pyfr.backends.base.makoutil' name='pyfr'/>

<%include file='pyfr.solvers.euler.kernels.rotate'/>

<%pyfr:kernel name='pintconu' ndim='1'
              ulin='in view fpdtype_t[${str(nvars)}]'
              urin='in view fpdtype_t[${str(nvars)}]'
              ulout='out view fpdtype_t[${str(nvars)}]'
              urout='out view fpdtype_t[${str(nvars)}]'
              nl='in fpdtype_t[${str(ndims)}]'
              nr='in fpdtype_t[${str(ndims)}]'>

    fpdtype_t mag_n = sqrt(${pyfr.dot('nl[{i}]', i=ndims)});
    fpdtype_t norm_nl[] = ${pyfr.array('(1 / mag_n)*nl[{i}]', i=ndims)};
    fpdtype_t negnorm_nr[] = ${pyfr.array('-(1 / mag_n)*nr[{i}]', i=ndims)};


    // ----- Assumes c['ldg-beta'] == 0.5 -----
    fpdtype_t tmpu[${nvars}];
    % for i in range(nvars):
    tmpu[${i}] = urin[${i}];
    % endfor
    ${pyfr.expand('rotate', 'tmpu', 'negnorm_nr', 'norm_nl')};
    % for i in range(nvars):
    ulout[${i}] = urin[${i}];
    % endfor
    // ----------------------------------------

</%pyfr:kernel>
