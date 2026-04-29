Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83517401A02
	for <damon@lists.linux.dev>; Wed, 29 Apr 2026 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470164; cv=none; b=sgcZ23D7oW7HGn87xnDLpehC/qJnf91acBnFUXRoVaaibmalYhsNDjoAsGhCwC6jfC6CPjCDHSv6FM/u8w3Q3Yi8epdewbD1edeUO5mgKDov5EBzV7sGv6FbBgyXuxbceOtO7ixa0S639JgOKaztowBgh1czbuoGewkwKuO/vKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470164; c=relaxed/simple;
	bh=8oIl+9E5+ZYyjQyOzSkIqpOdnbcSGnOo1+PhoaP0ooI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AP5AQbHqDbvW1FOPLSLA4bPuMZl5TmfOuUXfji+WGQ32ylyQOnpnWxgJBI9szh1PhiNRTLz3AYw8d2mt8HoPT8N1mQco877JMQDMbTvTMKtk+6faz9JTR6XkdEiFk0ZANmS4WtVkUOAvla07KdppTLqNPXv6cPCdPbOOPfW/20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Kf/jqn+R; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Kf/jqn+R"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so217917975e9.2
        for <damon@lists.linux.dev>; Wed, 29 Apr 2026 06:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777470153; x=1778074953; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZN8aaKgJ1Zzt3TUYPWuZx8THycU/Bmtyi8+XL6pyqc=;
        b=Kf/jqn+Rk6Ky8RK1ntvXVebQxd1hYlmN/wAo3V8K7Oyci4rJxUyJIsZHpayma+ldXb
         jNwvlIEAjVasGUZfEqSQpJ2V5ZKjNA4PwelgG7HZPn1DlsQeuUAUEXcQJJNzQAT14V12
         kXHB036jJQ3VcR0WFCqwwQCVa5jch0SfYMKhfZnqAC4j5I7q22vGxLM4+PmfmqY8R7Ek
         Z9TFLQorkhWQT2FZi+64Ow4igTyCaj2/ucIN08gPzQaCQ1TbFv+j7RsrlqMZYbyNk2cu
         WX+uo5acRmXVnbBYBn8TNoTiv2R0MWdBXghHhPtus6vww9Fy22eof1epF6sn+Q+cGp+R
         Xkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777470153; x=1778074953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZN8aaKgJ1Zzt3TUYPWuZx8THycU/Bmtyi8+XL6pyqc=;
        b=C9UkyTOOvVFadcY0UEXi0amoDuFhZBSD5wo0wrAunkM1nvL8Z/T7g61ol6z73BsEk3
         Iv8SwrZvg/zOfBQMqk7mCpA4IUmKGhMlxtEybd/iO7cdQ7QuzodPbjqmLLBWEGGFSuCf
         yI/n/laDPyoZnfMfwaIzZUyVHT0knQRtBsHh1zS/1Wwk+ODoXxvypFKaWeBxhf5cLqh0
         MHdhwID7A4WFJXrtJaRCOU0zzM52TUV9oa4ASXqRVTbHX5SGvOiqC9hwOv9zWBBnvsjR
         g6Gc6NhP7WdLa46Ky1ays+7TnPSQbnOaHyca+KAgyeC4qtUVlT9xgwCyiVqCYCHSGDuV
         QAfg==
X-Forwarded-Encrypted: i=1; AFNElJ/5ij6uQYm1NarDo5p86Zw6wkT9O0qNEauS8mcFbJLKdVUosP9+EXl9rUJ4f5vdn9qOMrN0Eg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPgRg7Yu9/0pMhQm+QbIcvdTmN/I6eCxGvV9MrOUHL18r6kAOB
	zyCKLNSTSGKM+evLjI2XZVNotKbhfX2Wfy1bV9tA1VqkqtphQnIPXr2dVtx4tCq6eOs=
X-Gm-Gg: AeBDiet5btAWE8VTyK3+maVGT5L+dvN354Ky23e1Z2LCvHzrwU413xrGTSw6+Dy5DLR
	GX9ZJA8sFEoqHnKYzrbx4X3IJT+tfcxY8NM7fQ1SGkyDraluEtoFqzcYBI7FqOX1YOfGm47DaHG
	tWiHVlP96k4IDjcytVoaJG0tI2Kpieb+r3xNB3D63dwHnoZ9IvdyEOjbEjFBRmQ+Ci74uV7D/5f
	72zof9JElbEAV8odbLFx1wPhlUZRLiQNLKaNfqbXl+pAk/QBlwMkb86rC2m8bJoalyHLK9wKUlb
	CY6t7t3MSPksH3JvTwTxbBd6rzMjeDKzOBCHClKhAlmhqfep8Uhv+1gXCjOpCqBkyq3qI3u/dWw
	zadXs93sie+yo5mE5G37Ypa5ytZ9oacAz8g03MxRklDiBuGyW6GFrO/ccKcT3AL832C3zLaypVN
	beFDG+WJXETU7s63IPdD65gr7VsBrTWvy3qd342eo=
X-Received: by 2002:a05:600c:4e4b:b0:488:be58:bb5b with SMTP id 5b1f17b1804b1-48a7b547375mr70345885e9.24.1777470152259;
        Wed, 29 Apr 2026 06:42:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2a00:23c8:67a7:3101::e3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7bc79ab4sm59981745e9.9.2026.04.29.06.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:42:31 -0700 (PDT)
Date: Wed, 29 Apr 2026 14:42:28 +0100
From: Gregory Price <gourry@gourry.net>
To: Arun George/Arun George <arun.george@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com,
	gost.dev@samsung.com, arungeorge05@gmail.com, cpgs@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <afIKxG5mJZE6QgpR@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <CGME20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0@epcas5p1.samsung.com>
 <1983025922.01777297382206.JavaMail.epsvc@epcpadp2new>
 <ae_i9IlIndumJWN3@gourry-fedora-PF4VCD3F>
 <1891546521.01777455002601.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1891546521.01777455002601.JavaMail.epsvc@epcpadp1new>

On Wed, Apr 29, 2026 at 11:45:26AM +0530, Arun George/Arun George wrote:
> On 28-04-2026 03:58 am, Gregory Price wrote:
> > On Mon, Apr 27, 2026 at 06:02:57PM +0530, Arun George wrote:
> >>
> >> Any particular workload you are targeting with
> >> this (which can tolerate this latency)?
> >>
> >> Any deployments you think of where the goal is a capacity expansion
> >> with a compromise in performance?
> >>
> > Primary use cases for us are any workload that benefits from zswap -
> > which is many, many (many, many [many, many]) workloads.
> > 
> A curious question please. If the primary use case is swap, can't we 
> handle this problem statement by re-using the zsmalloc allocation classes?
>

I'm using swap semantics for allocation ("demote + leafent") but otherwise
on-fault rather than removing the swap-entry, we leave it cached and
replace the page table entry with a read-only mapping (if Read-fault).

If there's a writable budget, and the node is under that budget, we may
also allow upgrading the read-only page to be writable (at which point
we would reap the swap entry).

This requires careful reverse-mapping in case there are multiple mappers
of the same folio.

Since otherwise the allocation is just alloc_pages_node(), and the fault
patterns differ from typical swap - i didn't see the need to overcomplicate
things by cramming the logic into zswap/zsmalloc instead of just making
it its own vswap[1] backend that sits in front of zswap.

vswap makes it easy to writeback a cram page to swap in the case where
the device is over-pressured and we need to make room (close the node,
disallow new cram entries, writeback existing cram entries to swap).

[1] vswap: https://lore.kernel.org/linux-mm/?t=20260320192741

> A separate size class can be reserved for non-compressed pages in 
> zsmalloc. And this interface could be used by zswap, zram etc. (We have 
> been using this implementation for testing btw.). This does not require 
> additional book-keeping or buddy allocator.
> 

The other reason not to overload an existing mechanism is because these
devices (that i've seen) cannot provide per-page compressability stats,
and so it would end up just looking like a bunch of either
uncompressible capacity or unknown compressed capacity.

That makes it harder for those components to reason about what to do
with their normal software-compressed capacity (for which they do have
that data).

> So write-control part need to handled in the specific back end driver of 
> private pages while the allocation control is a generic front-end sort 
> of, right? (Ex: zswap cram back end for compressed devices case.)


write control is handled by the OS in three ways:

   1) No file memory (no page cache)
      We get this for free using the swap semantics
      This prevents buffered i/o from bypassing page table controls

   2) User allocations only (or at least swap-eligible only)
      This prevents catestrophic system failure if the device fails

   3) Page table mapping control (disallow direct writes)
      This prevents uncontended writes to compressed memory by the cpu


allocation control is handled via private nodes - the driver which
hotplugs the private nodes hands that node to cram - and cram is now
aware of that capacity and will use __GFP_PRIVATE to allocate from that
node.   Removal of the private node from the fallback zonelist and the
lack of __GFP_PRIVATE in all other paths prevent normal buddy allocator
users from accessing that memory.

> 
> Great! I believe "writable budget" could be an interesting idea which 
> can solve the 'bus error' sort of scenarios due to device not capable of 
> taking any more writes. The write budget could be replenished using the 
> control path and writes will not go ahead without the budget available, 
> right?>
>

Write budget is simple

budget=1  (up to 1 page can be writable
   1) swap 1 page ->  cram alloc 1 page, put VSWAP_CRAM in PTE
   2) read-fault  ->  cram upgrades VSWAP_CRAM to R/O PTE
   3) write-fault ->
      a) if (writable_cnt < budget) { budget++; mkwrite(pte); }
      b) else:  normal swap semantic -> promote to normal memory

The catch with the writable budget is we may not always be able to catch
all frees of the vswap pages - meaning we get zombie pages in the vswap
tables.  But this is ok if we run a regular kthread scan the vswap entry
list to reap zombies.

This also gives us a great place to TRIM/FLUSH those pages to release
the capacity without zeroing them.


Meanwhile - use ballooning and a simple shrinker to dynamically size the
region to respond to real compression ratio.


All said an done - you get something close to zswap but with R/O
mappings for all entries, and optional R/W-mappings for administrators
who know something about their workload and can afford to take the risk
of some amount of capacity being written to uncontended in exchange for
performance.

The writable-budget is a risk-dial:  How much do you trust your workload
to now spew un/poorly-compressible memory?  The write-budget is a direct
measure of that. (so take P99.99999 compression ratios, and you can make
a good chunk of that writable).

~Gregory

