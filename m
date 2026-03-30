Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388AA2FE079
	for <damon@lists.linux.dev>; Mon, 30 Mar 2026 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913625; cv=none; b=XoS+jqywKafdhcxEc3slv9C5FB/7JlDojt17TAJcyVhFMXIX5JF0tHMY2menhhCg8bvgBxaJEw346sWvSLuCvi8crBTiNz6WtHkTThD/KRnd2im1ztCg850VTsMkQmoH6DyWcydlMIZgMpQiX5Yg49eRxd+QmQ8MvCb0DhqMVMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913625; c=relaxed/simple;
	bh=bS9/1OgZnrRu/Zb4l9Ojffim3IR9pNqgJXD8ZZMekog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjEKJI2KBYss8aHh2pDYrkDxjvFSiIcNxvjGbGmcq/TkMHbxTNJbGhsXLf1amXSKRRed+42deJJ9GjggZ2y2OxEwv2PvcBWLrLxixkAIR5FE4FcgYYMqX/69y91Z/HXgwS2wuol5E2P49B5At4CdCe0tM16RBAlkTg7Gssp7LVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aORs0BTj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aORs0BTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C153C4CEF7;
	Mon, 30 Mar 2026 23:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774913624;
	bh=bS9/1OgZnrRu/Zb4l9Ojffim3IR9pNqgJXD8ZZMekog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aORs0BTjmGynyzTyfZbg2Kktbj85u35tkqCgEbmiNjLwgYN6bE+fCEgU/829jrkMd
	 TAaKt9hENkyYMZzfpGzzWK4/b8xAdGCpBYAT9KC3D6Dkv8njGdDgJlIht5uRsiheUy
	 iQ2crtNCzeeUexf83KYkNlns46upGRczC/icgzkYP6nCfTpxP7pB25roXb6Tcb78QH
	 H0tyjCQV67fHeq0GR5+gvw09q5Nc7f0UHrnWKD9DIpUhtqvw3AS89JqbBGck4W3Gqg
	 A6rhIXhFjCEdWyrbFkZerh4tvHk0kkRKA3K8fM1vG2woVUH8yecgBrvULyZdEdRPKE
	 KvhZozAVxpKUQ==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Mon, 30 Mar 2026 16:33:42 -0700
Message-ID: <20260330233343.4083-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260330060851.4659-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 30 Mar 2026 14:08:51 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> On Sun, 29 Mar 2026 08:15:07 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Sun, 29 Mar 2026 15:51:07 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > [...]
> > > To confirm, are you suggesting something like the first approach [1]?
> > > 
> > >     if (input_addr_unit < PAGE_SIZE && !is_power_of_2(input_addr_unit))
> > >         return -EINVAL;
> > 
> > Yes.  But the real constraint is min_region_sz, so testing it would be more
> > simple and effective.  E.g.,
> > 
> > 	if (!is_power_of_2(param_ctx->min_region_sz))
> > 		return -EINVAL;
> > > 
> > > [1] https://lore.kernel.org/20260325071709.9699-1-aethernet65535@gmail.com
> 
> Thank you for the example.
> 
> The 'param_ctx' you mentioned confused me for a moment, as it doesn't
> exist in the current addr_unit_store().

I'd suggest to do the validation in commit_inputs handling path
(damon_{lru_sort,reclaim}_apply_parameters()), rather than addr_unit_store().
And param_ctx is in the path.

> But I assume you are suggesting
> that we should validate the result of 'min_region_sz' rather than the
> 'addr_unit' itself, and this check should happen within the
> addr_unit_store() callback.

That's correct.

> 
> So, would something like this in addr_uint_store() be what you expect?
> 
>     if (!input_addr_unit)
>         return -EINVAL;
> 
>     min_region_sz = max(PAGE_SIZE / input_addr_unit, 1);

damon_{lru_sort,reclaim}_apply_parameters() does this already.  And that's why
I suggest to put the validation there.

>     if (!is_power_of_2(min_region_sz))
>         return -EINVAL;

Yes, this kind of validation, but in
damon_{lru_sort,reclaim}_apply_parameters(), please.

Someone might argue it is better to return the error as early as possible (when
writing addr_unit).  But in my humble opinion, the benefit from the user
experience is not that big, while it could make code unnecessarily complicated.

Then someone could ask if we should also move the zero addr_unit input check in
addr_unit_store() into apply_parameters().  Yes, I think we should have done
that in the way, and I made a wrong decision at the time.  But, I think that's
not a big problem, so I would prefer keeping the code and behavior as is,
unless it turns out to be a real problem.

> 
> This keeps the fix local to the modules, and directly enforces the
> power-of-2 constraint on the actual monitoring granularity.

Yes.  But again, I'd prefer doing that in apply_parameters().


Thanks,
SJ

[...]
