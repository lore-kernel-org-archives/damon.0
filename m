Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E523D524F;
	Mon, 20 Jul 2026 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540667; cv=none; b=NZqckkHIS5j5ysv2iyhF1Jgx2OWnPDt3PdLWFkRw/b71Piq9vCGdg1oIWse3JyZGpLHILaXc81aHg9jOLFIOZovq5cNVPmxF+RakVwxZh7EuZsjVI9l+78LTWV7DZmuuI0NRWAgobStPWEOjdTS8/NqYTEZ2sXabGk6F6jBA250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540667; c=relaxed/simple;
	bh=nqKUuzyvscmYfC9dZYbKViVv+cBrJxRQB+fC8eDYLP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MuFWhbiXHzjeyyKGwTlJfoOVZB5lsm+HuHLXfoI0tGPhoqzhpdzoxYffTJJClJXKCjHd26KR/wugnRmw1TF4MVLIuuKY9TseoqT+b6mONL4WdbtgM6TngOU13XaF2NON7x0DdC+OMh0/LSgO6HqLI1fgIuNwOtoL7CbryUsdPQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uoks8aMO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uoks8aMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8F01F00A3A;
	Mon, 20 Jul 2026 09:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540665;
	bh=LJdgOgKGAT1CSJsO4REplq4ch5FATYh7SfBJqMlWH0A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Uoks8aMONAGVPbnyVCd43r//Ov68jjgFFZfnckuXJWQKk+2WEYy+MXXY5LyYPsBJ1
	 b5unPiWEPRZYHOa0u8Y+WMzSiOIK+Vv+KHyk39Z5rUrF0sq4ZIHuA4+pzogLDyx0fC
	 /tkzWLKSa+ZTN5mYXfapsS8x1NxtY6FQmFElOGOApOnTTGpQSF159Pq/jwurPBNN8G
	 1zwVqE4nhoTa5l6qyC/JHowXQmGppLu7ADKFqQlZNASZbHv1KB2cu8dXEiUgXiiNO5
	 j3J/xn5vXlU1vy6OT+cDbi2rZyavnadEjZn0HkiigvZuqs2F6GZ8hW81NfPcGVMWBg
	 Ty03Zwiy7ZnCg==
Message-ID: <59292ba2-e0cc-4e50-bb26-be9c15843a41@kernel.org>
Date: Mon, 20 Jul 2026 10:44:17 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/3] mm/damon: introduce DAMOS_SPLIT action
To: Lian Wang <lianux.mm@gmail.com>, damon@lists.linux.dev, linux-mm@kvack.org
Cc: sj@kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, npache@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, ryan.roberts@arm.com,
 daichaobing@sangfor.com.cn, wangkefeng.wang@huawei.com,
 gutierrez.asier@huawei-partners.com, zengheng4@huawei.com,
 kasong@tencent.com, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 lianux.wang@processmission.com, kunwu.chan@linux.dev
References: <20260720030327.80153-1-lianux.mm@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260720030327.80153-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/20/26 04:03, Lian Wang wrote:
> DAMOS_SPLIT splits large folios in a target region down to a
> configured target order, using the existing split_folio_to_order().
> No new core-mm code or exported symbols are introduced.
> 
> Based on mm-unstable at 61cccb8363fc ("mm/swap, PM: hibernate:
> atomically replace hibernation pin").
> 
> Different addresses within a PMD-mapped folio resolve to the same
> PMD Accessed bit.  Accesses to a small part of the folio can
> therefore coarsen DAMON's observed hot set relative to the actual
> working set.
> 
> DAMOS already provides promotion actions (HUGEPAGE, COLLAPSE) but
> has no corresponding demotion action.  DAMOS_SPLIT fills this gap.
> It is a mechanism, not a policy -- it does not decide which folios
> to split.  Selection is left to DAMON's existing access patterns,
> filters, and future probe/PMU signals.
> 
> target_order selects the split target: 0 for order-0 base pages,
> or a supported smaller mTHP order.  Both anonymous and file-backed
> folios are supported.  The locking follows split_huge_pages_in_pid()
> in mm/huge_memory.c.
> 
> Tests
> =====
> 
> damos_split.py (VM + Kunpeng 920):
>   anon THP -> order-0 split: PASS
> 
> sangfor_exp.py (Kunpeng 920, tmpfs, 4096 MiB):
> 
>   - Created a 4 GiB PMD-mapped tmpfs workload.
>   - Applied DAMOS_SPLIT with target_order=0.
>   - ShmemPmdMapped dropped from 4194304 KiB to 0 in every round.
>   - Repeated for five rounds without functional failures.
> 
> The functional selftest (damos_split.py) is included in this series.
> Additional experiment scripts and raw results are available on
> request.  Performance characterization using masim [1] and KMB [2]
> is in progress.
> 
> [1] https://github.com/sjp38/masim
> [2] https://gitee.com/OpenCloudOS/kernel-multi-bench

Hi,

you give no real motivation and evaluation why this is required or why this
gives the user any benefit.

HUGEPAGE + COLLAPSE is clear: give me THPs in a size not controlled by user
space, because the expectation is that this memory will be performance sensitive.

A SPLIT with an explicit order is not really want we want and it does not fit
the existing primitives.

-- 
Cheers,

David
