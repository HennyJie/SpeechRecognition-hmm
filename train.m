function [hmm, pout] = train(samples, M)
%����:
%  samples -- �����ṹ
%  M       -- Ϊÿ��״ָ̬��pdf����
%���:
%  hmm     -- ѵ����ɺ��hmm

K   = length(samples);

% ������������
disp('���ڼ�����������');
for k = 1:K
	if isfield(samples(k),'data') && ~isempty(samples(k).data)
		continue;
	else
		samples(k).data = mfcc(samples(k).wave);
	end
end

% ��ʼ��hmm
hmm = inithmm(samples, M);

for loop = 1:40
	fprintf('\n��%d��ѵ��\n\n',loop)
	hmm = baum(hmm, samples);

	%�������������
	pout(loop)=0;
	for k = 1:K
		pout(loop) = pout(loop) + viterbi(hmm, samples(k).data);
	end

	fprintf('�ܺ��������(log)=%d\n', pout(loop))

	%�Ƚ�����HMM�ľ���
	if loop>1
		if abs((pout(loop)-pout(loop-1))/pout(loop)) < 5e-6
			fprintf('����!\n');
			return
		end
	end
end

disp('����40���Բ�����, �˳�');
