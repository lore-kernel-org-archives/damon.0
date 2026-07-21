Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0EC2FE042
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599405; cv=none; b=NX0+F26gTipvwiz7KdaJrYMVj9n10IFi8w5Lq4od8VYjyD5vZGfp6jPq/SV/m07WKuzx4NT5BBm1vpplIH3xkbmlUTO3QSvTmQDuqeK+cN0eQuNg926xWYaUYOu78UMZwGhLSqxSagl/fxqb8q3v1c9nZSwKQ6G81+q0VttGz4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599405; c=relaxed/simple;
	bh=ptwObekv69lta6ruPinm/B3emBKdwAfsmzZeYwCqmI4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kaGD8onVTMrDHC8EjF6lv6GdB0Tsv+YrGq+Nc4WX0xUolqbMheD7huzRIGP2/zAyQSqQPiRncvLbxNEmxvpFiQUuLN0q1M5S1dKHNHSJQvjZ7AyrHGg4pADG+yelfV7A8+ehvA6fPEQhrgfIj/7+9xRFBjdwQpubocnVJqRXWXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 52b033c284a811f1aa26b74ffac11d73-20260721
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_MAILER_MTBG
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c335fe39-cf64-4aeb-abe3-4702b09d22ee,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-INFO: VERSION:1.3.12,REQID:c335fe39-cf64-4aeb-abe3-4702b09d22ee,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:ec53d135517f570b41070649f85342cd,BulkI
	D:260715215152RIZL4TBA,BulkQuantity:5,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 52b033c284a811f1aa26b74ffac11d73-20260721
X-User: husong@kylinos.cn
Received: from [192.168.110.173] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1515997216; Tue, 21 Jul 2026 10:03:10 +0800
Message-ID: <2bde5778-532e-4970-a2fa-526a7d4de7aa@kylinos.cn>
Date: Tue, 21 Jul 2026 10:03:07 +0800
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
References: <20260720151143.83277-1-sj@kernel.org>
From: Song Hu <husong@kylinos.cn>
In-Reply-To: <20260720151143.83277-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/7/20 23:11, SJ Park 写道:
> On Mon, 20 Jul 2026 11:35:06 +0800 Song Hu <husong@kylinos.cn> wrote:
>
> [...]
>> The only in-kernel PSI consumer today is DAMON, and it reads a single
>> system-wide value - psi_system.total for memory (mm/damon/core.c,
>> damos_get_some_mem_psi_total). There is no reusable in-kernel helper that
>> returns per-cgroup, multi-domain (cpu/mem/io x some/full) pressure as a
>> value (psi_show is a seq_file printer for the /proc and cgroup files, not a
>> value-returning API), and no in-kernel threshold-trigger (psi_trigger_create
>> is userspace-fd only).
>>
>> I'm writing a node-level multi-domain (cpu + memory + io) resource
>> coordinator for container/Kubernetes nodes - a small C daemon using libbpf
>> plus PSI trigger fds. To attribute pressure to specific cgroups and act
>> across domains it needs per-cgroup, per-domain PSI,
> Sounds interesting!
>
>> which today means
>> open-coding reads of cgroup_psi(cgrp)->total[] the way DAMON does in-kernel.
>> And I think DAMON's own per-memcg DAMOS quota goals would benefit from the
>> same per-cgroup read if it existed.
>>
>> So the idea is a small helper, e.g.
>>
>>   /* per-cgroup, per-domain pressure; reuses update_averages() */
>>   u64 psi_cgroup_total(struct cgroup *cgrp, enum psi_res res, bool some);
>>   /* and/or an avg10/60/300 variant */
>>
>> with DAMON migrated to it as the first in-tree user.
> I'm sorry but I'm missing your points from here.  Could you elaborate why we
> need the helper, and why DAMON should use it?
>
> You're implementing your system in user-space, so I don't think you will use
> that helper for your system.  DAMON has its internal implementation for reading
> PSI.  What's the benefit of the helper compared to the current one?
>
> Also that helper may be implemented inside PSI or cgroup subsystem and
> maintained by the maintainers of the subsystems.  Are they willing to have this
> and increase their maintenance burden?
On the helper: agreed - a userspace daemon reads PSI from the cgroup files
and DAMON already has its read, so there's no in-kernel consumer for it;
not the right place for kernel-side work. (And you're right that anything
on the PSI API is Johannes/Tejun's call, not DAMON's.)
>> Before I do anything: does this capability gap resonate with you - is
>> per-cgroup PSI consumption something you'd want DAMON to grow into, or do
>> you see it staying userspace-only? And if a helper makes sense, any
>> preferred shape, or concerns about exposing the averaging/locking contract?
>> I'd keep the first cut to just the read helper + DAMON migration; an
>> in-kernel trigger callback I'd treat as a separate, later step and only if
>> there's a second consumer.
> Seems you have larger picture.  I don't clearly show what is it.  Could you
> share it at a high level?  That might enlighten me.
>
The bigger picture, since you asked: I'm working on node-level multi-domain
(cpu + memory + io) resource coordination for container/K8S co-location -
online/latency-sensitive work sharing a node with offline/best-effort. PSI
per domain is the signal ("who is starved, on which domain"); cgroup
controllers are the actuators (cpu.weight/cpu.max, memory.low/reclaim,
io.weight/io.max). Adjust across domains to defend online SLOs while
keeping the node full. oomd, systemd-oomd and rubik each do one slice
today; nobody coordinates across domains, and that cross-domain part is
what I'm building.

What brought me to PSI/DAMON is the memory domain. DAMOS is already the
strongest memory actuator I'd want to orchestrate rather than reinvent -
proactive reclaim, per-memcg DAMOS goals, the PSI-aware quota - except
DAMOS goals today only take memory-domain signals (mem PSI, mem usage). For
a cross-domain coordinator the useful step is making memory-domain reclaim
also respond to non-memory pressure (e.g. shrink offline footprint when
cpu.pressure rises).

So the honest question, which I think is where this actually meets the
kernel: is the pattern you'd prefer that an orchestrator just adjust DAMOS
schemes over sysfs in response to external pressure, or have you thought
about DAMOS goals accepting non-memory signals (cpu/io PSI, or generic)?
I'm asking which side of that line you'd want it on, not pushing either.

Thanks for asking for the picture - stating it clarified it for me too.

Song
> Thanks,
> SJ
>
> [...]
