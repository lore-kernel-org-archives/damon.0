Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C893AFAE1
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788113443; cv=none; b=GYJetmGxXdAc4vQfmCdCfslyU7yyzI4HQ/hSJUXkrY2JFlvkRd9GWsEMbEKFrlK9p9TME4NY7ZRdHqr4XzTZpXnqkRMzQurD8oqA/ciNxV4pU7HeVLGPWlTTdbj2UpJnjTywUBRfTBvCsfweRK341XfbwC5QMaR0EledHr5mT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788113443; c=relaxed/simple;
	bh=GS0JL6nAnfaBSBPIGT8crL/NGOgpqSQ8bIJZ2mfmbAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mvt30RI7dpZHC/OFLZtduleuQ1t4165iWDir9m3ChLmgg2+VF/qLtrGGToOrye89Q2D7494JbbJroclCq9pW8btOFTM1zwqnuGCK54tmfGu1pQLsXFW0MwK87EYg+0r4tvxJaZNP1WXMs1BL2RT+oca+CuNFxeeC94WLw7LaJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io3g1AoB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io3g1AoB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72101F000E9;
	Sun, 30 Aug 2026 18:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788113441;
	bh=kiGU2zwyFZNQ++f4dl2SIOpOpqrNN9pkxUt1wxMYDH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=io3g1AoBSo7U4KkwR6ED4IzeJY/q8IJnPDqtyY3yuS7NGKIkPPnyY8fD2TjElQlnC
	 LbPxesq8RfCPbLqe8GZUg9aAscxpxG0LKncXM4IQ8yTWW6plJQy9CaIQrRwV9Q37sY
	 cPp7UV+399aJhVPUZkpS/k2nd73sUIMyLh0JwzhFP5ls+ANDXvEJq5iyfDabp76KW5
	 B5WZKyMv10fGH7928L8CaG4Nj0jY7/rSEIOMUYVPK9dJQWs1Swdt85+egqoL1qLiLQ
	 dVaSOydmySMKGDYZZUglaUhT72nlYg626OqrS5Q9+DgDjNUCw6uJuO+wEuDd/5BBgE
	 XqZHPip3MbL7g==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	"Krishna Iyer" <kiyer@crusoe.ai>,
	damon@lists.linux.dev
Subject: Re: [PATCH 2/6] mm/damon/ops-common: handle hugetlb folios in folio mkold/young rmap walkers
Date: Sun, 30 Aug 2026 11:10:33 -0700
Message-ID: <20260830181034.103943-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830161325.99195-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 30 Aug 2026 09:13:33 -0700 SJ Park <sj@kernel.org> wrote:

> On Sun, 30 Aug 2026 05:28:55 +0000 sashiko-bot@kernel.org wrote:
[...]
> > [Severity: Medium]
> > Will mmu_notifier_test_young() miss accesses within shattered huge pages here?
> > 
> > Since the kernel's mmu_notifier_test_young() API does not take a size
> > parameter, passing only the base address of the huge page means it will
> > only evaluate the first base page.
> > 
> > For secondary MMUs like KVM EPT that map huge pages as multiple smaller
> > pages, wouldn't accesses to other subpages within the huge page be completely
> > missed? This could cause DAMON to classify the huge page as colder than it
> > actually is, which might lead to inappropriate reclaim or migration decisions.
> 
> This is also a pre-existing issue.  I will work on fixing this.

Actually, the curernt implementation is correct.  The goal here is to know if
the single byte of the address is accessed.  It works in page granularity for
most cases due to limitations.  That's not the intention.  So I think this can
just be as-is.


Thanks,
SJ

[...]
