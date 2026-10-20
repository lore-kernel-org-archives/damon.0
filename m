Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508705;
	b=G9d5LdL2yvtw4Sf50sC0l24befjyERhsc/KN8K+VtVPnR2N0pf+5E5TuZTHzGmM91Z3r
	 hmw43MexgbiQce4CjI2A3mkYrWQ2l+8KTdGMtqw4WDqFeoRQya5A4Ovn1Frv6l2tsxyzl
	 xl2oewya+eNTjABgA3ebumoZtYDsNRuQxzP6PRA17eSxaIHNuIA8uOIAvDzooWRiWrdes
	 7zhMabszHvvsYpHOn5V7avMcis3DoC2S4su53H5Vd3BfLcoHL9GiONEr5e9ZNFrLxRyLi
	 kucC6X5xU0/tFR/hy0IMJ56PO3H22HpXcrKYOBdVfYgjeqR1L0hdIhcDbN7goB3e9Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508705;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IeTkxtK9f/H2exSxElwuEwWkTqWW/9vOEjR8TQV4/fQ=;
	b=u/3eDUQHELuoVyxzc84r9DsUUjgw3ok7uUQPXVLpfN4SkfbRlcU1TO7TerZhqgSLnMDY
	 lq7GCKLuFxHmk0BQVIjOXew/pakGKbvPlh5RFgk5zRi1HYdObrpICQHG3qo2JGdQykXKT
	 ED3DQwtDJaaGzbBZmDgsL6mYBh6nK6gr4zlk93DQpGHvb9a2dnzajV2RT9VRXqCIDcEdb
	 T4ojiYRhbYkhbo5x83SKiVIjXIl8cDqTPwPE9YzMLNuhnaszZf0fxGHXMvY1XVJ/D5eVS
	 HlGkUmYVG41pqpMboApCtzLzCL+ODN3qSU4DnbDRydG+FGyyq0hJVkPTEMJSZ9qipcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXXraiGt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5D606A31B
	for <damon@lists.linux.dev>; Tue, 20 Oct 2026 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXXraiGt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7102A1F000C5;
	Tue, 20 Oct 2026 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792508704;
	bh=IeTkxtK9f/H2exSxElwuEwWkTqWW/9vOEjR8TQV4/fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kXXraiGtzkkqFew9mZGiB5EamfG90+9VavaSRrk2C5yA/eLSi9D1r7mXgjIGbh+Pq
	 crjXDLCNBs5QS3S2KLPAxcw2ELXRmfDMhGOgJwbkihP9f5bk2xJ3T5bzxK4WVGTk+H
	 ER6NokF7DaeYbrk0sbYUrYJtoRibKKYHZVr8dm4PZRoKbWOMqnWCptR/k/hUvUHRel
	 +Ook3S6Z9VipyOPJXNssV2PnT+vvinXEAB281X5XfMXp1I1IN6Z+bgP0bMO0mz3d2D
	 AnQp7b3QSdqO8FFqJZ+SwiEpROaYdrziKh5MvCljvjnN6wHKvWJyvjrg+Uo6nWie1O
	 rOLuGhvJlSpvQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon/sysfs-schemes: hold damon_sysfs_lock in target_value_store()
Date: Tue, 20 Oct 2026 08:04:56 -0700
Message-ID: <20261020150457.89830-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-179201@kernel.org>
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

On Tue, 20 Oct 2026 14:54:16 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm/damon/sysfs-schemes: uninitialized stack read in target_value_store()
> --
> 
> commit f43fea0015fcb1917385f72d150c59603a9ae43c
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: hold damon_sysfs_lock in target_value_store()
> 
> This commit holds damon_sysfs_lock in target_value_store() while updating
> goal->target_value to prevent a time-of-check-to-time-of-use race with
> damon_sysfs_add_quota_score() that could result in a divide-by-zero.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 8f083611741fd..55298a17b653a 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -1355,7 +1355,13 @@ static ssize_t target_value_store(struct kobject *kobj,
> >  {
> >  	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
> >  			damos_sysfs_quota_goal, kobj);
> > -	int err = kstrtoul(buf, 0, &goal->target_value);
> > +	unsigned long target_value;
> > +	int err = kstrtoul(buf, 0, &target_value);
> > +
> > +	if (!mutex_trylock(&damon_sysfs_lock))
> > +		return -EBUSY;
> > +	goal->target_value = target_value;
> > +	mutex_unlock(&damon_sysfs_lock);
> >  
> >  	return err ? err : count;
> >  }
> 
> [Severity: High]
> What happens in target_value_store() if kstrtoul() fails (for example,
> returning -EINVAL or -ERANGE on malformed input) while damon_sysfs_lock is
> not contended?
> 
> Since kstrtoul() leaves target_value untouched on error and err is not
> checked before acquiring the lock, wouldn't this overwrite
> goal->target_value with an uninitialized stack value (which could also be
> read back via target_value_show())? Should err be checked and returned
> immediately after kstrtoul()?

Good catch.  I will check kstrtorul() error and return -EINVAL in the next
version.

> 
> []
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261020144726.88978-1-sj@kernel.org?part=1


Thanks,
SJ
