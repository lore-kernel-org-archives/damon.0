Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233168;
	b=eBLlwt0zpaITeRNSWJPTsrncWAiKPJXm+7qosjZ/rkAXrIIMeFj608VJCcAnkg0X2yjs
	 v/Pe8itKgrP5v5LoSBo6Q/4o9tJUvN1WcC7ZHK6C3ymhS5b9xr2rhg221Liu072P9ZMVi
	 CzWvj/5kFiGS4lw2QyJr8hnjo4EEA0MQIILtuVqDt+0F49YG42KpowIztxAdKLDRpJdbw
	 GMAe4iZDsiKC6OyFtBY+onfsDcmjID8vW/kFp/NIvOPwcj1Dt/+F8ZjEijUueTOfCBiiq
	 DvmBgbGKDZNWyg2t6fvA6kNcuhOwurDyu+pQi4+f9OGnVPPEQFTNj7WBrwYGWGJc0Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233168;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GU7Gb3GLimfKLTFeZUh6Xge/AOYd9HMwRfZdUHSCdUA=;
	b=hChWtDx9F7342Ha0Ae8BOzJ3u7p+yU0wtp8xnoNRmS+i0p/shRoDLixBLd16G3UGyhfq
	 mH4AiXGZ4LuK+Ae4u42NbhKFzp9Z8wLnTAdWjZLTLYbtHDreAxy02NcC1TfDdZdNEg7Br
	 xhSMjkTWHvCguzPtbdCpAJmNtvptbmjixuPWf82t9ZuiXjbwVoYtEGvKYXM3YO+HHC2w4
	 8ay+w9GOpwln/gO7+OSWIkBTvCuxi4nGbra0Qt0lWGtTVsKDvvWufGikxISPjoDAqvoFv
	 /Cr3Hv6uEG068FCV+JdmKaXhjjPZzOIr2ph5xK3FuuEkwlYfBqna8BzNm2BYR61u0Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohR3uX7w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3F606A31A;
	Thu, 29 Oct 2026 00:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohR3uX7w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2881E1F01825;
	Thu, 29 Oct 2026 00:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793233167;
	bh=GU7Gb3GLimfKLTFeZUh6Xge/AOYd9HMwRfZdUHSCdUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ohR3uX7weE4E0JafS6YBZO4ZKoCy6PK+GGlCc+DDD1vXXdFOppaZrcuc+Duf1bUUW
	 G5yCdo83B+NdZ2HDqz/uhRIhXS1SPF3fmOxELysSXn1N3LUl2FMbyslQW8oN8KTPVE
	 XGsa2KWyu6KZlHdQoc+XIaSHHlO6poF06gOnt9/9057jrug7r8htJAsHmkBQcTd6yV
	 HKh3hl8A7whynE82pK3aNxX2CSbjcVGyoPIha2pEWWOAbmdVDNvX/zK587kk32/PkY
	 EecpCI6DuRlQ7PO4+4OUUjsoQ2bwTIIhFVWubQb3wEBk6Nb95N4rV9KLddCRvfvdu5
	 ppGEL8nR77/4g==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	corbet@lwn.net,
	damon@lists.linux.dev,
	jm5905938@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] Docs/admin-guide/mm/damon/reclaim: improve grammar and style
Date: Wed, 28 Oct 2026 17:19:19 -0700
Message-ID: <20261029001920.166896-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1303b843e41498612cce4acdbb47941c054bcf7d.camel@mailbox.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 28 Oct 2026 17:52:01 +0100 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Hi SJ,
> 
> On Tue, 2026-10-27 at 17:06 -0700, SJ Park wrote:
> > On Tue, 27 Oct 2026 20:05:04 +0100 Manuel Ebner <manuelebnerli@mailbox.org> wrote:
> > 
> > > Fix upper case. Fix tenses. Replace 'set as' with 'set to'. Add space after
> > > sentence to make it double space.
> > > 
> > > Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> > > CC: Aveline Noir <jm5905938@gmail.com>
> > > ---
> > > @ -113,8 +113,8
> > > Choose as you wish.
> 
> I will refer to this below.
> 
> > > 
> > > @ 20
> > > should be:
> > > -Free Pages Reporting [3]_ based
> > > +Free pages reporting [3]_ based
> > > or
> > > +'*Free Pages Reporting'* [3]_ based
> > > * the right kind of quoting/ kernel-doc highlighting.
> > > Choose as you wish.
> > > ---
> > >  .../admin-guide/mm/damon/reclaim.rst          | 36 +++++++++----------
> > >  1 file changed, 18 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
> > > index e4e2ffa52e..0bab2299ea 100644
> > > --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> > > +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> > [...]
> > > @@ -30,12 +30,12 @@ guests could mitigate this problem.
> > >  How It Works?
> > >  =============
> > >  
> > > -DAMON_RECLAIM finds memory regions that didn't accessed for specific time
> > > +DAMON_RECLAIM finds memory regions that weren't accessed for specific time
> > >  duration and page out.  To avoid it consuming too much CPU for the paging out
> > >  operation, a speed limit can be configured.  Under the speed limit, it pages
> > > -out memory regions that didn't accessed longer time first.  System
> > > +out memory regions that weren't accessed longer time first.  System
> > >  administrators can also configure under what situation this scheme should
> > > -automatically activated and deactivated with three memory pressure watermarks.
> > > +automatically be activated and deactivated with three memory pressure watermarks.
> > 
> > Let's keep 80 columns limit.  Same for below.
> 
> Okay.
> 
> > [...]
> > > @@ -113,10 +113,10 @@ quota_sz
> > >  
> > >  Limit of size of memory for the reclamation in bytes.
> > >  
> > > -DAMON_RECLAIM charges amount of memory which it tried to reclaim within a time
> > > -window (quota_reset_interval_ms) and makes no more than this limit is tried.
> > > -This can be used for limiting consumption of CPU and IO.  If this value is
> > > -zero, the limit is disabled.
> > > +DAMON_RECLAIM records the amount of memory which it tried to reclaim within a time
> > 
> > Didn't we agree to keep use "charge" ?
> 
> I thought we agreed to "records' but I sensed a misunderstanding. That's why I wrote
> > > @ -113,8 +113,8
> > > Choose as you wish.
> above. Should i have been more explicit?

Sorry, my bio memory easily be stale.

Anyway, my impression was that we agreed 'charge' is not really difficult term
and therefore keep using it.  Maybe you were saying that only for the paragraph
we discussed about if the term should be explicitly explained.

If you don't mind, I'd prefer keep using 'charge' here for consistency.  What
do you think?


Thanks,
SJ

[...]
