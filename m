Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278831;
	b=DiqMUe2swPxox2EMuW9fHpuZGlctrwgAjoWbPiwfssIewzy2PLosITblwBtjZPrV8R4s
	 znVBbIEA9QniIDgb6fa/ypXEI/prJfJyc4i92U8Er25vd7upcNc+DsCbX8iGp4/MonWL3
	 qTRy7ab3uRw1Lbcl2PsfP6f5m26OkXfWdVknylQuWcyKYUDOVVu+HZu8RoHK1ZgSAhEOc
	 9+UzUw/WwVhSXfuU5s5ycJ2P4NMJLRZV4yUeRN67NUYAQRwdYjWyXUmybSV/y1L9abiDB
	 3OiD2UacPF3eVLUS5Gb7aolP8YVHzgcHNlO9aI4pqF+0SsJYpTsm+voIYxeqbFW9mxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278831;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=j+lkRAnd6mBQc9FMob8xImFMoyAakN1CieZ1Wx5EmEo=;
	b=XGN3VmytO4IIbIbmQr6nfjEjT7O5bTQPZbnvK8FN1HHfrErcGA34vS2fz43EdU9howhR
	 3dxAtf8fcVkBXe4Ky0/T6mZDp6yJp1d0Glk3X4yaH4SHOsoVsgS3bS6lLj6QTd0VXiTwP
	 ypsy47yq9J5XCiVVKGmdIAGtJI2Smd/K79WzTqSzrfznSfwDotcjmM2au5LSIw+U4Pb8Y
	 d8IIbBDxYOfm1LACNs776a5Mu1Q6WIM/MjXzTG12QK62VubuIGFR6JLGR2Amikmdm5dUh
	 3cKsevfel6JJepTfKwXtr9TggGiZXnKF2OFJ3QamaH21tXczD7yoAyybeoT840C/wUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAUSMrSk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BE606A31C
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 02:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAUSMrSk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804CD1F0089F;
	Tue, 10 Nov 2026 02:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794278830;
	bh=j+lkRAnd6mBQc9FMob8xImFMoyAakN1CieZ1Wx5EmEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DAUSMrSkrtZIVEmoyWnxYPsNfk6xfSvYz0oanBbVUiSxOvRlJscBkiT7SbwJts085
	 /e9IPFuBVqGpVro0FlCewhs/n5US7AYvA5pg8WO76NrqKogxfiHS2pKAHUnD6aMg/6
	 8Q2dgtaAwvGjuhfP+fos1gkAzKD1fGFvw6AIr2g+bMtohDQc0BriKMqPtzk8ax3dsG
	 cfCchRZ58VOV6IF9BFbDCR2jAQALBRQq+e11Qy9FPQmE4Q8jAncuVQoMqv06HqvB7i
	 fSfSQP+RnvM/s8zCIRmrssK3Aoc9a/05k1jiSKDiHCjk1npJbdnlA5eCLgt8+k0xhP
	 IN7L7OjisJFzg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.12.y] mm/damon/core: move static variable last_nr_regions to damon_ctx
Date: Mon,  9 Nov 2026 18:46:59 -0800
Message-ID: <20261110024701.119411-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-206056@kernel.org>
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

On Tue, 10 Nov 2026 02:35:53 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] mm/damon: last_nr_regions placed in public section of struct
>   damon_ctx
> --
> 
> commit eb0ad0bdecede5a2fbbdad016dac644dd4b389f4
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: move static variable last_nr_regions to damon_ctx
> 
> This commit moves the static last_nr_regions variable from
> kdamond_split_regions() into struct damon_ctx so parallel kdamond threads
> do not race on region split state.
> 
> Link: https://lore.kernel.org/20261025164808.152048-3-sj@kernel.org
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 4688a10eca89b..dfd0295104d37 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -641,6 +641,11 @@ struct damon_ctx {
> >  
> >  	struct list_head adaptive_targets;
> >  	struct list_head schemes;
> > +	/*
> > +	 * number of regions after last merge.  Read kdamond_split_regions()
> > +	 * for more details.
> > +	 */
> > +	unsigned long last_nr_regions;
> >  };
> >  
> >  static inline struct damon_region *damon_next_region(struct damon_region *r)
> 
> [Severity: Low]
> Should last_nr_regions be placed inside the /* private: internal use only */
> section of struct damon_ctx (or preceded by a /* private: */ marker)?
> 
> In this tree, the end of struct damon_ctx is after /* public: */, so adding
> last_nr_regions here without a kernel-doc entry causes scripts/kernel-doc
> (via Documentation/mm/damon/api.rst) to warn:
> 
>   Function parameter or struct member 'last_nr_regions' not described in 'damon_ctx'

Nice catch.  I will post v2 with a fix for this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261110022924.115699-1-sj@kernel.org?part=1
> 


Thanks,
SJ
