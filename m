Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3553264DF;
	Thu, 28 May 2026 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952987; cv=none; b=nXksoeWwkKYZ62eUOHemHpqQojIakmqzygJfakYyPKKEu4gE1G0q0LZJ8xW06VeYVpYNrM4HRMw1pqttA75QIJl1G83osTHoTp66PLlCNewrKbSC43PAvx+Y+tiXxZw9ErSFzMPzJ3e/sURIkGPTpEtZ70Go41prXz4+JdNoMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952987; c=relaxed/simple;
	bh=HHXMoFquiYqwF/6HKOfa/oV8pMDJswOIvcYE8om1ODo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdblD6xhgOSZRfFI4oWlUZGNuewTL4dL+Hl96m/PGMWXvtkhtWVYjOXSMDdEPJUIf3s6RX/HJd229egrNOlCG+h2r5wug51wNORUJ69AXkRMEDrhtjFv9BIfi5TVuqznePDoXZiO0KLWVcLZOIlENSaqVoguQJo1Q97tbaCX4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTIRfDt/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTIRfDt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC161F000E9;
	Thu, 28 May 2026 07:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779952984;
	bh=HHXMoFquiYqwF/6HKOfa/oV8pMDJswOIvcYE8om1ODo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OTIRfDt/2crw/q20AADL1qU3uFYcIxvzokAPq57kqI0Dt8zEfl1g1NHG1Nb26nU/F
	 DHFzUIUYs1CV1HX3AuFsYZv8rP49097eA9j0zjzuOCvXjHxV1MNVCDilr7IF/W84tx
	 Xia0Bn0OXpFx/TEE3++mvy8okZ3sKdRUTl53UkwFO90uScJPgrnevqogE7olUAUIHO
	 ntY8Ju1RmAsHVIEDDKZrW0iJRivTGwnL2hVQuRydTRvQjZfhWcuBqMerbEZigtcjK0
	 1C88h/AeIRGhRjW6T61m9LqiitqN2pEI8SU4e71uQ0AdquRlmsaCCEV72/eGyNhT9Y
	 L/NXndorMH/mQ==
Date: Thu, 28 May 2026 08:22:48 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: wangtao <tao.wangtao@honor.com>
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>, 
	"willy@infradead.org" <willy@infradead.org>, "sj@kernel.org" <sj@kernel.org>, 
	"kees@kernel.org" <kees@kernel.org>, "luizcap@redhat.com" <luizcap@redhat.com>, 
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
	"baohua@kernel.org" <baohua@kernel.org>, "lance.yang@linux.dev" <lance.yang@linux.dev>, 
	"xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, "matthew.brost@intel.com" <matthew.brost@intel.com>, 
	"joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>, "rakie.kim@sk.com" <rakie.kim@sk.com>, 
	"byungchul@sk.com" <byungchul@sk.com>, "gourry@gourry.net" <gourry@gourry.net>, 
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>, "apopple@nvidia.com" <apopple@nvidia.com>, 
	"pfalcato@suse.de" <pfalcato@suse.de>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"damon@lists.linux.dev" <damon@lists.linux.dev>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryncsn@gmail.com" <ryncsn@gmail.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"jparsana@google.com" <jparsana@google.com>, "dvander@google.com" <dvander@google.com>, 
	zhangji <zhangji1@honor.com>, wangzicheng <wangzicheng@honor.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Message-ID: <ahfrzwK-RsQOKxy_@lucifer>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahbSrt0B1aQTwrk4@lucifer>
 <288935c5d9d84794a9120893f61e670b@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <288935c5d9d84794a9120893f61e670b@honor.com>

On Thu, May 28, 2026 at 07:11:19AM +0000, wangtao wrote:
>
>
> > Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred
> > anon_vma creation
> >
> > I'm sorry but this is not how kernel development is done.
> >
> > You're sending a series that's very invasive, that you've not coordinated with
> > anybody else, nor have you mentioned it at a conference, nor engaged with
> > in discussion with anybody else in the community in any way.
> >
> > And you've sent it without an RFC, at -rc5 is... quite something.
> >
> > We do NOT want to extend or expand or hack in anything like this on top of
> > the existing anon_vma machinery. It's a mess that requires replacement, not
> > more hacks or expansion.
> >
> > I've been working on a replacement for the anonymous rmap, recently
> > presenting at LSF/MM, and all of that has been very public.
> >
> > In fact I have engaged in recent work which reduced lock contention in
> > anon_vma, it's really quite discourteous for you not to have contacted me or
> > the community in addition to the above.
> >
> First of all, thank you very much for your reply.
>
> I'm also glad to learn that you have been working on optimizations
> related to anon_vma. I noticed your work from another email in the
> thread.
>
> I apologize if my approach caused any inconvenience. My English is not
> very good, and I have rarely participated in community discussions
> before, so I'm still learning how things are usually done in the
> kernel community. If anything I did came across as discourteous, please
> understand that it was not my intention.
>
> Recently, due to increasing memory costs, I revisited the memory usage
> of anon_vma and found that it might be possible to reduce its
> overhead.
>
> My original intention was simply to experiment with an anon_vma_lazy
> mechanism to reduce the memory footprint of anon_vma. However, while
> working on it I realized that anon_vma handling is quite complex. In
> particular, after multiple levels of fork the topology of anonymous
> pages can become quite complicated, and it also interacts with other
> subsystems such as reclaim, KSM, and migration.
>
> Because of this, I tried separating the functionality of anon_vma
> into two parts: anon_rmap_t for anonymous page reverse mapping, and
> anon_vma_tree_t for topology management.
>
> anon_rmap_t provides the reverse mapping interface used by reclaim,
> KSM, migration, and similar components.
>
> anon_vma_tree_t manages the topology internally for operations such
> as fork, clone, split, and merge, and can also indicate whether a
> VMA has experienced page faults.
>
> My hope is that by separating these responsibilities, it may become
> easier to reason about and further improve the anon_vma design in the
> future.

I understand your approach, as discussed it's not viable.

As mentioned elsewhere, please refrain from further code contributions to
rmap, as there is now a trust issue due to a high likelihood of undeclared
AI-generated code.

You are, however, welcome to engage in discussion, and I'm happy to discuss
the approach publicly on list or via private email whichever you prefer :)

You are also welcome to engage in discussion/review/critique once I produce
my RFC for this.

Thanks, Lorenzo
