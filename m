Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96541445AF6
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539659; cv=none; b=g+iISOdie68+aRYHmquJWGW4aTuOFGLZnJ8IlY1uKrlELbuKSsaq717Pcvs/W7lu08Uf8ugm6XyPcV3cwVsHjkqR75C2jwfqtp/T9q97wn715t5iD26Sd0VnFljpNVxScJ6YCQrzd8+iAWMKduQIUDzlayH9YD41L/xAjGebC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539659; c=relaxed/simple;
	bh=sn0emcyHr+XkG+GhLJTYkx749UcjCgDXxJpKXNsYt2s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LU1llXdG1wXBmhliPFybnBFvBP7QZZ9disNl1mj9c2x6hn62c9Pw1CuynV1CC+6aisO6BMcQrbZIFu69+2T8zucVTG9GScaJT4ELaGVBV3ACOt/VdXdjaQIw7kyxj7BIU80mToKPwz+hsAx0RbT0bFgwBimF8UvTOShRdLwQp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d4a6d17c964d11f1aa26b74ffac11d73-20260812
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_MAILER_MTBG
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED
	CIE_BAD, CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS, GTI_C_TF
	GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:066d82a8-44f0-4dc6-8c05-690b2a3ec16f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:11
X-CID-INFO: VERSION:1.3.12,REQID:066d82a8-44f0-4dc6-8c05-690b2a3ec16f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:11
X-CID-META: VersionHash:e7bac3a,CLOUDID:605b59ba582b5afab4c89d99d77faf46,BulkI
	D:260812210048KHQMDAIA,BulkQuantity:0,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:99|1,File:
	nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR
	:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d4a6d17c964d11f1aa26b74ffac11d73-20260812
X-User: husong@kylinos.cn
Received: from [192.168.1.116] [(111.162.215.50)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 272113639; Wed, 12 Aug 2026 21:00:44 +0800
Message-ID: <b01d7150-42a4-49b4-a3e1-b29d6db9c290@kylinos.cn>
Date: Wed, 12 Aug 2026 21:00:42 +0800
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
References: <20260721044334.152061-1-sj@kernel.org>
From: Song Hu <husong@kylinos.cn>
In-Reply-To: <20260721044334.152061-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Hi SJ,

Sorry for going quiet on this - things piled up and I let the thread sit.

在 2026/7/21 12:43, SJ Park 写道:
> On Tue, 21 Jul 2026 10:03:07 +0800 Song Hu <husong@kylinos.cn> wrote:
> [...]
>>>> I'd keep the first cut to just the read helper + DAMON migration; an
>>>> in-kernel trigger callback I'd treat as a separate, later step and only if
>>>> there's a second consumer.
>>> Seems you have larger picture.  I don't clearly show what is it.  Could you
>>> share it at a high level?  That might enlighten me.
>>>
>> The bigger picture, since you asked: I'm working on node-level multi-domain
>> (cpu + memory + io) resource coordination for container/K8S co-location -
>> online/latency-sensitive work sharing a node with offline/best-effort. PSI
>> per domain is the signal ("who is starved, on which domain"); cgroup
>> controllers are the actuators (cpu.weight/cpu.max, memory.low/reclaim,
>> io.weight/io.max). Adjust across domains to defend online SLOs while
>> keeping the node full. oomd, systemd-oomd and rubik each do one slice
>> today; nobody coordinates across domains, and that cross-domain part is
>> what I'm building.
> 
> Thank you for sharing the big picture.  Sounds very interesting!
> 
Glad it made sense. I owe you an actual answer to the question, though,
not just the sketch.
>>
>> What brought me to PSI/DAMON is the memory domain. DAMOS is already the
>> strongest memory actuator I'd want to orchestrate rather than reinvent -
>> proactive reclaim, per-memcg DAMOS goals, the PSI-aware quota - except
>> DAMOS goals today only take memory-domain signals (mem PSI, mem usage). For
>> a cross-domain coordinator the useful step is making memory-domain reclaim
>> also respond to non-memory pressure (e.g. shrink offline footprint when
>> cpu.pressure rises).
> 
> That's a very interesting idea.  I'm not quite sure what would be the expected
> result of doing cpu pressure based proactive memory reclamation, though.
> 
Honestly I'm not sure either - that's exactly why I'd rather measure it
than argue it. The bet, loosely: on a co-located node, when cpu.pressure
climbs you shrink the best-effort footprint - fewer resident pages, fewer
reclaims and faults fighting for the core, and memory given back to the
latency-sensitive side. You're trading memory to buy back CPU. Whether it
pays off, and how much, is what I don't know yet.

I've been building the thing I described so I can measure it. It's a
per-cgroup, per-domain PSI daemon (C, libbpf) - it reads the pressure and,
when adding resources doesn't make it converge, it tries to tell real
scarcity from a leak or pathology before piling more on. A colleague and I
are still debugging it.

>>
>> So the honest question, which I think is where this actually meets the
>> kernel: is the pattern you'd prefer that an orchestrator just adjust DAMOS
>> schemes over sysfs in response to external pressure, or have you thought
>> about DAMOS goals accepting non-memory signals (cpu/io PSI, or generic)?
> 
> I haven't thought such things.  That's only because I was unable to imagine a
> use case that will benefit from that.  If you have some theories and/or data,
> please feel free to propose changes.
> 
> FYI, DAMOS supports arbitrary 'user_input' for a quota goal.  You will be able
> to do some experiments using it.
> 
That user_input goal is the handle I was missing - thanks. The plan is to
wire DAMOS proactive reclaim to that goal as the memory actuator, feed it
the cpu-pressure signal, and see what comes out. I'd rather get the data
before the theory.

>> I'm asking which side of that line you'd want it on, not pushing either.
> 
> No worry.  I prefer DAMON to keep doing random evolution for providing benefits
> to the users.  If you have use cases that can benefit from some changes in
> DAMON, please don't hesitate at asking questions and proposing changes.
> 
Agreed. I won't bring you a "goals should take a non-memory signal" request
until I can show it actually helps - and if the numbers say so, I'll come
with a real proposal.

>>
>> Thanks for asking for the picture - stating it clarified it for me too.
> 
> I'm happy to help :)
>
Thanks for thinking it through with me.

Thanks,
Song

P.S. The code's at https://github.com/sharkct/tools_base_psi if you're ever
curious - not a pitch, just something I've been having fun with :)
 
> [1] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#aim-oriented-feedback-driven-auto-tuning
> 
> 
> Thanks,
> SJ
> 
> [...]

