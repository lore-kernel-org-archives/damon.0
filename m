Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E930CDBC;
	Wed,  3 Jun 2026 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470486; cv=none; b=HkEEoFEGidSATrJBKMJyjQAgwJpQYI4xO+U2xNlNF6+op3b4hEzZewhK6Bp2MsfP7pE8q10mjUK9ZwrkU/vU9SmZKu38wx4asiDNs2UaQPhqI/ISiMWasxR4A62DcmR6Jco7NeNmjsNUm04Jk2oBDDN/qzlfXhKTilLrMcfkcbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470486; c=relaxed/simple;
	bh=XlmdpT4JYV7meBHB+uyUg11V7gve6Af/lDfr6KlnYj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPUcxBW1O/6V+OzwdNpsAFMQVZ/2tV6xJgtFaDdYvir36pf5yf2X2yvm6ffK4V/00i2x32cjEYRAo0QBFvwYBNSquyT7rKptryUFH6pbpSNG2LXJzNfFWnLh/QwoCRw/MkD4jMLj73gpIVvNimIMS81KrmuVYOLGGkTem3WE7fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD/8LfUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD/8LfUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1AA1F00898;
	Wed,  3 Jun 2026 07:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780470484;
	bh=XlmdpT4JYV7meBHB+uyUg11V7gve6Af/lDfr6KlnYj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JD/8LfUIQTxpPOnSS0u744+AXlLaxoZwg1g6Lxrq/IjyJ4a7jp90chFnFzfLhkiF2
	 z+UQqmlEgng7WqTXUMORV2SyQGHVrlhnQ5TipVf7BUgk88Hgl3xXPueGfU5QfXk9WC
	 Je+AIHwzRziAxWEuVjX7Rnkc0DBeccZd26lVTJ5BEFCjO7J/to+ne4mrXkVmqunex/
	 N/XY+RnCldJiFgc3QpYMj5jBaofMsY8ZYhe4RZuIGaDqh4hSoGTadyOgkW2vwnf8B+
	 5TZOqSNKZRVwwe2s3AI9RQ0xXqWx95mEzshcJhZOHI8kVaXCI+l3+/GLnbRLPpJfQs
	 /MGj0qzVLJVvQ==
Date: Wed, 3 Jun 2026 08:07:49 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Barry Song <baohua@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>, 
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
Message-ID: <ah_O9NRJkH095jUP@lucifer>
References: <b24b4a8198ba412f8b8b42c43dccd058@honor.com>
 <ahf2mJg9OOWvu0jA@lucifer>
 <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
 <99dfc4a50f3643a6bef6deaeccfcf115@honor.com>
 <ahlzj--3Gm5pD9ge@lucifer>
 <a90bcb0fa3a044588350e92a78258a09@honor.com>
 <CAGsJ_4wFr89M2i8pth79swv3==i8SGSMWrbr+Yp2umwFTuCShg@mail.gmail.com>
 <2e9175ab-f9be-44c6-bf1a-a82aeed18f98@linux.dev>
 <ah71gjj21rLIuTnb@lucifer>
 <CAGsJ_4yKtEnCEyLVpzKUNDDw0AwttnFhB7c1sicBpjecBxATQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4yKtEnCEyLVpzKUNDDw0AwttnFhB7c1sicBpjecBxATQw@mail.gmail.com>

On Wed, Jun 03, 2026 at 07:03:53AM +0800, Barry Song wrote:
> On Tue, Jun 2, 2026 at 11:37 PM Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > On Tue, Jun 02, 2026 at 10:46:35AM +0800, Lance Yang wrote:
> > >
> > >
> > > On 2026/6/2 10:15, Barry Song wrote:
> > > > On Mon, Jun 1, 2026 at 9:46 AM wangtao <tao.wangtao@honor.com> wrote:
> > > > [...]
> > > > >
> > > > > You said discussion was welcome, yet when someone offered even a
> > > > > small comment, you refused to continue the discussion.
> > > > >
> > > > > If I had known you would be this inconsistent, I would not have
> > > > > replied to you in the first place.
> > > > >
> > > > > This will be my last reply to you. I will not respond again.
> > > > >
> > > >
> > > > Hi Tao,
> > > >
> > > > Please don't walk away from the linux-mm community. I read your
> > > > patchset and found it quite valuable. It not only reduces memory
> > > > overhead, but also eliminates rmap costs for exclusive folios.
> > > >
> > > > Since I'm not very confident discussing technical topics in English,
> > > > I wrote a blog post in Chinese about your patchset:
> > > >
> > > > https://mp.weixin.qq.com/s/k00tzhTl8HbL3k4G6ev4SA
> > > >
> > > > I have to admit that I found the implementation quite complex and
> > > > in need of significant improvement. However, I think the underlying
> > > > idea is very interesting and worth exploring further.
> > > >
> > > > I'm looking forward to seeing a v2 RFC with a cleaner and simpler
> > > > implementation while preserving the core concept.
> > > >
> > > > Regardless of whether it ultimately gets merged, I hope the discussion
> > > > can continue.
> > >
> > > Same here :)
> > >
> > > Tao, please don't let this thread get you down. No first RFC is
> > > perfect, and the idea still looks worth discussing :)
> > >
> > > Thanks for working on this!
> >
> > Guys, this isn't helpful.
> >
> > We aren't extending anon_vma, and I am working on replacing it, that's the
> > bottom line.
>
> Not trying to challenge your bottom line. As explained to Harry, I
> have no doubt about your expertise in rmap and many other mm
> areas, and I deeply respect your work on rmap.

Thanks I appreciate that.

I don't mean to be 'mean' here, I'm only acting in what I feel are the best
interests of mm and the kernel.

>
> With more discussion, we might gain additional insight and
> inspiration. What Tao has inspired me with is the idea that if we
> assume most real-world processes are leaf processes, could we
> simplify parts of the design?

Maybe I didn't express it clearly enough at LSF, but this is entirely a key
point of my CoW context design :)

It's true most stuff is leaf, and yes we can take advantage of this, and CoW
context allows us to do it while also unravelling the issues with anon_vma.

I am actually thinking of doing some incremental changes as part of my work
possibly if I can.

I maybe need to expedite that to bring some clarity to things here...

>
> This is why I suggested a v2, to improve the clarity of the cover
> letter and make the code easier to understand, and to see whether
> there is something worth considering further, even if it is not
> suitable for merging.

Right, I see. Again I'm really trying to tread a fine line here between the
technical discussion and not pouring more and more time into a discussion that's
not useful to me or the community.

See [0] as to my reasoning on this :)

[0]:https://lore.kernel.org/all/ah887A5VkXOcmq-g@lucifer/

>
> >
> > I have presented compelling evidence suggesting this is AI generated. In
> > response I got more AI-generated nonsense. There's no trust, the code and
> > analysis are all wrong, end of discussion.
>
> I am not an AI expert, and I do not really use AI in kernel work,
> so I am not really sure what counts as AI versus non-AI. Sorry.

No worries!

>
> >
> > >
> > > Cheers, Lance
> > >
> >
> > Thanks, Lorenzo
> >
> > P.S. maintainership is utterly thankless, and I don't really expect much in
> > return, but honestly reading this, given the case I've made here, was
> > really quite disappointing.
>
> Understood. I see your position, and I personally have great
> respect and appreciation for your work on maintenance. Sorry if
> my words came across as disappointing.

Thanks, appreciate it. And no worries!

>
> Best Regards
> Barry

Cheers, Lorenzo
