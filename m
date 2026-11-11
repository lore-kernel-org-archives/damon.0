Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423260;
	b=P77mGpBltN6++fLhYEyjIN2KmcB7EdJMVadDTFEgAu9A76Cfe1dZDNxVwKKTwwno25d3
	 JwKlbyJS9po1BQzdMkfqHCPSVzXV5MhxyDTeopxX1rFQ94Gv7no1JzGmoGqxEa6m3/kdx
	 vYgzJz3jMjGXqQwxbXr4DN2Tchpv8Kna9l/hTGCaWzE2JssLImKSsCKu8YKXFUEkN6JqW
	 D3ZJ9SS9gkgb5k+Lklib9jYjzh8FsXKBm6RiGGQ+GmJORtZDl8RAoNWN0roZmlDxepUWl
	 LwthHP0nseJScLmmGQFiPxhz5m9iPxGSAhNQbBmTiSXFki0pRS1ZAFRp82wWviy1aDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423260;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7ZxY6FRy+iKIYaOcDLkICzfkOfpdlmgKNXCeP3oQIdA=;
	b=jxXAIKTy8JQyHG7EXnLcTMRmD4U7+lIY2Ah/hD8J/E+RfEM19cRo9EeHUOt/sLdRzX7F
	 sInpN4EUsqnLwf4SsH/IN/fkz3Jw2Bx4vng80t0/vdFUGBke4R47MEe52UkL8PGxADCVp
	 8gvjTOuNxFAxTswQDkWu9AK/pjp6YacIVaGym/6Dcu8RX5XZdv87eQ5g4fDuUAJy5h2DU
	 khsjn1qeMyZF4in2/hdTgYeypzDCbS7+nGN/aCOMqoBBOq0xMdKTQzq9X+mC1M61Xv5XM
	 zPTea2cJ5pTaPDnQEVjyuXkB4LEKCPRnS/m9AIL7olD3Qsu6y9dUdgX2sHAkgrwMUPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfLQmTEy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA3606A324;
	Wed, 11 Nov 2026 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfLQmTEy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE5F1F00A05;
	Wed, 11 Nov 2026 18:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794423259;
	bh=7ZxY6FRy+iKIYaOcDLkICzfkOfpdlmgKNXCeP3oQIdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KfLQmTEyEkOjYetaEk86ZORqkxLgjToheQz9VDFoVBwVZrB/rJa6h9lEWderuWfiQ
	 ULjZbma3rGqhDciaC502VLOZvkQ2w2xErqM0Hog1YFYSl4Rx45zl/ZAd0ri7hH+qrE
	 QtErvf9h8g+tbl8H2VGCQgGiUxktXrOOCgR6qJgXFpuJwyiDiwlNzq3/4FOBJ7+Gle
	 U+l8BYmRkJ4nk8jnkKBSiuaUjytbADFO4Ek9XJKkuXU9UxzuVsmyH+LaQrP5sPgNIt
	 OIJrWa6AiIZyTHrYGmq6W1he/IXInF4jzwG/wDVRVWDLWU3myEF/9tyx/Jq8wtt+E/
	 ruJB9OrNjbp8g==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v0] Docs/mm/damon/design: document data attributes report infra design (beyond page table accessed-bit milestone 2)
Date: Wed, 11 Nov 2026 10:54:11 -0800
Message-ID: <20261111185412.145514-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179438255225.3134195.10613668244848761847.b4-reply@b4>
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
Content-Transfer-Encoding: 8bit

Hi Aveline,

On Wed, 11 Nov 2026 18:35:52 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi SJ,
> 
> On Sat, 17 Oct 2026 12:57:45 -0700 SJ Park wrote:
> 
> > +The data attribute probe supports the reports.  The probes can be configured to
> > +hit for a given memory region depending on the existence of specific types of
> > +reports that associated with the memory region in given report buffers.
> 
> I'm wondering how this would interact with the region size.  If each
> page of a region is reported with probability q, a region of s pages
> would hit with probability 1 - (1 - q)^s, so a large region may hit
> more often than a small region of the same access density.

Thank you for sharing this finding.  Seems this theory assumes the probe will
hit for report of any byte of the region exists in the report buffers.  Under
the assumption, that makes sense.

But I'd say the assumed implementation is not realistic.  That's because DAMON
design does probing for only single sampling byte of the region, not the entire
bytes of the region.  In a real implementation that is aligned with the design,
the probe will hit if a report associated with the sampling byte exists.

> The page
> table accessed-bit check samples one page per region, so its hit rate
> doesn't depend on the region size in the same way.

I'd say it is not because it uses accessed-bit, but it respects the address
sampling design.

> 
> A quick replay of the crediting rule of Ravi's RFC v4 [1] on synthetic
> traces showed a similar trend.  The adaptive regions adjustment would
> mitigate this to some extent, but large cold-only regions still kept
> high hit rates after split and merge in the replay.  I'm not sure how
> much it matters on real workloads, though.
> 
> Would crediting the hits relative to the region size, e.g., reported
> bytes / region bytes, make sense to you?  It would need probe_hits
> wider than u8, so it is not free.  If you think it is worth exploring,
> I may run more experiments and share the results.

As long as the real implementation respects the address sampling design, I
think this will not be needed.

Thank you again for raising this question, and please let me know if I missed
something.


Thanks,
SJ

[...]
