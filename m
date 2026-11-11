Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424680;
	b=BK6n5rRVr7ZIuGuF31wb2mw0RArn2zy2Uhd9vFxgHuCNtmz4nzKPoQpY47m8A0XnsR6v
	 n5YnejarhSuSsZ+GhiB0trAWEqJxqUNDrv5u286WLtBbXDZ5Ac7XaskXSG2WaLA9rUvMk
	 qYBDuANIB7TZdbm7ClKYerYeUtmd/kFFiMvmM18pyuMLRfAp/UtT2lNhG5A3NWoWVY4+k
	 tRxaoegZWkC3YDgicBpE/b07oeGQNEkLVoNhwyFr3NxU9cLuQtgADar43+hF5D9Ktb5mb
	 kVu8oAsXSNO9PVsUlw7Lm85SxfejyCY0Q8hUvvgXS/FeXz82INLklWkI0N7Dez0ntyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424680;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FbGsBkq80dTXDcXRO3OyP/kA9RBJVrCTbNnkA3YaMcQ=;
	b=LzYBxnhcVrb/bzRkjIap8jjdA+5qtwvG9lGT3gcesbVb3Lchf/RtrQQKSiIqUV2fDLtC
	 GrF/9J3y8uIpF1JfV5zCCdYAplVUj7kxe3/ExDlOVAsc5tHMbpLSS7ASmpB5IsphtHWqI
	 x62GRxOy7z74P+oZYMJ1IWg/DL2mtenwYjJ4Pkp/XP6zfoFxsbSaF89e9tNnSszdEYqJh
	 aGpF2ot+Bru15wXOYHL/4Sa/7NXnyJxbfVkW0xQt0NhUXX7LVvew9zZhad3wLXcuveiGy
	 OZbUrCzDqYj7jOvz6i3CCXG6nrRHSnGYTapQr4o8Ki1HRxFAU1fx1ol9CGzeKKRzMpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K28nOICW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBE8606A324;
	Wed, 11 Nov 2026 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K28nOICW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A499B1F00A05;
	Wed, 11 Nov 2026 19:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424680;
	bh=FbGsBkq80dTXDcXRO3OyP/kA9RBJVrCTbNnkA3YaMcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K28nOICWilHBG7YzxMSQh0SxT0VsVxB0J/CWM0TQkAcAFbkikEwMcpJo/uBe17gKu
	 5D1Pw0fSGhW3aheo4iegmfxooOxhZ8/cqVmJukXfcfvNup6Nr+AtHJ7pYlVAk/IW/e
	 LEzArB8JhmJ1Sx+mX2HuPXMQWwFS9D2x9Bgqkvlw5efkAJADe7ErITKvagfkEWD6tP
	 l3mTk3/CoXKys6wsx+ThT6vELjCi2wrhpERH8VvgwpfMUCaXzA3QBv6JseuEXyA87u
	 s/AJd6qLegmBFEuxOJFggMjvStqx8pQZ8PSbINn5mgRrd3/QueHlw0+QSr6T8N5l5Z
	 Txj+rYf4OWLAw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v0] Docs/mm/damon/design: document data attributes report infra design (beyond page table accessed-bit milestone 2)
Date: Wed, 11 Nov 2026 11:17:51 -0800
Message-ID: <20261111191752.145919-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111185412.145514-1-sj@kernel.org>
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

On Wed, 11 Nov 2026 10:54:11 -0800 SJ Park <sj@kernel.org> wrote:

> Hi Aveline,
> 
> On Wed, 11 Nov 2026 18:35:52 +1100 Aveline Noir <jm5905938@gmail.com> wrote:
> 
> > Hi SJ,
> > 
> > On Sat, 17 Oct 2026 12:57:45 -0700 SJ Park wrote:
> > 
> > > +The data attribute probe supports the reports.  The probes can be configured to
> > > +hit for a given memory region depending on the existence of specific types of
> > > +reports that associated with the memory region in given report buffers.
> > 
> > I'm wondering how this would interact with the region size.  If each
> > page of a region is reported with probability q, a region of s pages
> > would hit with probability 1 - (1 - q)^s, so a large region may hit
> > more often than a small region of the same access density.
> 
> Thank you for sharing this finding.  Seems this theory assumes the probe will
> hit for report of any byte of the region exists in the report buffers.  Under
> the assumption, that makes sense.
> 
> But I'd say the assumed implementation is not realistic.  That's because DAMON
> design does probing for only single sampling byte of the region, not the entire
> bytes of the region.  In a real implementation that is aligned with the design,
> the probe will hit if a report associated with the sampling byte exists.

I will rephrase the document in the next spin to make this be more clear.
E.g., The probes can be configured to hit for existence of specific types of
reports that associated with the probing memory in the report buffers.


Thanks,
SJ

[...]
