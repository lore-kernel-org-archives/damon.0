Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD40155C82
	for <damon@lists.linux.dev>; Sun, 26 Apr 2026 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777244937; cv=none; b=OPXApofb6YNG40+rhtSaSjVtIkUJBSu3OjF9T5bjDB2blGCLlcQQ+nwncn+LsTMxhvnaKakRxOOV5QIJnE6vEibO9tMQZ+gqjA6slJHG125aZas7sxMNlj2XRCrklDXJMcTR5W/NL669YIhqcOR+EWr9NuYqXsHK4nH5DKUXI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777244937; c=relaxed/simple;
	bh=VTklXfli6AFS86blPQg1TvRJfrbpLuB1dOVS0CQ4mbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPLl/OjWuxfeQamS/PJ+zao5/65KawXclp7AsWWYg84SMzFNhCnqSwwrdNksmW7wdy7uxYEFKvtOzpw++k5J3OEEbu3J2cMc2hg8yn9CBCgbxxOg4CkgCOmm5fuO7QVjUznCmX7Ff1mggrdF3zSG4J+A/MU+DBd9WwtBz7SlMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ3fN5T2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ3fN5T2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE07C2BCAF;
	Sun, 26 Apr 2026 23:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777244937;
	bh=VTklXfli6AFS86blPQg1TvRJfrbpLuB1dOVS0CQ4mbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJ3fN5T2l2shc8PAeydP4ViYC6g+AqOM9bXtMpYErw2eUxw7i9dcDAtxMtO64Eqgl
	 nPdAqISQpIx45QWZX0DAiakHcxGLcS9x5q3rD4rDk1e2NWkAMC8uam2q0erEeNYU6k
	 sUEybCiaHjkmrK3v7OJzRAH89HrBiUm9kcQRBIyTMHi0xerzxADeUKATLB0CihXxWb
	 mzjQN7m2h8m+WMmlf4x2ne90ouNo07gHJ3ZWtBVoLd2uLIfcE1dm0bfUwHGWaNiz9D
	 c7GBo/Dywp6dgNOthplPY4PlDuiGqy5dco+UGCOopLFbKqM0IuNfJJ0bv0NhdZyslB
	 j56NoSqqqs87Q==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Ravi Jonnalagadda" <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH v9] mm/damon: add node_eligible_mem_bp goal metric
Date: Sun, 26 Apr 2026 16:08:44 -0700
Message-ID: <20260426230845.106371-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426220409.95B26C2BCAF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 26 Apr 2026 22:04:08 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 4 potential issue(s):
> - [High] Missing `cond_resched()` inside the inner address-scanning loop causes CPU soft lockups.

Unlikely.

> - [High] Direct use of `mult_frac()` with 64-bit `phys_addr_t` causes a linker error on 32-bit architectures with PAE.

Good finding.  Read below for detailed answer.

> - [High] Integer overflow in `mult_frac()` on 32-bit systems without PAE leads to incorrect metric calculations.

No real issue.

> - [High] Unbounded O(N) page-by-page memory scan in quota evaluation breaks DAMON's low-overhead design.

Intended behavior.

[...]
> > +static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *c,
> > +		struct damos *s, int nid)
> > +{
> > +	phys_addr_t total_eligible = 0;
> > +	phys_addr_t node_eligible;
> > +
> > +	if (c->ops.id != DAMON_OPS_PADDR)
> > +		return 0;
> > +
> > +	if (nid < 0 || nid >= MAX_NUMNODES || !node_online(nid))
> > +		return 0;
> > +
> > +	node_eligible = damos_calc_eligible_bytes(c, s, nid, &total_eligible);
> > +
> > +	if (!total_eligible)
> > +		return 0;
> > +
> > +	return mult_frac(node_eligible, 10000, total_eligible);
> 
> Can this cause a linker error on 32-bit architectures with PAE?
> 
> On 32-bit systems with CONFIG_PHYS_ADDR_T_64BIT enabled, phys_addr_t is a
> 64-bit integer. The mult_frac() macro performs native division using the
> type of its arguments. Since the kernel does not link 64-bit division
> routines (__udivdi3) on 32-bit platforms, this will cause a build failure.

Heh, good finding.  I suggested a fixup on my reply [1] to the patch.

[1] https://lore.kernel.org/20260426230322.106206-1-sj@kernel.org


Thanks,
SJ

[...]
