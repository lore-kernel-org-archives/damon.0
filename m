Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA630C37A
	for <damon@lists.linux.dev>; Thu, 18 Dec 2025 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065614; cv=none; b=BmZdqp5ZsMOb/zZT7VPaZ90NVhi0o3S26u8Wj3MbioGAQdCVPmOyR2hKV5A82egennpHPJUPKeSaFq1AU+gYJTk/+MFBWkqxo1fgRkgv7tMA2eDrYkKARbddGJhexKxhX1l7QOUxOk18xtjM/zfuFC3UIQ2xh/SO2RmWPt6pD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065614; c=relaxed/simple;
	bh=c+0BFRBhlHPVaDH1AMjywpXnvKvvZF9lktxHzq7k3wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GILWBzwBGR6AtapR64Ig7/UP/zyeVej9H9kU68MYcFWLFv5/GNUP/sbj5/9Jz7B3bydUjgUZhiaadsbR+4ZYqH0Ze7w7hVDcydymWaxxQ2CPJ9fZ6y0J3Wp5FCAMGn6xpER44j5YIzR84oyvUBvmor0HxEVu+GpbHUIzlzRK/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fb8253fcdc1711f0a38c85956e01ac42-20251218
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:91b3d06a-4a3d-4be2-b535-ab4fbedbdf2f,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:91b3d06a-4a3d-4be2-b535-ab4fbedbdf2f,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:688db8609c1d648c2f6fd5a0c4ae6102,BulkI
	D:251216071650TNWFWTE8,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fb8253fcdc1711f0a38c85956e01ac42-20251218
X-User: lienze@kylinos.cn
Received: from [192.168.3.106] [(61.48.214.33)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 143233166; Thu, 18 Dec 2025 21:46:41 +0800
Message-ID: <2c8dd0de-e650-4a74-b1f7-61ed81c03d26@kylinos.cn>
Date: Thu, 18 Dec 2025 21:46:37 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm/damon: export symbols and introduce prdm module
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 enze.li@gmx.com
References: <20251215231639.56448-1-sj@kernel.org>
Content-Language: en-US
From: Enze Li <lienze@kylinos.cn>
In-Reply-To: <20251215231639.56448-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025/12/16 07:16, SeongJae Park wrote:
> Hello Enze,
> 
> On Mon, 15 Dec 2025 22:20:55 +0800 Enze Li <lienze@kylinos.cn> wrote:
> 
>> This patchset makes DAMON's advanced memory management accessible to a
>> broader range of users through two complementary enhancements.  First,
>> it exports the necessary DAMON core symbols to enable building loadable
>> kernel modules.  Building on this foundation, it then introduces the
>> 'prdm' module, which extends the concept from the DAMON sample code
>> (prcl.c) into a production-ready, user-friendly tool.
>>
>> The key strength of this module is its out-of-the-box simplicity: by
>> simply specifying the PIDs of target processes and enabling the module,
>> users can concurrently monitor memory access patterns across multiple
>> processes and trigger proactive reclamation automatically.  This
>> significantly lowers the barrier to using DAMON, allowing system
>> administrators and regular users without deep kernel expertise to easily
>> apply sophisticated memory optimization.
> 
> I agree your points about the problems and the direction for improving the
> situation.

Thank you, SJ!  Glad we are on the same page. :)

> However, we have a module for such use case, namely DAMON_RECLAIM.
> It was designed for a reason that very same to what you described above.  One
> key difference between DAMON_RECLAIM and prdm is, to my understanding,
> DAMON_RECLAIM works for the physical address space, while prdm works for
> virtual address spaces.

Yes, I have studied the implementation and architecture of this module
quite thoroughly.  However, there are certain limitations when
considering it for production use.  To my knowledge, few would perform
indiscriminate page reclamation across the entire system.  In most
practical scenarios, people prefer to protect critical processes from
being swapped out, while applying page migration and reclamation only to
less critical or performance-insensitive processes.

As we all know, frequent page migration inevitably introduces some
latency to process response times.  Therefore, the ability to target
large, inactive memory consumers for reclamation addresses a strong,
genuine demand from real production environments.

> Is the virtual address spaces proactive reclamation is
> what you really need?  If so, could you please further describe your expected
> or planned usage of it?

Consider the following scenario: a host machine runs three virtual
machines -- Machine A, Machine B, and Machine C.  It is known that
Machine A handles massive traffic, while Machines B and C have
relatively light workloads.  When memory pressure arises, besides
releasing caches, the system can utilize prdm to perform precise page
migration targeting Machines B and C, ensuring memory usage remains
within a safe margin.

The data below, collected from a test environment, demonstrates the
effectiveness of prdm.  After enabling prdm to monitor the two
lower-activity VMs (2316, 2284), I observed that the DAMON-based prdm
successfully migrated 5.5 GB of pages to the swap partition.

 PID USER  PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
2253 qemu  20   0 11.251g 3.822g  32.7m S 4.989 12.28   0:48.75
qemu-system-x86
2316 qemu  20   0 12.191g 1.524g  34.3m S 5.322 4.893   0:49.05
qemu-system-x86
2284 qemu  20   0 12.092g 1.184g  32.5m S 5.987 3.803   0:48.10
qemu-system-x86

root@localhost /s/m/p/parameters# free -h
       total        used        free      shared  buff/cache   available
Mem:    31Gi        12Gi        15Gi       5.5Mi       3.2Gi        18Gi
Swap:   31Gi       5.5Gi        25Gi

> 
> If the virtual address spaces proactive reclamation is really what you need, I
> think extending DAMON_RECLAIM for the purpose might be doable and even simpler
> than introducing a new module.  How about doing so?

Before developing prdm, I had considered implementing the same
functionality based on DAMON_RECLAIM.  However, I gradually realized
this would make DAMON_RECLAIM overly complex and less
user-friendly—especially given its existing module-specific exported
interfaces, which could confuse users.  This approach would create
significant barriers to promoting wider DAMON adoption.  Consequently,
building upon the prcl sample became the preferred choice.

> 
> And, even more importantly, why it should be a loadable module rather than a
> static module?  Do you have a specific use case that requires it to be a
> loadable module?

Yes, loadability is crucial for operational flexibility in practical
production environments.  Beyond some obvious advantages, I would like
to highlight a key scenario: system administrators can load the prdm
module upon detecting memory pressure and unload it immediately after
reclamation is complete, thereby eliminating any overhead during normal
operation.  Furthermore, it supports zero-downtime updates, meaning that
improvements targeting prdm can be deployed via a simple module reload,
avoiding costly system reboots.

Finally, I would like to add that designing prdm with an extremely
simple workflow -- load the module, set the target PIDs, and enable the
switch -- will contribute to the promotion of DAMON, allowing a broader
user base to benefit from the DAMON system.

Best Regards,
Enze

<...>

