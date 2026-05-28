Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB9135E549;
	Thu, 28 May 2026 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956102; cv=none; b=tCyf4BcFS87B1NoBOBAsk0LYTIoWIxfyV3E7J1SrrBgxUQZ9D1Ag27wdj0+tgiMKphJylkE5Q+mhLIGMl+to+3DhJywE6GdDPm7Svj2o+CEvRAA31pqDmLZ+NWkA8nNDCj7eheFdSTydeDNnMTpzknJPsG1WRX2SHbVK2Cl2GTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956102; c=relaxed/simple;
	bh=G6nhRcxWI3QvMmb/a9I27Blh4TlqlFHzUdwx6Eh9u8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2Ukhu+4YO5qxEVvC7V49DoJxbc5InCw0bctUmZwcdJmY550CQylm2EKhTPiJm1uYcYPALNzrnUbwsb8brl/qohfmkqMjEsQq5npTAn6HlTg3SH/GduRBwDP59FY1dp1geywgpuoLYkUVDhO0NnK5SdDMLpI/A79cpbT2g1iJfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vrn7sjU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vrn7sjU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E6D1F000E9;
	Thu, 28 May 2026 08:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779956100;
	bh=G6nhRcxWI3QvMmb/a9I27Blh4TlqlFHzUdwx6Eh9u8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vrn7sjU8PwtWgLSTKUb/ONKyECnR73JdOuVnaTtJGBeZFHG4ofRHbi9w0vD5a6Nr9
	 FuhXoVOSIbkG7o+NFwgC6CQrXzkQlT6vF+Le8gd80vjFGA/AnszJgGUrnobIcv8bka
	 hGzceJvfLLbFkl9ss3BJNg3dsNw+77mSYR0sKcwwk0M+dQGpFihyaDmuCCwyXD78mK
	 3muxnfDMAau6vM6GjDKDrIwIwIZh2YmcAEFsDcCTURhV7aFYqL3Q2vGdy1hFu8reXF
	 9KeqBNiWOsETUM+k5ePUEAosh8SlaFi0R46YE7WqboSOy2Dr3IBBcRhaEQvDEd4knH
	 GVJPOfRZOG3eg==
Date: Thu, 28 May 2026 09:14:44 +0100
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
Message-ID: <ahf2mJg9OOWvu0jA@lucifer>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahcANgFDFwfC0v1q@lucifer>
 <b24b4a8198ba412f8b8b42c43dccd058@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24b4a8198ba412f8b8b42c43dccd058@honor.com>

On Thu, May 28, 2026 at 07:57:31AM +0000, wangtao wrote:
> > Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred
> > anon_vma creation
> >
> > OK I've had a look through more thoroughly now and:
> >
> > NAK and NAK any approach like this.
> >
> >
> > Not only is this structurally all wrong, it does some insane stuff (pinning
> > VMAs - no), the RCU usage is highly dubious and I suspect you've completely
> > broken the anon rmap for things like migration, or have at least added very
> > dubious edge cases.
> >
> > You've added insane complexity, and also have failed to add even
> > perfunctory tests, which is also totally unacceptable.
> >
> > The implementation is wrong, and the approach is wrong - we do not want to
> > extend or build on anon_vma. So this is unmergeable, or any approach like it.
> >
> > I also, unfortunately, strongly suspect AI here. The turn of phrase, and poor
> > commit messages, you doing this out of nowhere with absolutely no rmap
> > experience before, your total lack of communication before.
> >
> > Claude puts the probability of heavy AI usage at 85-90%, and I'm pretty
> > convinced. Either way it's utterly unmergeable but that you (likely) used AI to
> > generate this much work for us makes me actually pretty annoyed.
> >
> > As a result, I would strongly suggest you no longer submit patches for the
> > reverse mapping part of mm, as there is now a real lack of trust.
> >
> > If you wish to rebuild that, I suggest you _discuss_ concepts and ideas, e.g.
> > send stuff on-list with a [DISCUSSION] tag, and engage with the community,
> > and go from there.
> >
> > It's also important to synchronise - I'm working on an anon rmap replacement
> > that I'm more than happy to discuss with you or anybody else which should
> > achieve the same numbers in an architecturally sound way.
> >
> > You going off and, in a vacuum, generating a bunch of code with an
> > unacceptable approach is not a civil way of engaging nor is it a good use of
> > your time, or maintainer time looking at it.
> >
> > Thanks, Lorenzo
>
> Your email is very unfriendly. I hope you can point out the specific
> problems so we can discuss how to solve them.

I already did, you've not responded to any of them, and I'm simply not
spending any more time on this.

The series is totally unmergeable, please do not make further rmap
submissions.

>
> I am not good at English and need to use AI to translate commit
> messages and comments. This reply email is also translated with AI.
> However, the code is written by me. I do not know which AI you are
> referring to, but the AI tools I use currently cannot effectively
> write kernel code.
>

We're fine with using AI for language, or in general as long as there's a
clear understanding of what's being submitted.

However I'm very unconvinced that this series wasn't generated.

You have 2 patches in the kernel for the entirety of 2026. One in bluetooth
and one in the scheduler.

Prior to that you have patches from 2018 in device tree drivers.

You have exactly 0 contributions to mm.

Out of nowhere this year you have a big series for DMA, this series for
anon_vma, having done no work or any contributions to rmap, let alone one
of the trickiest and most complicated areas of mm.

You have a total of 39 mails on the linux-mm mailing list.

Suddenly doing a giant bit of work like this using code that looks entirely
like it's AI-generated, and which after assessment by AI gives an 85-90%
probability of AI generation is really suspicious.

Now, if I'm mistaken, and you have a different name/email/identity I missed
with many mm contributes - I will eat my words here (the series is still
unmergeable either way though).

So sorry, there's simply no trust and as a maintainer of rmap again I must
strongly suggest that you no longer submit patches for this part of the
kernel.

If you wish to build trust up again, begin with discussions, and maybe try
some smaller patches in mm to demonstrate that you're genuinely acting in
good faith?

Thanks, Lorenzo
