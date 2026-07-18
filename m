Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1409384224
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784364076; cv=none; b=CY2aMdeGAS9SQNH5fOziqZMYIadT+yEzOzi2pXzNXhF+b2bS7aholJIGg7h49PSSSbBUGEeVZTHi8cJQSoP0WlGd4JmNtfLRIQqW2Hlbm7rEUQduc2aUDq6YNrwGBd9sKu7hDlJjA2WX51PCt71CWUDFhVxXgWE9hXcRH010Oj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784364076; c=relaxed/simple;
	bh=hFSK6D7f0JcEKML/iERi9216gS7fbuozE2tSvk31pdQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pVVG7jrfj3CJzQCObmEe0Yn6h4nUj6kvI3lcSWSedNGoF6facc3IwcKLZpKul5Hq3CrESDz8n55Ozp+Qkm9DXIXFn6KGU0GbJZIz1NX3QaRw5DIW73PPKdkeDgJou//1ziztSiFO7WLJx28VL2YGrHoC0w1ovJjuwZX+LyoHjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6a2a45e0828411f1aa26b74ffac11d73-20260718
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_MAILER_MTBG
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d8d6ad28-359b-4fa9-b376-c62b66bff9ff,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:d8d6ad28-359b-4fa9-b376-c62b66bff9ff,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:8397bf567ddfb5e54ebb975fe27d2524,BulkI
	D:260715215152RIZL4TBA,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6a2a45e0828411f1aa26b74ffac11d73-20260718
X-User: husong@kylinos.cn
Received: from [192.168.110.173] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1674339062; Sat, 18 Jul 2026 16:41:05 +0800
Message-ID: <04cc010d-5b8c-486d-b4d4-59cbe6dcab8b@kylinos.cn>
Date: Sat, 18 Jul 2026 16:40:51 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: husong@kylinos.cn, damon@lists.linux.dev
Subject: Re: Question on damon_sysfs_memcg_path_to_id() path resolution
To: SJ Park <sj@kernel.org>
References: <20260715135135.83926-1-sj@kernel.org>
From: Song Hu <husong@kylinos.cn>
In-Reply-To: <20260715135135.83926-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Sorry for the late reply.

在 2026/7/15 21:51, SJ Park 写道:
> On Wed, 15 Jul 2026 14:35:46 +0800 Song Hu <husong@kylinos.cn> wrote:
>
>> Hi SeongJae,
>>
>> I've been reading the memcg path->id resolution used by DAMOS filters
>> and quota goals, and I'd like to ask about a design choice before
>> suggesting any change.
> Thank you for asking this question!
>
>> damon_sysfs_memcg_path_to_id() (mm/damon/sysfs-common.c) resolves the
>> user-written cgroup path by iterating all memcgs with
>> mem_cgroup_iter() and comparing each one's cgroup_path() to the
>> target.  It could instead call cgroup_get_from_path() directly, but
>> the two don't resolve the path the same way:
>>
>>   - current code: cgroup_path(memcg->css.cgroup) is just kernfs_path(),
>>     i.e. the absolute path in the cgroup hierarchy, independent of the
>>     caller's cgroup namespace;
>>
>>   - cgroup_get_from_path(): resolves the path against
>>     current_cgns_cgroup_dfl(), i.e. relative to the caller's cgroup
>>     namespace.
> Today I learned cgroup_get_from_path() :)
>
> And it seems it will work for not only memcg but any cgroups?
>
>> So in a cgroup-namespaced (container) setup the two disagree: today
>> the lookup is absolute; switching to cgroup_get_from_path() would make
>> it namespace-relative.  On the host / init namespace they agree.
> If my above guess is correct, it may also differently work if the user gives
> non-memcg cgroup path.
>
>> I ask because the iteration has already needed one stable fix
>> (d4e7b5c4cc35, a missing mem_cgroup_iter_break() that leaked a cgroup
>> reference), and cgroup_get_from_path() is a matched get/put pair that
>> would avoid that whole class of mistake -- but only if the namespace
>> behavior change is acceptable.
>>
>> Is the absolute-path behavior intentional?  If namespace-relative
>> resolution is fine, I'm happy to send a patch (keeping the
>> mem_cgroup_online() skip).  If not, I'll leave it as is.
> It was not very intentional.  I just didn't think about container-inside DAMON
> use case.
>
> I find the current behavior might be tedious if the user runs DAMON inside
> cgroups.  Finding the absolute cgroup path inside containers might be
> challenging.  If that's the case, I'm up to change or extend the behaviors.
>
> If this is only for making the code easier to maintain, I don't really feel
> like it deserves the behavioral changes, to be honest.
I looked into the container case more carefully and I'm no longer sure
it justifies the change.

DAMON sysfs is root-only (state is 0600 under /sys/kernel/mm/damon), so
whoever configures a scheme is effectively a host-level operator.  That
operator can obtain the absolute cgroup path directly (e.g. from
/proc/<pid>/cgroup), and the usage docs already show host-absolute
paths.  A process able to write host DAMON sysfs from inside a non-init
cgroup namespace is a privileged host-admin case, not really a "DAMON
inside a container" user.  So I think the namespace-relative benefit is
marginal at best.

Given that, and your point that maintainability alone isn't worth a
behavioral change, I'll leave damon_sysfs_memcg_path_to_id() as-is.

Thanks for thinking it through with me -- and for the cgroup_get_from_path pointer.

Song
>
> Thanks,
> SJ
>
> [...]
