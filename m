Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A782837F724;
	Tue,  2 Jun 2026 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414650; cv=none; b=YpPCV2W8ct2vx28PXQOXmoEYR4F1Sn/Iv4jbBWQEwBeChpir7lKxHhktBkBZ8JzbkwkBn12KeWA/RnA1fOkn+d9bRCPIkXA3mOq4UHoXK9UNiI6QDW2P4ScsVQPSr4gs32OvTBQT3JuRdswksN9BcDK1aAnlLr7hlrBN60ezUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414650; c=relaxed/simple;
	bh=V+TuS8DPkmqRtcPq1oa2ywCobW38zWJCJnKHfJp57ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W20EbDFIYA/tepRKe6HfyKRjA62W/R9hXoJReSlYr2Yn+rBWnUK4K606Bi+ktKnAzMm9Ti8t81C18M4d/Y5hwLaU4Z46zwEI6LnzgLMHk9apxwem5cM5/Iar/Q1elDQqEJfQZPR2ykGo8sCriE39mmw9J/tbI8yNU/AaIrxdfFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaQB19BN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaQB19BN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8958E1F00893;
	Tue,  2 Jun 2026 15:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780414649;
	bh=V+TuS8DPkmqRtcPq1oa2ywCobW38zWJCJnKHfJp57ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iaQB19BNBJyOrQTApmU2FIBDnUDlGm06EsaWVbhN3JfWPfFzKos7oVryfuz2kP8Bg
	 9hiZaLmt3p6pa+56vFEnxwIdysvQmp4oe4BADtREZ/e7I+QVQZLrc6NtgxGP1yakY7
	 1eNOU6u9hu29q/DVPlbFNS9b5tNooovRJI4pxdnPsuUIArQyEX7A/W98RqDLiuZ4zK
	 vB9qWK4PpYNT1/+2dW6eGnxGq1zq5E4OdG2YrYHX4kQfhxg/Xg6HgcIqqeRqFOuDey
	 17M1W/oK+PFtVIj2yIteJXc1fWZgYAqYgCsBprsuPs6oD9xpm1ohcDL/6gDZowoSr8
	 OCXJqUGKuVQSA==
Date: Tue, 2 Jun 2026 16:37:14 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
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
	"xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, "matthew.brost@intel.com" <matthew.brost@intel.com>, 
	"joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>, "rakie.kim@sk.com" <rakie.kim@sk.com>, 
	"byungchul@sk.com" <byungchul@sk.com>, "gourry@gourry.net" <gourry@gourry.net>, 
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>, "apopple@nvidia.com" <apopple@nvidia.com>, 
	"pfalcato@suse.de" <pfalcato@suse.de>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"damon@lists.linux.dev" <damon@lists.linux.dev>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryncsn@gmail.com" <ryncsn@gmail.com>, "jparsana@google.com" <jparsana@google.com>, 
	"dvander@google.com" <dvander@google.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Message-ID: <ah71gjj21rLIuTnb@lucifer>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahcANgFDFwfC0v1q@lucifer>
 <b24b4a8198ba412f8b8b42c43dccd058@honor.com>
 <ahf2mJg9OOWvu0jA@lucifer>
 <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
 <99dfc4a50f3643a6bef6deaeccfcf115@honor.com>
 <ahlzj--3Gm5pD9ge@lucifer>
 <a90bcb0fa3a044588350e92a78258a09@honor.com>
 <CAGsJ_4wFr89M2i8pth79swv3==i8SGSMWrbr+Yp2umwFTuCShg@mail.gmail.com>
 <2e9175ab-f9be-44c6-bf1a-a82aeed18f98@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e9175ab-f9be-44c6-bf1a-a82aeed18f98@linux.dev>

On Tue, Jun 02, 2026 at 10:46:35AM +0800, Lance Yang wrote:
>
>
> On 2026/6/2 10:15, Barry Song wrote:
> > On Mon, Jun 1, 2026 at 9:46 AM wangtao <tao.wangtao@honor.com> wrote:
> > [...]
> > >
> > > You said discussion was welcome, yet when someone offered even a
> > > small comment, you refused to continue the discussion.
> > >
> > > If I had known you would be this inconsistent, I would not have
> > > replied to you in the first place.
> > >
> > > This will be my last reply to you. I will not respond again.
> > >
> >
> > Hi Tao,
> >
> > Please don't walk away from the linux-mm community. I read your
> > patchset and found it quite valuable. It not only reduces memory
> > overhead, but also eliminates rmap costs for exclusive folios.
> >
> > Since I'm not very confident discussing technical topics in English,
> > I wrote a blog post in Chinese about your patchset:
> >
> > https://mp.weixin.qq.com/s/k00tzhTl8HbL3k4G6ev4SA
> >
> > I have to admit that I found the implementation quite complex and
> > in need of significant improvement. However, I think the underlying
> > idea is very interesting and worth exploring further.
> >
> > I'm looking forward to seeing a v2 RFC with a cleaner and simpler
> > implementation while preserving the core concept.
> >
> > Regardless of whether it ultimately gets merged, I hope the discussion
> > can continue.
>
> Same here :)
>
> Tao, please don't let this thread get you down. No first RFC is
> perfect, and the idea still looks worth discussing :)
>
> Thanks for working on this!

Guys, this isn't helpful.

We aren't extending anon_vma, and I am working on replacing it, that's the
bottom line.

I have presented compelling evidence suggesting this is AI generated. In
response I got more AI-generated nonsense. There's no trust, the code and
analysis are all wrong, end of discussion.

>
> Cheers, Lance
>

Thanks, Lorenzo

P.S. maintainership is utterly thankless, and I don't really expect much in
return, but honestly reading this, given the case I've made here, was
really quite disappointing.
