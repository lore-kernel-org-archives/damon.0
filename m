Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B030F1F3BA2
	for <damon@lists.linux.dev>; Mon, 22 Dec 2025 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766387307; cv=none; b=szXrppRwHMzbuP3DIjT5io1+uL5TTGIdFN/DjAsDhaVx8xJZQwgvvbLN//kPfYQzqmMTTrEB4Ct0Sttu33fAmrDyoXeg1oraVguaOOBUCr7q4LJzCArK8wQtU2nG17OfKrUzYPW3TJ4o0FNbyS71UHWhfgzQaD8YHEK4yDYspPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766387307; c=relaxed/simple;
	bh=sqBevws4MrT4JLqCGXJue7Q/Z06Ge0wPKyNR8aHLSYQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W/sCamEuq+NDhoc+oFnwUXID7bs+L26p2VLyUmVXHk1Vv+CtgO5Sz+sEX6KXTpyVjLoUK5iFOydFG+Wby3ZZK/3J6wNgrnGCWddXLkCxhp2s8hwbaePSJ0HcdiXvx7Erfu9hj9TTLr6jc9xUM2S9iUHuJcO488gg9A0OgJJM+pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f9ebe950df0411f0a38c85956e01ac42-20251222
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:e579bbef-59c5-4e26-80db-5953b0f24676,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:e579bbef-59c5-4e26-80db-5953b0f24676,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:dbf86791cbbbdf22cc788d8b0758222d,BulkI
	D:251216071650TNWFWTE8,BulkQuantity:13,Recheck:0,SF:17|19|64|66|78|80|81|8
	2|83|102|127|841|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT
	:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:
	0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f9ebe950df0411f0a38c85956e01ac42-20251222
X-User: lienze@kylinos.cn
Received: from [192.168.31.182] [(183.242.174.22)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 733422008; Mon, 22 Dec 2025 15:08:11 +0800
Message-ID: <638d4c03-f7c1-4ba9-801f-18c860960eeb@kylinos.cn>
Date: Mon, 22 Dec 2025 15:08:01 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Enze Li <lienze@kylinos.cn>
Subject: Re: [PATCH 0/2] mm/damon: export symbols and introduce prdm module
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 enze.li@gmx.com
References: <20251219114633.41156-1-sj@kernel.org>
Content-Language: en-US
In-Reply-To: <20251219114633.41156-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi SJ,

I appreciate you taking the time to provide such a detailed reply.  I
have a few more questions.  Please see below.

On 12/19/25 7:46 PM, SeongJae Park wrote:
> On Thu, 18 Dec 2025 21:46:37 +0800 Enze Li <lienze@kylinos.cn> wrote:
> 
>> On 2025/12/16 07:16, SeongJae Park wrote:
>>> Hello Enze,
>>>
>>> On Mon, 15 Dec 2025 22:20:55 +0800 Enze Li <lienze@kylinos.cn> wrote:
>>>
>>>> This patchset makes DAMON's advanced memory management accessible to a
>>>> broader range of users through two complementary enhancements.  First,
>>>> it exports the necessary DAMON core symbols to enable building loadable
>>>> kernel modules.  Building on this foundation, it then introduces the
>>>> 'prdm' module, which extends the concept from the DAMON sample code
>>>> (prcl.c) into a production-ready, user-friendly tool.
>>>>
>>>> The key strength of this module is its out-of-the-box simplicity: by
>>>> simply specifying the PIDs of target processes and enabling the module,
>>>> users can concurrently monitor memory access patterns across multiple
>>>> processes and trigger proactive reclamation automatically.  This
>>>> significantly lowers the barrier to using DAMON, allowing system
>>>> administrators and regular users without deep kernel expertise to easily
>>>> apply sophisticated memory optimization.
>>>

<...>

>>
>> Before developing prdm, I had considered implementing the same
>> functionality based on DAMON_RECLAIM.  However, I gradually realized
>> this would make DAMON_RECLAIM overly complex and less
>> user-friendly—especially given its existing module-specific exported
>> interfaces, which could confuse users.  This approach would create
>> significant barriers to promoting wider DAMON adoption.  Consequently,
>> building upon the prcl sample became the preferred choice.
> 
> I agree DAMON_RECLAIM already have no small number of parameters, and adding
> more may make it look even more complex.  But, users may use only parameters
> that really need to be set for their real use case.
> 
> For example, if we implement virtual address spaces mode in DAMON_RECLAIM, I
> think we can simply add target_pid parameter that works very same to that of
> prdm.  If it is unset, DAMON_RECLAIM works in the physical address mode.  If it
> is set, it works in the virtual address mode.  Adding just one more parameter
> that doesn't break old usage doesn't seem that complex change to me, at least
> in terms of the user experience.

This should be viable, though it will take a moderate amount of extra
time to develop.

> 
> As I mentioned above, yet another example would be using
> DAMOS_FILTER_TYPE_MEMCG.  For this, we may be able to add a parameter for
> describing the memcg of critical processes.  Again, adding just one more
> parameter that doesn't affect old usages doesn't seem too complex changes to
> me, at least in terms of the user experience.
> 
> Meanwhile, I agree adding a new simpler module could make it easy for new
> users.  But, I concern if having two modules for DAMON-based reclamation will
> make users get difficulty at finding the correct one for their usage, since
> they may now need to compare two modules.

Indeed, you're right.  From an architectural perspective, having two
modules forces users to spend time distinguishing between them, which
can cause confusion.

<...>

>>>
>>> And, even more importantly, why it should be a loadable module rather than a
>>> static module?  Do you have a specific use case that requires it to be a
>>> loadable module?
>>
>> Yes, loadability is crucial for operational flexibility in practical
>> production environments.  Beyond some obvious advantages, I would like
>> to highlight a key scenario: system administrators can load the prdm
>> module upon detecting memory pressure and unload it immediately after
>> reclamation is complete, thereby eliminating any overhead during normal
>> operation.
> 
> I agree always having prdm in kernel is an overhead.  But, I think the
> overhead is not meaningfully big.  Also, as I mentioned above, my intended use
> cases of DAMON modules is for cases that willing to simply always use the
> modules.  If runtime controls are essential, I think using DAMON sysfs
> interface or DAMON user-space tool is a better choice.

The prdm was developed based on samples/damon/prcl.c.  Would it be an
acceptable modification to port the multi-process support feature to
prcl?  Does that make sense to you?

> 
> Someone might argue DAMON sysfs interface is unnecessarily big compared to
> prdm.  But, I have to ask again in the case.  Does the overhead really
> meaningfully big for a real world use case?
> 
>> Furthermore, it supports zero-downtime updates, meaning that
>> improvements targeting prdm can be deployed via a simple module reload,
>> avoiding costly system reboots.
> 
> So I'm not really convinced at needs of prdm module at the moment.  But I agree
> your above point is a good example advantage of loadable modules.  Also there
> were private requests to support loadable DAMON modules.  No one among those
> were for real production use case, and I understand you are also doing this
> work for imaginable use cases, not your real products.  Please correct me if
> I'm wrong.  But as the request is repeated, if you willing to convert existing
> DAMON modules to support loadable modules build and expose required DAMON
> functions for that, at least I wouldn't oppose.

Thank you for your feedback.  I would like to try it out.

Best Regards,
Enze

<...>
