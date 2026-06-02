Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C335A3A4
	for <damon@lists.linux.dev>; Tue,  2 Jun 2026 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429479; cv=none; b=q82pMIll0KFSnHYHxa3bYizCt2xQsZZZoMxLs1U+0lzGL3CeNdwNWyCSE/mVE3FBprJb9GA1ewM+ptFMQE6LrYUVgSeA5M2hRrgEdUlG1Nve7rRh6Nvwxq+40CsYB/vaHoVOyVqW9WrEsAaB4MbaecjAd20LJu324ZRU4gE+oS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429479; c=relaxed/simple;
	bh=HD6aC65vGHYJWTNLfA7vjd63zAyMRHkGZXErghJ39ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuyJxFbU8oMIyq/FA4k9AiZhGdLA4958YDGKZfKEPDDXh9bC6iL6aRxl7P5fidsdWkCXGvbMxTEyCeRj1TKxhPDHHAkoFvWpg6bN+jg/gGY9pAc0ejt16q/kr0iny32PiQ60jn7hZA49Mio/tcOnsGC6Tkz0NEt28kc3BD7WbjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gpOPl62s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GZpkSXOG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jZqclY0p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6SE0Vd4e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gpOPl62s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GZpkSXOG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jZqclY0p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6SE0Vd4e"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E6E9167012;
	Tue,  2 Jun 2026 19:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780429475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68oyGBalGPjx4S/SqU1876zUmF+aNoxjsBgHgPvh7kQ=;
	b=gpOPl62s/z+nvfSJ4+k5dHgri3q8iD9g8EJy2UoGXdtdwkSga8p2gih/+19bPABWS8cpSV
	MoKAEZpxO07iuyMEQ4xfsS4h36LAb84B9FKr32hEdVyeSltutyz4iInd740chl6XNANyHV
	xg4cUx+qAumUdCrOgSSvP+2qAklNYGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780429475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68oyGBalGPjx4S/SqU1876zUmF+aNoxjsBgHgPvh7kQ=;
	b=GZpkSXOG6NWHY6G03tz03oHT5KvBL3OfvOyiA5ACVg1fh+/aLJLQtfBGP0MKlsVu4pr7Ws
	lWq92Yx7udsBaACw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jZqclY0p;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6SE0Vd4e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780429474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68oyGBalGPjx4S/SqU1876zUmF+aNoxjsBgHgPvh7kQ=;
	b=jZqclY0p6taSNYloreDhC3XRjFbo3v6fv0CkVP5zYysRRX/e56pWEHRJCPl9l5khNfKc2+
	L8pvXJJ/+p0irfuSvOyOvGS206V6sMl6GxLfbw+fwDJnjKRvCUoH0qqzyOKG1pXH4g1Edh
	llYRFZq0oVV/NA7Q1TMh0oOR45ZVRSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780429474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68oyGBalGPjx4S/SqU1876zUmF+aNoxjsBgHgPvh7kQ=;
	b=6SE0Vd4erSO+3OcVs1ogVzzK1RgECW14xK2uATf2AoZmgqBZSw3+5lOJkZnGmVptMzEScD
	tdKT9/waLCKNrAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63925779A7;
	Tue,  2 Jun 2026 19:44:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RLn/FJ8yH2rgIAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 02 Jun 2026 19:44:31 +0000
Date: Tue, 2 Jun 2026 20:44:29 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>, Barry Song <baohua@kernel.org>, 
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"damon@lists.linux.dev" <damon@lists.linux.dev>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryncsn@gmail.com" <ryncsn@gmail.com>, "jparsana@google.com" <jparsana@google.com>, 
	"dvander@google.com" <dvander@google.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Message-ID: <ah8yP1FUpxl_6N56@pedro-suse>
References: <ahcANgFDFwfC0v1q@lucifer>
 <b24b4a8198ba412f8b8b42c43dccd058@honor.com>
 <ahf2mJg9OOWvu0jA@lucifer>
 <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
 <99dfc4a50f3643a6bef6deaeccfcf115@honor.com>
 <ahlzj--3Gm5pD9ge@lucifer>
 <a90bcb0fa3a044588350e92a78258a09@honor.com>
 <CAGsJ_4wFr89M2i8pth79swv3==i8SGSMWrbr+Yp2umwFTuCShg@mail.gmail.com>
 <2e9175ab-f9be-44c6-bf1a-a82aeed18f98@linux.dev>
 <ah71gjj21rLIuTnb@lucifer>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ah71gjj21rLIuTnb@lucifer>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E6E9167012
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,linux-foundation.org,infradead.org,cmss.chinamobile.com,zytor.com,google.com,suse.com,suse.cz,surriel.com,ziepe.ca,nvidia.com,linux.alibaba.com,zte.com.cn,gmail.com,intel.com,sk.com,gourry.net,lists.infradead.org,vger.kernel.org,kvack.org,lists.linux.dev];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLziudqfrzo6b7hzgpxksh1d9i)];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, Jun 02, 2026 at 04:37:14PM +0100, Lorenzo Stoakes wrote:
> On Tue, Jun 02, 2026 at 10:46:35AM +0800, Lance Yang wrote:
> >
> >
> > On 2026/6/2 10:15, Barry Song wrote:
> > > On Mon, Jun 1, 2026 at 9:46 AM wangtao <tao.wangtao@honor.com> wrote:
> > > [...]
> > > >
> > > > You said discussion was welcome, yet when someone offered even a
> > > > small comment, you refused to continue the discussion.
> > > >
> > > > If I had known you would be this inconsistent, I would not have
> > > > replied to you in the first place.
> > > >
> > > > This will be my last reply to you. I will not respond again.
> > > >
> > >
> > > Hi Tao,
> > >
> > > Please don't walk away from the linux-mm community. I read your
> > > patchset and found it quite valuable. It not only reduces memory
> > > overhead, but also eliminates rmap costs for exclusive folios.
> > >
> > > Since I'm not very confident discussing technical topics in English,
> > > I wrote a blog post in Chinese about your patchset:
> > >
> > > https://mp.weixin.qq.com/s/k00tzhTl8HbL3k4G6ev4SA
> > >
> > > I have to admit that I found the implementation quite complex and
> > > in need of significant improvement. However, I think the underlying
> > > idea is very interesting and worth exploring further.
> > >
> > > I'm looking forward to seeing a v2 RFC with a cleaner and simpler
> > > implementation while preserving the core concept.
> > >
> > > Regardless of whether it ultimately gets merged, I hope the discussion
> > > can continue.
> >
> > Same here :)
> >
> > Tao, please don't let this thread get you down. No first RFC is
> > perfect, and the idea still looks worth discussing :)
> >
> > Thanks for working on this!
> 
> Guys, this isn't helpful.
> 
> We aren't extending anon_vma, and I am working on replacing it, that's the
> bottom line.
> 
> I have presented compelling evidence suggesting this is AI generated. In
> response I got more AI-generated nonsense. There's no trust, the code and
> analysis are all wrong, end of discussion.

100% agree. I think plenty of technical/process/etc reasons as to why this
idea/contribution is not mergeable have been listed. Overriding this with
"keep it up!!!111!11!!" is not helpful.

-- 
Pedro
