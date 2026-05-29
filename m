Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1FE3BCD3D;
	Fri, 29 May 2026 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056250; cv=none; b=Bcf1Z6EVzabtGw6AMtxXyTJf8xd2tgp6cGSzPzVwDkrl5QNt4GzbNTtItSHsTvakxMHntredz4lKKtFwY1FhbSB4NaPlomsauB8oEPWtzzP/E0kUcZN67sgdx42u7jVKeWyJZ5kaGgkphYeh1o6BGvopuO5fVD1WS9FKxHOjm2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056250; c=relaxed/simple;
	bh=UgaLVHzMJPudw5p27mbJmuIhxJy99jUn+40OngA69s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltwptnKmedGIH2Hc7zzFBVuC0nxK3gX7fizQ8CoLebUQNFbgAKG9j/3r7JpHzD4/gZG2KZdpr1iN/vf9yoZOeFHc9HGpXyAYWnlprT97S5EfcDrXkOifjH94QdEdB7SMt+CafNElyL1Gl2NfUIb297cRQdTwKPyyE+cjto6bhkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXwaAx3i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXwaAx3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E861F0089B;
	Fri, 29 May 2026 12:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780056248;
	bh=S10gyhVYxahoA8Irz4eAewQjf2OZmpshI7uoubc38/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SXwaAx3iEvTQtUvlgzMSScqJifFY1t2jzb7lWTw7MFUJfI+AuUj1bFRememAZ2fm/
	 7KXJexgp3I8iSkyNeWNAgMD8lhCObwWUL6TemUN4yE+WM+AOMxIwtm6hxkv0giNAna
	 77x2jcfZuS2Cbek6EzeuDMYDqxKzjx9sgi26NZj9LG0MWj3vFbFcD++D4an+t+vWGW
	 5Jt4mVinrFsvaIc3hWqRCPoLlfYMyhlFODqhQ/v/sh/5FRSLIf25f+Iw0C3pkJZWxm
	 t0jIfbiUKgjSYdGrMOOOm4n5hxuK2WBrBpRguD18NCHcHZO8xUBAag/hkKHUyMWDvj
	 CSczn3LWb33MQ==
Date: Fri, 29 May 2026 13:03:52 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: wangtao <tao.wangtao@honor.com>
Cc: Barry Song <baohua@kernel.org>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, 
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"david@kernel.org" <david@kernel.org>, "willy@infradead.org" <willy@infradead.org>, 
	"sj@kernel.org" <sj@kernel.org>, "kees@kernel.org" <kees@kernel.org>, 
	"luizcap@redhat.com" <luizcap@redhat.com>, 
	"zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>, "kas@kernel.org" <kas@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "liam@infradead.org" <liam@infradead.org>, 
	"vbabka@kernel.org" <vbabka@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>, 
	"surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"jack@suse.cz" <jack@suse.cz>, "riel@surriel.com" <riel@surriel.com>, 
	"harry@kernel.org" <harry@kernel.org>, "jannh@google.com" <jannh@google.com>, 
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"peterx@redhat.com" <peterx@redhat.com>, "ziy@nvidia.com" <ziy@nvidia.com>, 
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, "npache@redhat.com" <npache@redhat.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "dev.jain@arm.com" <dev.jain@arm.com>, 
	"lance.yang@linux.dev" <lance.yang@linux.dev>, "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, 
	"matthew.brost@intel.com" <matthew.brost@intel.com>, "joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>, 
	"rakie.kim@sk.com" <rakie.kim@sk.com>, "byungchul@sk.com" <byungchul@sk.com>, 
	"gourry@gourry.net" <gourry@gourry.net>, "ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>, 
	"apopple@nvidia.com" <apopple@nvidia.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"damon@lists.linux.dev" <damon@lists.linux.dev>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryncsn@gmail.com" <ryncsn@gmail.com>, "jparsana@google.com" <jparsana@google.com>, 
	"dvander@google.com" <dvander@google.com>, zhangji <zhangji1@honor.com>, 
	wangzicheng <wangzicheng@honor.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Message-ID: <ahlzj--3Gm5pD9ge@lucifer>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahcANgFDFwfC0v1q@lucifer>
 <b24b4a8198ba412f8b8b42c43dccd058@honor.com>
 <ahf2mJg9OOWvu0jA@lucifer>
 <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
 <99dfc4a50f3643a6bef6deaeccfcf115@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99dfc4a50f3643a6bef6deaeccfcf115@honor.com>

On Fri, May 29, 2026 at 09:41:20AM +0000, wangtao wrote:
> > Hi Tao,
> >
> > Lorenzo had a discussion about rmap in Zagreb here:
> > https://lore.kernel.org/linux-mm/aec533b2-37a7-4f44-a279-
> > c4aa604206ac@lucifer.local/
> >
> > He also shared the PoC code here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ljs/linux.git/log/?h=project/
> > cow-context
> >
> > and the slides were shared as well. In case you can't find them on linux-mm (I
> > actually couldn't find them myself), I am attaching them again here -
> > "scalable-cow-lsf-longer-version.pdf"
> >
> > After coming back from Zagreb, I kept trying to find one or two full days to
> > read Lorenzo's code and slides carefully and write a blog about them.
> > Unfortunately, I have been completely busy with other work. Sigh... we
> > always seem to have too many non-upstream tasks.
> >
> > If possible, I'd really appreciate it if you could take a deep dive into it and
> > write a detailed blog post. I'd be very eager to read it and better understand
> > the overall design.
> > Otherwise, I'll try to find some time next week or later to go through it
> > myself.
> >
> Hi Barry,
>
> Thank you very much for your reply.
>
> I took an initial look at the cow-context code, and a few points
> might be worth noting:
>
> 1. cow_context_walk currently assumes that the rmap walk runs
>    under RCU protection. This may need to be adjusted early,
>    since paths such as try_to_unmap_one, page_vma_mkclean_one,
>    and try_to_migrate_one may involve task switching.
>
> 2. In cow_context_walk, traverse_contexts appears to involve
>    multiple nested loops. When there are many child processes
>    across several fork layers, it may not be as simple or
>    efficient as the current anon_vma approach.
>
>    It needs to traverse all child cow_ctx, and within each
>    cow_ctx, remaps_for_each() has two levels of iteration:
>    remaps_for_each_entry and remaps_for_each_entry_offset.
>
>    In other words, it first iterates over cow_ctx and then
>    traverses rmap_mt inside each one. The rough complexity

>    seems to be O(#proc * log(#rmap_entries_in_cow)), which
>    may be somewhat higher than anon_vma's
>    O(#vmas_in_anon_vma). However, in most cases the number
>    of processes is not large, so the impact may be limited.
>
> Previously, I also considered converting anon_vma's rb_tree
> to a mapletree. If one entry records a single VMA, the
> average overhead could be less than two longs per VMA.
>
> However, unlike rb_tree, mapletree does not support storing
> multiple elements under a single key. The key would need to
> look like (vma_id/mm_id + pgoff). On 32-bit platforms, since
> 64-bit mapletree keys are not supported yet, the remaining
> 12 bits are not enough for vma_id/mm_id.
>
> Because of this limitation, I later started thinking about
> ways to reduce anon_vma allocations instead.
>
> I will try to find some time next week to analyze the
> cow-context design and code more thoroughly, and then
> write up a summary.

Tao,

This response is so full of misunderstandings it's not really worth me
responding to any of it. You've even hallucinated an imaginary field which
is REALLY suspicious.

You've no mm expertise or history and came up with this in a few hours. I
asked Claude to analyse it and it puts it at 75-80% chance of being solely
LLM-generated from cow_context.c.

I simply don't have the time to deal with this, so unfortunately I'm going
to have to withdraw the suggestion of further discussion with you on this
topic.

I am working on the scalable CoW project and will solicit opinions of those
with relevant expertise.

We are not interested in your approach or analysis.

Thanks, Lorenzo
