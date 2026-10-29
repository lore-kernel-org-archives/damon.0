Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233561;
	b=H5qS+njwIfrmvo/qeqbiWiBCZPhwe2HqOUA0exY7bzS54nJKR09DAkJ8NljNvyvj0Twc
	 Ln2p1Rwkpl3y8NzOgJE0aGhLbwNFh0D7rBTptRDZqTq4RTT3/ahkLKDuLfLIVrvXDzS2T
	 Ro837AcDvNDco8TEs/LjreBjpjoybZP8TxP8Z7JwqkSFAwbmntP/bv4yyHOXkITztHdmH
	 w+JzSRdmCH+u5GeF+D6S7Xpz7FFNLS0BTsrFNGP9xlbYdHkqzDYXUP9squy01dEsa9uqW
	 VATiTZnfIDYWaYdrW2pGooV9ije4Nxn37UKaKDg2lIIndRu0BV1V3cP6bvW2fmfNrKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233561;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=URGAbIYsZmrO7zoKja8bTGELNEU0ptfP/g/LFZldzT4=;
	b=OFf1o0gyV6LvQ0ciPT8aK/jeHV4dg58RF5Id2NJ6at4LFOzlfAuE/YNa6RtbL1ehaWSl
	 ypnt2YxzAy/HZK5VE4J9Qfq1JuqZvqnZ8cFIRPkXssPYZRrTackjR+1GmbAZa0fo/FbdK
	 GnWlpUcml1PdEvoB2b/jn1vx0v7C9ct0nQmUy8VVVjFmapDBqn8xH8/fQhffbMLCOpCdx
	 NpY5fmNuLZGVT5JWDqcxaBspaCkyVSiYwG1ORaPwH4uvL8KoP3fXUq/xWeTEo09OYgPCW
	 8vx/Jm/Jrr4Rek9SPQ6xKDwoexE8KhvTzNiBA/kIPxd03cDeypaqXvsNb3CBcoBj+zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HIMw+WKY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4448606A31A;
	Thu, 29 Oct 2026 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HIMw+WKY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A541F01829;
	Thu, 29 Oct 2026 00:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793233560;
	bh=URGAbIYsZmrO7zoKja8bTGELNEU0ptfP/g/LFZldzT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HIMw+WKYWlwxxKQz7LcDPrgXPqVxDcT/FqKJqvHmk2595MJau/O1w/72iQxQuLlCr
	 vVafhsd/P8N0KxtKgB44wU7Hwh/N0Ycxa8dNsu9mCmsbc6nK/QgqcS3GMz/iS+AEpF
	 mMrbVRTyJz7H1Xcbpgs07hkb3LiRWvbTXIWuSJOFJ2fWKy3jZhuTMEgL25j3W87mHG
	 T6ykjpTgiLgQKP8Amho5YrPl+29fgJjePsxW95Cl24SgHrYrCVWZuO2iR7B4sEs4XR
	 P8k1V0CCiDf1FiZRQHgTOAKsdsRB46afd+QxyXHuG364RrNn6KZ9vTI4dp0ieKxQqI
	 37x52cTfuqDIg==
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
Subject: Re: [PATCH v2 2/2] Docs/admin-guide/mm/damon/reclaim: rewrite complex parts
Date: Wed, 28 Oct 2026 17:25:52 -0700
Message-ID: <20261029002553.167065-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <e68efe96e67c8b72047f2ab01c874026cecb025b.camel@mailbox.org>
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

On Wed, 28 Oct 2026 17:52:17 +0100 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Hi SJ,
> 
> On Tue, 2026-10-27 at 17:19 -0700, SJ Park wrote:
> > Hello Manuel,
> > 
> > 
> > On Tue, 27 Oct 2026 22:23:46 +0100 Manuel Ebner <manuelebnerli@mailbox.org> wrote:
> > 
> > > Rewrite complex sentences.
> > 
> > Any special reason to keep this as a separated one?  I think it is ok to merge
> > this into the first patch.
> 
> In this mail ( https://lore.kernel.org/all/20261016142921.126622-1-sj@kernel.org/ )
> > Let's do such rewriting with another patch.
> 
> I understood this as 'make it two patches'.

Thank you for reminding me the memory.  I now remember I thought it is better
to be a separate patch.  And now I realize I was wrong.  Now I think realize
this is small enough change that can be collapsed into one patch.  Sorry for
changing my words.

[...]
> > > @@ -125,8 +126,8 @@ quota_reset_interval_ms
> > >  
> > >  The time/size quota charge reset interval in milliseconds.
> > >  
> > > -The charge reset interval for the quota of time (quota_ms) and size
> > > -(quota_sz).  That is, DAMON_RECLAIM does not try reclamation for more than
> > > +The charge reset interval for the quota of time is quota_ms and for the quota of
> > > +size is quota_sz.  That is, DAMON_RECLAIM does not try reclamation for more than
> > >  quota_ms milliseconds or quota_sz bytes within quota_reset_interval_ms
> > >  milliseconds.
> > 
> > I think the original sentence was not that confusing.  Also, this changes the
> > nuance of the sentence?  What the sentence is saying is
> > "quota_reset_interval_ms is the charge reset interval for ...".  If this was
> > really confusing, maybe we can add "quota_reset_interval_ms is " part.
> > 
> > But, I start feeling we might trying too much polishing...?
> 
> I think the verb is missing or can you tell which the verb is? If you can
> no fix is required.

I mean, changing only the first sentence, like below:

"quota_reset_interval_ms is the charge reset interval for the quota of time
(quota_ms) ans size (quota_sz)."

> 
> > 
> > >  
> > > @@ -137,7 +138,7 @@ quota_mem_pressure_us
> > >  
> > >  Desired level of memory pressure-stall time in microseconds.
> > >  
> > > -While keeping the caps that are set by other quotas, DAMON_RECLAIM automatically
> > > +While respecting the limits imposed by other quotas, DAMON_RECLAIM automatically
> > >  increases and decreases the effective level of the quota aiming this level of
> > >  memory pressure is incurred.  System-wide ``some`` memory PSI in microseconds
> > >  per quota reset interval (``quota_reset_interval_ms``) is collected and
> > 
> > I'm not sure if the original sentence was really difficult to understand.
> > 
> > I'd prefer dropping this change.
> 
> That's ok.

Thank you for accepting my humble suggestion.

> 
> Will you handle the final edit or should I send a [v3]?

Could you please send v3?


Thanks,
SJ

[...]
