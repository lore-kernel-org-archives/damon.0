Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109474;
	b=AmAauDGwdwKh7VOoH6kj4a0lNnBvNTgbmoCNSRaCqSGxlw7/8iAby5vIyhXDTANN+WGG
	 GNu6C+kRofvlH28pixF/MrnZ06n3ZLJwVs/lD9XPFIo6zT7+4aCXLKvUoDvX+70gXmRJ8
	 RgROpEfEsFKilr66dGJQqfA7udwrC9jbC/MIsk799v33WatGgpcF6GbpHKIUoud5KGdEF
	 c/eab7o+AYeUZZxv2Q2EUWkO0Crwol8RdSObkOoDPZyQM0btC9qN8X00UxC6O+hz6EOrB
	 uZrwlhO7IwjnUmXrwkF0lbfDpC/zBuu100mCvxk1DIHGxTGAag668+nDBb8dxWCQE3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109474;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Oc9SGkKtJQTMDl5C3kvAcEmkGmH87ZOZUzIPqVhBwZ4=;
	b=swrywVHWZPae574EW+8Q0DCA1m6xAoQMva5FXBA2MK/p7Bz989ei8NTjGrY/3pcrKZWf
	 p1GdidJZDbuF+zoaRA9Vb0O45yW9gU1SoWn3sbh/aWpnu5IolkM4de2ON/mdijN5uLFsq
	 RWinfzwHlFM+jVRsOrAhD24T9HBo32LLELkjUjcSGZrIrYh1VjsID48MGKqpPcBaM6Ror
	 M6LX7h+UQAGI67IELmOdPu6LV4+x0A+2df5q0yw2tLTAsdy5gnL9GWP2IKgm2cRwpcbaQ
	 XA3A0ftGcj7Y1Xuz5nh1fpsm2OSTDaUgjy/+YNztyL1Ij3pJF1DSqaJ5M8y/13/bYig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ox1Of21z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA9E606A31E;
	Tue, 27 Oct 2026 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ox1Of21z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792D41F01825;
	Tue, 27 Oct 2026 13:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109474;
	bh=Oc9SGkKtJQTMDl5C3kvAcEmkGmH87ZOZUzIPqVhBwZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ox1Of21zf466valLKp99VgE6Npi2m7UHhoXKf5/TUQH6DnfElXxvgH+b8ifIMFE2v
	 xqW2zDm8NqAQ7dUm++XEnYWmeQzWP5RpgtM0B7TOTf24MP7EfMospsQZ7/sgzl/979
	 vhE16OirDAl6Fiz5ULpEB8KiUY4J+qgVXP2petQuujOnuEA+xirLoGwsa/G5YS10Zq
	 UjMG99NwwvwzJVx71/wKf3oLYTwbzySL4wz7xpZq1DiaCbcS3ysDJqgyOnxn9QO6Ze
	 WiBbCpZXOD3JoefiyU+yrAom6HW/pMrLrpG6QLJ3VFXugz2MLttS/vNNt6GjjTg223
	 ccDppjdY79y8A==
From: SJ Park <sj@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/reclaim: allow disabling watermarks to force reclaim of cold pages
Date: Tue, 27 Oct 2026 06:57:45 -0700
Message-ID: <20261027135746.150166-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6e381f14-f00b-4c0d-8499-f5a5f37b2572@huawei.com>
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

On Tue, 27 Oct 2026 17:46:11 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> 
> 
> 在 2026/10/20 21:58, SJ Park 写道:
> > Hello Jinjie,
> > 
> > On Tue, 20 Oct 2026 21:32:33 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> > 
> >> DAMON_RECLAIM runs its scheme only while the free memory rate is in
> >> [wmarks_low, wmarks_mid].  Reclaiming cold pages raises the rate, so the
> >> scheme self-stops as soon as memory looks plentiful again, which is wrong
> >> for a VMM parking an idle sandbox that wants cold anonymous pages
> >> reclaimed immediately.
> >>
> >> So add an ignore_wmarks module parameter. When set, the scheme uses
> >> DAMOS_WMARK_NONE, so damos_wmark_wait_us() always returns zero and the
> >> scheme stays active, bounded only by min_age and the quota.
> > 
> > I agree there could be use cases that doesn't want the watermarks at all.  I'd
> > like to avoid adding new DAMON_RECLAIM parameters if possible, though.  That's
> > becasuse DAMON_RECLAIM is introduced to let people use it without complicated
> > setups.  We will of course add new parameters if really needed, but I want to
> > see if there is a good alternative.
> > 
> > Have you considered some other alternatives?  For example, could respectively
> > setting wmarks_high, wmarks_mid and wmarks_low to 100%, 100% and 0% effectively
> > disable watermarks?  Have you tried that?  If that works, how about updating
> 
> Hi SJ,
> 
> Yes, it does for my use case.

Thank you for confirming.

> 
> > document to clearly explain the usage?  Also, have you considered using DAMON
> 
> Thank you! I will send a patch to update the doc later.

Looking forward to your patch!

> 
> > sysfs interface instead of DAMON_RECLAIM?
> 
> DAMON sysfs can also do this with "none" watermarks. But I want the
> simple DAMON_RECLAIM for only proactive reclam.

Thank you for clarifying, that makes sense to me.


Thanks,
SJ

[...]
