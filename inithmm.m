function hmm = inithmm(samples, M)

K = length(samples);	%����������
N = length(M);          %״̬��
hmm.N = N;
hmm.M = M;

% ��ʼ���ʾ���
hmm.init    = zeros(N,1);
hmm.init(1) = 1;

% ת�Ƹ��ʾ���
hmm.trans=zeros(N,N);
for i=1:N-1
	hmm.trans(i,i)   = 0.5;
	hmm.trans(i,i+1) = 0.5;
end
hmm.trans(N,N) = 1;

% �����ܶȺ����ĳ�ʼ����
% ƽ���ֶ�
for k = 1:K
	T = size(samples(k).data,1);
	samples(k).segment = floor([1:T/N:T T+1]);
end

% ������ÿ��״̬����������K��ֵ����,�õ����������̬�ֲ�
for i = 1:N
	%����ͬ�������ͬ״̬��������ϵ�һ��������
	vector = [];
	for k = 1:K
		seg1 = samples(k).segment(i);
		seg2 = samples(k).segment(i+1)-1;
		vector = [vector ; samples(k).data(seg1:seg2,:)];
	end
	mix(i) = getmix(vector, M(i));
end

hmm.mix = mix;
