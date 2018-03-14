function prob = mixture(mix, x)
%�����������
%����:
%  mix  -- ��ϸ�˹�ṹ
%  x    -- ��������, SIZE*1
%���:
%  prob -- �������

prob = 0;
for j = 1:mix.M
	m = mix.mean(j,:);
	v = mix.var (j,:);
	w = mix.weight(j);
	prob = prob + w * pdf(m, v, x);
end

% ����realmin, �Է�ֹviterbi.m�м���log(prob)ʱ���
if prob==0, prob=realmin; end
