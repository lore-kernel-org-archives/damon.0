Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407253B71A6;
	Fri,  5 Jun 2026 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652348; cv=none; b=i0afnz6aWhKWVUv+jOfVNFyfKzws+mvADenj3AtizSnIPsymZU6y0jc5M7CmAWv/WJFoLOjnFLJfofB+zBHI61derLinyqY0gGmGMMH6Z4y6u8BaduY3YDZZ/xuGjtAfShachbsJTC4PhG2HkujTuClkWkwKmldmO7xKsCNLjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652348; c=relaxed/simple;
	bh=x5+TosQSbym3AlXGBLbj6U8Nfi2vD+NLuMBI0rPvRzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCoKe5AS4DtBE67Zb0gQ8EKLX067pjt1QRX9SxOJFXV7BRd+9BEoX/0FKiasmZAkAhLGClMWo/BTAgL0X54nBmMiMvScIXWSvECBLdlQIzuwOAwedWeSYLEHONOagCpWApuu48H1AgH46fPC4iaAdjVbgxmm8VO1J43rsLnm8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7oT6stY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7oT6stY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E574C1F00893;
	Fri,  5 Jun 2026 09:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780652346;
	bh=g0exJx9gpz8TpzX9EFSHldYxLTySh1XVwF0hmGrg+SA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K7oT6stYsJW/YT9+CLuE4TfgWKkFNtwhsSQ53mqQovYMrbZLJWUQ4rbp6uxejWd+z
	 t5JHmN3KGMPCLS2TO56d7L74IOiAwX23PDECnj/nTfe197Q+OP9bE+qUvm01OxXTnz
	 VaXeAe5nEKvW4je9Yuy/sT4e/OngJ5J28DetwPAR/eKcBYhye7LPWuij71lfZsJBoa
	 XxqzSfDFN3Rxkre7vs/pwStv5dZDYpmh/+g9VuH+APF6pu+ubTi/Y8Qxo0UnhXkyAC
	 UJGS0bNa3B5he8hGXH7wYqtLCc1Pknc+f/TnAx+wmk3H3+sBpOcWP4UpCfZcAct3pi
	 G1RqfxxePG4cg==
Message-ID: <68a4aec0-72d4-4967-b063-b57cc7ee40cf@kernel.org>
Date: Fri, 5 Jun 2026 11:38:52 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
To: xu.xin16@zte.com.cn, tao.wangtao@honor.com
Cc: catalin.marinas@arm.com, will@kernel.org, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 kees@kernel.org, luizcap@redhat.com, zhangjiao2@cmss.chinamobile.com,
 kas@kernel.org, ljs@kernel.org, hpa@zytor.com, liam@infradead.org,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 jack@suse.cz, riel@surriel.com, harry@kernel.org, jannh@google.com,
 jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 chengming.zhou@linux.dev, nao.horiguchi@gmail.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 pfalcato@suse.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, damon@lists.linux.dev, shakeel.butt@linux.dev,
 ryncsn@gmail.com, dvander@google.com, wangzicheng@honor.com
References: <20260604111035154Lk-9ZgwKY4Nlk4zz30U1t@zte.com.cn>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260604111035154Lk-9ZgwKY4Nlk4zz30U1t@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/4/26 05:10, xu.xin16@zte.com.cn wrote:
>>>
>>>  arch/arm64/Kconfig         |   1 +
>>>  arch/x86/Kconfig           |   1 +
>>>  fs/proc/page.c             |   6 +-
>>>  include/linux/mm.h         |  38 ++
>>>  include/linux/mm_types.h   |   9 +-
>>>  include/linux/page-flags.h |  34 +-
>>>  include/linux/pagemap.h    |   2 +-
>>>  include/linux/rmap.h       | 165 ++++++++-
>>>  mm/Kconfig                 |  22 ++
>>>  mm/damon/ops-common.c      |   4 +-
>>>  mm/debug.c                 |   2 +-
>>>  mm/debug_vm_pgtable.c      |   2 +-
>>>  mm/gup.c                   |   6 +-
>>>  mm/huge_memory.c           |  16 +-
>>>  mm/internal.h              | 171 +++++++++
>>>  mm/khugepaged.c            |  13 +-
>>>  mm/ksm.c                   |  43 ++-
>>>  mm/memory-failure.c        |  11 +-
>>>  mm/memory.c                |  19 +-
>>>  mm/migrate.c               | 126 ++++---
>>>  mm/mmap.c                  |  15 +-
>>>  mm/mremap.c                |   4 +-
>>>  mm/page_idle.c             |   2 +-
>>>  mm/rmap.c                  | 690 ++++++++++++++++++++++++++++++++++---
>>>  mm/vma.c                   |  76 ++--
>>>  mm/vma.h                   |   4 +-
>>>  mm/vma_exec.c              |   2 +-
>>>  mm/vma_init.c              |   1 +
>>>  28 files changed, 1279 insertions(+), 206 deletions(-)
>>
>> Hi!
>>
>> When I saw the diffsat I was concerned. Going through the patches made me ...
>> more concerned :)
>>
>> This is a lot of complexity. On top of something that is already so complicated
>> that I fail to grasp most details without regularly taking a look at the nice
>> figures Lorenzo created recently.
>>
>> For example, I read above "since child VMAs do not need to allocate anon_vma"
>> and wondered how that could be part of something that is just done lazily. Then
>> I had to learn in the patches that there is some additional "Child VMAs
>> are created as ANON_VMA_TREE_PARENT and do not allocate anon_vma" -- excuse me,
>> what? :)
>>
>> Reading about VMA refcounts made me shiver. Reading "Holding only
>> folio_lock(folio) cannot guarantee that the split
>> operation completes atomically." confused me. Learning that we have to invent
>> interesting ways to make page migration mutually exclusive to free_pgtables()
>> concerned me. Figuring out that there are arch-specific config options and
>> runtime toggles is a clear warning sign.
>>
>> Seeing test_folio_unmapped() was funny, though (why?! :)).
>>
>> I think this patch set has a noble goal of reducing anon_vma overhead when anon
>> pages are not shared during fork. However, using anon_vma for them actually
>> makes the overall implementation (e.g., rmap walks, locking) more consistent and
>> simpler.
>>
>> Even if we could be convinced that most of this here is correct, how should we
>> reasonably maintain this increasing level of complexity here?
> 
> Indeed, it's very complex, but having the changes of 15 patches scattered across
> various subsystems is really frustrating for reviewers. It took me a whole day to
> read through the entire patch set, which made an already complicated matter even
> more complex (maintaining such complex code in the future will be a pain).
> 
> However, overall, I think the original intention behind Tao's patch is innovative
> and valuable, and Tao could definitely make this patch set simpler and more
> readable, because the core changes actually start from PATCH 10.
> 
> I believe that if Tao had done the following, things might have gone better and easier
> for reviewing. In fact, I understand the motivation behind the patch is quite simple
> at its core (just wanting to avoid allocating the anon_vma structure when a VMA hasn't
> been truly forked, and instead put the VMA information directly into folio->mapping):
> 
> 1) You could actually simplify your patch significantly — without adding a lot of wrappers
> and helper functions that introduce extra review overhead — and keep only the most essential elements.
> 
> 2) Provide complete test code (in tools/testing/selftest) that covers the affected functionality,
> such as VMA, huge pages, KSM, etc.
> 
> 3) Use the RFC tag to start a discussion.
> 
> 
> I would be very glad to see if Tao could post a simpler v2 version that does not alter the rmap
> core data structures too much and does not introduce excessive complexity, no matter whether
> it can be merged finaly.

I'm afraid, the overall complexity would increase in any case.

So to quote myself "But fundamentally, I think we want to find a new design that
is just naturally simpler."

-- 
Cheers,

David
