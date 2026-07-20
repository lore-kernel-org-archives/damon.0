Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330A3955F2
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518533; cv=none; b=ZH7a6H+46cMVKaQeTl8FvHEE2SgW062PBOrvqlLa0TBAVmvYYY22zd6JLPSirvj/dIPtpxfkEOAEWNXHLAswvFlJtVreswsLFZ414b8/d/0moTqMcOXt3UOFt8rcAnWpSqa1mcCaaFRMU2yRz/ggBpv+X33CVnQiyqbahnaVLcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518533; c=relaxed/simple;
	bh=PVwGgbaFErVBULWAHJ1uEWN6ONpo0G9W+hhiGI3F8Q8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yixig1B56bJOnSHSLP1+rxpzF1h/UN7TxxWnM7lotjwKsvsqQo3+3B/7eYP1sMnac+ZwtOeSOmbkZVgYW32B9LAIWAE/FpJRPqtne0Y0gf5jaynFdpqXq3rTF53OE5tNi6U1HSHmKFHkbctf5+0gMK1oA7mwiV79QNrA7J/cVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0bd0e53083ec11f1aa26b74ffac11d73-20260720
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_MAILER_MTBG
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3e8d85d7-5de1-4aac-8a39-40290ac4fc4a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:3e8d85d7-5de1-4aac-8a39-40290ac4fc4a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:ccfb1a5725bedc1e76e4be0ae6454898,BulkI
	D:260715215152RIZL4TBA,BulkQuantity:3,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0bd0e53083ec11f1aa26b74ffac11d73-20260720
X-User: husong@kylinos.cn
Received: from [192.168.110.173] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 720719478; Mon, 20 Jul 2026 11:35:25 +0800
Message-ID: <c4cf2558-0516-417e-affd-9a5550ff32f8@kylinos.cn>
Date: Mon, 20 Jul 2026 11:35:06 +0800
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
References: <20260718155952.26350-1-sj@kernel.org>
From: Song Hu <husong@kylinos.cn>
In-Reply-To: <20260718155952.26350-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/7/18 23:59, SJ Park 写道:
> On Sat, 18 Jul 2026 16:40:51 +0800 Song Hu <husong@kylinos.cn> wrote:
>
>> Hi,
>>
>> Sorry for the late reply.
> No worry!
>
> [...]
>>> I find the current behavior might be tedious if the user runs DAMON inside
>>> cgroups.  Finding the absolute cgroup path inside containers might be
>>> challenging.  If that's the case, I'm up to change or extend the behaviors.
>>>
>>> If this is only for making the code easier to maintain, I don't really feel
>>> like it deserves the behavioral changes, to be honest.
>> I looked into the container case more carefully and I'm no longer sure
>> it justifies the change.
>>
>> DAMON sysfs is root-only (state is 0600 under /sys/kernel/mm/damon), so
>> whoever configures a scheme is effectively a host-level operator.  That
>> operator can obtain the absolute cgroup path directly (e.g. from
>> /proc/<pid>/cgroup), and the usage docs already show host-absolute
>> paths.  A process able to write host DAMON sysfs from inside a non-init
>> cgroup namespace is a privileged host-admin case, not really a "DAMON
>> inside a container" user.  So I think the namespace-relative benefit is
>> marginal at best.
>>
>> Given that, and your point that maintainability alone isn't worth a
>> behavioral change, I'll leave damon_sysfs_memcg_path_to_id() as-is.
> Makes sense.
>
>> Thanks for thinking it through with me -- and for the cgroup_get_from_path pointer.
> You're welcome.  I liked this dicsussion.  Looking forward to the next one!
Following up on our last chat - thanks again for the cgroup_get_from_path
pointer, that settled it for me. One thing it got me thinking about, which
I'd like to get your read on before I write any code.

The only in-kernel PSI consumer today is DAMON, and it reads a single
system-wide value - psi_system.total for memory (mm/damon/core.c,
damos_get_some_mem_psi_total). There is no reusable in-kernel helper that
returns per-cgroup, multi-domain (cpu/mem/io x some/full) pressure as a
value (psi_show is a seq_file printer for the /proc and cgroup files, not a
value-returning API), and no in-kernel threshold-trigger (psi_trigger_create
is userspace-fd only).

I'm writing a node-level multi-domain (cpu + memory + io) resource
coordinator for container/Kubernetes nodes - a small C daemon using libbpf
plus PSI trigger fds. To attribute pressure to specific cgroups and act
across domains it needs per-cgroup, per-domain PSI, which today means
open-coding reads of cgroup_psi(cgrp)->total[] the way DAMON does in-kernel.
And I think DAMON's own per-memcg DAMOS quota goals would benefit from the
same per-cgroup read if it existed.

So the idea is a small helper, e.g.

  /* per-cgroup, per-domain pressure; reuses update_averages() */
  u64 psi_cgroup_total(struct cgroup *cgrp, enum psi_res res, bool some);
  /* and/or an avg10/60/300 variant */

with DAMON migrated to it as the first in-tree user.

Before I do anything: does this capability gap resonate with you - is
per-cgroup PSI consumption something you'd want DAMON to grow into, or do
you see it staying userspace-only? And if a helper makes sense, any
preferred shape, or concerns about exposing the averaging/locking contract?
I'd keep the first cut to just the read helper + DAMON migration; an
in-kernel trigger callback I'd treat as a separate, later step and only if
there's a second consumer.

Thanks,
Song
>
> Thanks,
> SJ
>
> [...]
