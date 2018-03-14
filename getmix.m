function mix = getmix(vector, M)

% kmeans���÷����ڰ汾�ϵĲ��죿
% [mean esq nn] = kmeans(vector,M); ����÷��Ǵ����
[nn mean esq] = kmeans(vector,M);

% ����ÿ������ı�׼��, �Խ���, ֻ����Խ����ϵ�Ԫ��
for j = 1:M
	ind = find(j == nn);
	tmp = vector(ind,:);
	var(j,:) = std(tmp);
end

% ����ÿ�������е�Ԫ����, ��һ��Ϊ��pdf��Ȩ��
weight = zeros(M,1);
for j = 1:M
	weight(j) = sum(find(j==nn));
end
weight = weight/sum(weight);

% ������
mix.M      = M;
mix.mean   = mean;		% M*SIZE
mix.var    = var.^2;	% M*SIZE
mix.weight = weight;	% M*1
