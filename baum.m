function hmm = baum(hmm, samples)

mix  = hmm.mix;			%��˹���
N    = length(mix);		%HMM״̬��
K    = length(samples);	%����������
SIZE = size(samples(1).data,2); %��������

% ����ǰ��, ������ʾ���, ���Ƕ�۲����к���������
disp('������������...');
for k = 1:K
    fprintf('%d ',k)
	param(k) = getparam(hmm, samples(k).data);
end
fprintf('\n')

% �ع�ת�Ƹ��ʾ���A: trans
disp('�ع�ת�Ƹ��ʾ���A...')
for i = 1:N-1
	denom = 0;
	for k = 1:K
		tmp   = param(k).ksai(:,i,:);
		denom = denom + sum(tmp(:));
	end
	for j = i:i+1
		nom = 0;
		for k = 1:K
			tmp = param(k).ksai(:,i,j);
			nom = nom   + sum(tmp(:));
		end
		hmm.trans(i,j) = nom / denom;
	end
end

% �ع���ϸ�˹�Ĳ���
disp('�ع���ϸ�˹�Ĳ���...')
for l = 1:N
for j = 1:hmm.M(l)
	fprintf('%d,%d ',l,j)
	% �����pdf�ľ�ֵ�ͷ���
	nommean = zeros(1,SIZE); 
	nomvar  = zeros(1,SIZE); 
	denom   = 0;
	for k = 1:K
		T = size(samples(k).data,1);
		for t = 1:T
			x	    = samples(k).data(t,:);
			nommean = nommean + param(k).gama(t,l,j) * x;
			nomvar  = nomvar  + param(k).gama(t,l,j) * (x-mix(l).mean(j,:)).^2;
			denom   = denom   + param(k).gama(t,l,j);
		end
	end
	hmm.mix(l).mean(j,:) = nommean / denom;
	hmm.mix(l).var (j,:) = nomvar  / denom;

	% �����pdf��Ȩ
	nom   = 0;
	denom = 0;
	for k = 1:K
		tmp = param(k).gama(:,l,j);    nom   = nom   + sum(tmp(:));
		tmp = param(k).gama(:,l,:);    denom = denom + sum(tmp(:));
	end
	hmm.mix(l).weight(j) = nom/denom;
end
fprintf('\n')
end
