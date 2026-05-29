Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441913AB274;
	Fri, 29 May 2026 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037119; cv=none; b=l88BZsnDSOiskk5Ok19TdIN9KOQyy3iFzu1EjZgf1xRO9VPjYpOWtZMvRG7PsmapLbOoMeyO4bQKKTlh/dmx0NKHdS1tDhvNcItiCc36fVwPfkbGGuBI3ET70vlUzMxfSdWwNnnvfllSToCzeBfcTyQDjxaxSn/IMgTShHJxQgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037119; c=relaxed/simple;
	bh=45qJkQ7/G1I9ATLvYimFj5qIwA3l3ovznU7ORU/05EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM90adv02T5XqUbFYTjVSbQ9aGnrIho2oWCaAZOhKVmHCSrPvEEro0AJRb36M8LEMgWPPLwCydVEH4GgxtrJuf3OsNBPl80gBlZEx7IlB05NRcE91EvXtWcVLWulExyzHDOyfXl3DcV26pEmDWX1TFwS07qrfEOxVSBVR9pmiIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pds2bC4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pds2bC4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB381F00898;
	Fri, 29 May 2026 06:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780037118;
	bh=45qJkQ7/G1I9ATLvYimFj5qIwA3l3ovznU7ORU/05EM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pds2bC4GhfXy0kZB6W+u7qajyidJwxkF13ITX+B1JTRZAZaDEQ4z5/PGzFiZpVPB7
	 cTuayf/A1nICN+S0cOfQMiGa59hbdBoMWCgEyghIV15lcFgPu/4bblQX8LDk4TIr72
	 Riw5Mo3upVp5enOUw33BQQJczwXl3D9msQZHU2D6vlKfjODHEwdDq5mtG7vJ5m/riK
	 vXziMrbbrsB801d8dXUSgi6RiIb4KpAcgvibOTzLmGIwO+Ll9G/SwvUHWuZwmb2BHH
	 qPoAcu+IMS89zmEZBvR+WiwbQZd5W600vjYWorV6MmexlfNahzElVgi9bgY8dTvaAo
	 g3+29L6IDlsBg==
Date: Fri, 29 May 2026 07:45:01 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Barry Song <baohua@kernel.org>
Cc: wangtao <tao.wangtao@honor.com>, 
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
Message-ID: <ahkw3SE27GJlnnha@lucifer>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahcANgFDFwfC0v1q@lucifer>
 <b24b4a8198ba412f8b8b42c43dccd058@honor.com>
 <ahf2mJg9OOWvu0jA@lucifer>
 <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>

On Fri, May 29, 2026 at 07:31:12AM +0800, Barry Song wrote:
> Hi Tao,
>
> Lorenzo had a discussion about rmap in Zagreb here:
> https://lore.kernel.org/linux-mm/aec533b2-37a7-4f44-a279-c4aa604206ac@lucifer.local/
>
> He also shared the PoC code here:
> https://git.kernel.org/pub/scm/linux/kernel/git/ljs/linux.git/log/?h=project/cow-context
>
> and the slides were shared as well. In case you can't find
> them on linux-mm (I actually couldn't find them myself), I am
> attaching them again here -
> "scalable-cow-lsf-longer-version.pdf"
>
> After coming back from Zagreb, I kept trying to find one or
> two full days to read Lorenzo's code and slides carefully and
> write a blog about them. Unfortunately, I have been completely
> busy with other work. Sigh... we always seem to have too many
> non-upstream tasks.
>
> If possible, I'd really appreciate it if you could take a
> deep dive into it and write a detailed blog post. I'd be
> very eager to read it and better understand the overall design.
> Otherwise, I'll try to find some time next week or later to
> go through it myself.

Not sure if you're asking Tao or me about a blog post here? :)

> Hi Lorenzo,
>
> I truly believe Tao is acting with good intentions, although
> the way this is being done is quite messy.
>
> Memory costs are increasing significantly these days, and as I
> understand the patchset, he is trying to save memory.

I think there's broad awareness (from myself in particular...!) of this.

>
> However, I don't think this is being done at the right time
> or in the right way. This may also be due to cultural
> differences, language barriers, information gaps, and a lack
> of familiarity with the mm community.
> As a non-native speaker, I can see how difficult this can
> sometimes be.
>
> I would really ask you to give Tao more chances to build
> trust step by step.
>
> Best Regards
> Barry

I understand and empathise with language difficulties - I have zero
objection to using LLMs to assist with that.

But none of my objections relate to this.

We have received a huge, invasive, unmergeable series with code that reads
exactly as you'd expect from LLM-generated code, that Claude assigns a high
probability of being AI generated, from somebody with:

- 0 previous mm contributions
- 0 interactions in rmap
- 2 patches in 2026 (neither mm)
- prior to that only devicetree contributions from 8 years ago

What would you have me do under those circumstances?

Unfortunately this means I have very little trust in Tao, and given limited
maintainership resource, as I said, I suggest he attempts no further code
contributions to rmap.

And as I said elsewhere, he can rebuild trust through constructive
discussion. Also perhaps building up credibility in mm through smaller
series showing understanding?

Thanks, Lorenzo
