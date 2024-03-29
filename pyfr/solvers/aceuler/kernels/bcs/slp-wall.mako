<%namespace module='pyfr.backends.base.makoutil' name='pyfr'/>

<%pyfr:macro name='bc_rsolve_state' params='ul, nl, ur'>
    fpdtype_t nor = ${' + '.join(f'nl[{i}]*ul[{i + 1}]' for i in range(ndims))};
    ur[0] = ul[0];
% for i in range(ndims):
    ur[${i + 1}] = ul[${i + 1}] - 2*nor*nl[${i}];
% endfor
</%pyfr:macro>
