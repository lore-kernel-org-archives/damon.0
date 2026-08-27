Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6B535F5F8;
	Thu, 27 Aug 2026 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787801893; cv=none; b=ORgIPbDAEb3YBTp1FAMFiKi8lnZQGsEGc29QyRO5aQQC6L9x1NnhlI1VneFpKt9G2cGJJbfYjKHBr9fhqfzHW0pnkpw8vj61nO+WjkK19PmG57ypRs4oCECxpeNV6ppe92l3KVEFSnzWz3SsgL2gTSxbkwJQbNmmPGdCtmx/u20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787801893; c=relaxed/simple;
	bh=g5eTbeyaFwMQv6+VWTLvGXuFzgzDx/Qub9ihtnGAQWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ezpl+AsEn04+2//VDN1iVncUoTtpCARcsn/E5pnm7QaHldFAmL77DVrCxD3DOpmb9oJwnt8bvrcTd5P+DTAygeglY4VUX6Q9RQ49D7zNUB/9oZMk6tSta9GPmxyWmffXcsE5GtNFsb1lj0aSccU5R5pu0OoBnN9Z0xOu0Gombv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLijvmtT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLijvmtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C0C1F000E9;
	Thu, 27 Aug 2026 03:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787801892;
	bh=qktSdDuw+LvPQ8hF169l4fiZgm7L5YFz3tdhT11hID0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KLijvmtT4ozmnssDASNKKsX3XX1TGW48Lwt5kfA58YlXdV3+dCXmMJwhafGn53ZJ0
	 aPWVLvqndAuLVjEO+VEjByrS+Z5gIfgfo6h9GHqHicV0PBDhuRH6qGoUhLjmBfQYnV
	 /FfEsqMQdYF7wWcaGveByfi52Urf/mGKKaPTnQHK5MYWl3o9N62CCOBEd/eXd/aDLQ
	 D27ks91tVY58VBPF2gc3RsMpxBUHyfO8LbcZ5g7u2cL9n3n8s7yWXzOvRA0Y324Xx7
	 lgPAOlwzf2DJM+nkN6bA/jhQbbm9xMM/U/VDAWFvRTFwzROwQ5s6HKlqmrrhrVjq6f
	 Dh8CUancv59Fw==
From: SJ Park <sj@kernel.org>
To: zhaozhengzhuo@uniontech.com
Cc: SJ Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/damon: prevent remaining cross-object state pollution
Date: Wed, 26 Aug 2026 20:38:04 -0700
Message-ID: <20260827033804.89392-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <38E4AAAAEDFCC283+20260827021515.1316838-1-zhaozhengzhuo@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello zhaozhengzhuo,

On Thu, 27 Aug 2026 10:14:52 +0800 zhaozhengzhuo@uniontech.com wrote:

> From: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> 
> _damon_sysfs.py defines constructors with mutable default arguments,
> including DamosAccessPattern(), DamosQuota(), DamosWatermarks(),
> DamosDests(), IntervalsGoal(), and empty lists.
> 
> Default arguments are evaluated once at function definition time.
> Damos() instances created without explicit arguments therefore share
> the same DamosQuota(), and the other default-constructed sub-objects
> and lists are shared in the same way.  The sub-objects keep
> back-pointers to their owner scheme, so constructing the second Damos()
> rebinds the shared quota's scheme pointer to the second object.  An
> item appended to one object's default contexts or filters list is also
> visible from other default-constructed objects.
> 
> The shared state can corrupt test configurations.  DamosQuota.sysfs_dir()
> derives the sysfs directory from its scheme pointer, so operating on
> the first scheme's default quota may write to the second scheme's
> directory.  The wrong values often match the defaults, so tests still
> pass, but the behavior depends on object creation order.

I agree all the points.  This should be fixed.  That said, these are only
possible future issues.  No existing test is broken, right?

> 
> Commit 8319dadcbd81 ("selftests/damon: prevent cross-context state
> pollution in DamonCtx") fixed the same pattern in DamonCtx only.  Fix
> the remaining constructors by defaulting to None and creating fresh
> objects or lists inside each constructor.  Explicit arguments keep
> their previous behavior.

Thank you for fixing this, looks good to me!

> 
> Signed-off-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
