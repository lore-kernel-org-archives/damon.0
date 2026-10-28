Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793165733;
	b=Zzge49+cZPR3r9X+Dn4NvkyaeKM2u1sbbN8JhadvrZN2nTZ074N4J04LJV2BKda+bb7Y
	 jXNHT8ulU1wwevbhxZvCysTcFdQf9RS4FgsDUa0yXCAXhoF0W33t0DuxnUIOfeMepDaza
	 T9f2k3Q+8M3g+2HknrV7Ouw2z6gE5f8icXaxTLarNtjR1sdSk5gFoJduCAgtK2SVtFlc6
	 EZ5RdwKAT5yGLErZcWTsgA472hyZI+OYUbby+1WnPayc9gePWuD2HQaBIAWANvyksM0ww
	 LhiJ78g//Vfgry+8fuBynzCBT4mbozAQVL/Na2A2wNDDS5eFNquPXUX0Df8Unoc6Sew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793165733;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oCF8kfzyKgaGcmmngoeyp1DL7LEberyF6cj2vg7mrCw=;
	b=2zsOysCGaCsIDlOCO1JHIARYfD2ZRYQ8Qs8kPLRbhF7Hlwho4kWBMqk9f7Xt4r2rjJA1
	 kYhnvqvf20eYJKiBPsrp8E8v8Qj663sdAbFocmkSJzGy2SF7CBqEVa2TX8TBMLWtmbSlz
	 lvyBim89w/Za8mwLtWzzizXUJeIgKDDBCEAfJZjxw+8NlguQ/im6YSNi4hJOTldAY6Pgi
	 xUD4FqCU53lwUlW41mcuoaNCDNPtFTByfb+uElPsRCQzCuI0nI24OwAso1IZXQYLp5kR0
	 BXJjdgnzSkPaLuiWcgeO7dUDXZ32v5BnCAt0q4zXF9NXxynJ79NbW7fuo4XUuoAME6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vx5RaM+k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C6606A31A;
	Wed, 28 Oct 2026 05:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vx5RaM+k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18281F01825;
	Wed, 28 Oct 2026 05:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793165732;
	bh=oCF8kfzyKgaGcmmngoeyp1DL7LEberyF6cj2vg7mrCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vx5RaM+kkDCqcYpK1TthH4mUUylEW9pvnlM6hLj9wD4ydPVPP79FDITUhr9XcbipY
	 9xGaEUTpZYpgQ9miH23CU1NgqEyRkQZb80TARyylyHKAOdJOhpuqm5yprWDKtFy75b
	 6xxyldCvVpHTDB9UygE0jMu+x5UF1FdfqeD5d9AWFbVW2cTOl4/rclO+W6+FpvoD89
	 ZoAYLpIJB7rZCZdEUcZzYeGBiSbybOQw6wLxYFa6Oy06VxwoqEq6j+ulym67/NwrLm
	 w65uM6fn6G3cPMnY/02Yk6Ij8crJhSIV78SBss9kcKuM4ZJ57rBWCVjPbBIfRisemq
	 D3Sf+ymu+jUsw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs/admin-guide/mm/damon/reclaim: document how to disable watermarks
Date: Tue, 27 Oct 2026 22:35:25 -0700
Message-ID: <20261028053525.155909-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028052425.154616-1-sj@kernel.org>
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

On Tue, 27 Oct 2026 22:24:24 -0700 SJ Park <sj@kernel.org> wrote:

> Hello Jinjie,
> 
> On Wed, 28 Oct 2026 10:36:28 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
> > DAMON_RECLAIM runs its scheme only while the free memory rate is
> > between `wmarks_low` and `wmarks_mid`.
> > 
> > But some users want to reclaim cold pages even while the system has
> > plenty of free memory, and it is not obvious that the existing
> > watermarks parameters can already do that. So Document the setup.
> 
> Thank you for this patch!
> 
> > 
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > ---
> >  Documentation/admin-guide/mm/damon/reclaim.rst | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
> > index ec7e3e32b4ac..23fede7d1cdb 100644
> > --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> > +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> > @@ -193,6 +193,13 @@ DAMON_RECLAIM becomes inactive, so it does nothing but periodically checks the
> >  watermarks.  In the case, the system falls back to the LRU-list based page
> >  granularity reclamation logic.
> >  
> > +To keep DAMON_RECLAIM always active regardless of the free memory rate, set
> > +``wmarks_high``, ``wmarks_mid`` and ``wmarks_low`` to ``1000``, ``1000`` and
> > +``0``, respectively.  Then the reclamation is limited only by ``min_age`` and
> > +the quotas.  This is useful for reclaiming cold pages even while the system
> > +has plenty of free memory, e.g., right after an idle virtual machine is
> > +paused.
> > +
> 
> I feel like above might be too detailed.  Particularly, the second sentence
> looks too detailed.  In a sense, it is not technically correct because of
> 'skip_anon' parameter.  We might later need to add more such controls, and I
> concern if this kind of detailed documentation will limit such extensions.
> 
> What about keeping only the first sentence and dropping later two sentences?

If you don't mind, I could add this patch to damon/next after dropping the last
two sentences on my own.


Thanks,
SJ

[...]
