Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5190D19D074
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783286506; cv=none; b=jUNi8dRV38fz3g1oVXKV5z/vzz7HOT53kGD9lMXXJFL++lmayRhwJZY4SppseoxipGCAjvesuCBUlcCwAcKvIJGdPQSxOBeM2nWoZj5D+w8uBRv4iNe7JqV5QQ80g1L29up9eo6iiL3iEKwfZkvjPyo41DG9uXtOc74erFhxzOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783286506; c=relaxed/simple;
	bh=Frq2zTQzi4TG7050JLephB3m5az53GIXuzLjW+CuHj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IS/Lcg9cov1Crp+7JEZHUGdgmgVz0ooH/ibA5LwL3inV9rbsQOoytyqrzCQBZIpZnwP+3z9OcNKZHFU2StSxkdSUYVm4qEjdAm93QSKrs3sGv+bo05j8u/E4ffhI7Gxa3ACI57Pq7vubBmM65F/2a1Rf4Ml46QkRVCmjWBcm8QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed34Ilt/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed34Ilt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50D31F000E9;
	Sun,  5 Jul 2026 21:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783286504;
	bh=Lfvr62P2NeGA31saJAY76hT2rWg/mgRygkwt5NJ3TOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ed34Ilt/o+qKkmg67aBOBaGsm+RtjMInLUqsILtLLIXAW0PmzS7rtJUG4Yr6axNK+
	 BJWsDsgfMwAbmEY5JHsyjroMT1Wj8RtRk0n5PkT8f7X8OEV24rFeKVIm3UDY0iiVWZ
	 lFDffCS/CMOsDSowSQvpKS2JXeZ2ypg3ZYvxOtQo1LECzbHh6fH65dFXc1gXhD0oTl
	 QdrxP1dlgc5mh0JLReK1ZmPnYUlye0ySKoVypKWS1GHoz17Xv0Ph8ZRoiutVKhoyKy
	 dKvN6cmvLOOnfIVkNA6BExYaYoZefFw7Yj5FyFi+tkCUoVRLinIIsBkkvrpNTP+h8r
	 rNHMNghT4rdgw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 01/16] mm/damon/core: introduce damon_probe->weight
Date: Sun,  5 Jul 2026 14:21:33 -0700
Message-ID: <20260705212135.100131-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705210454.34FC51F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 05 Jul 2026 21:04:53 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing kernel-doc description for the new `weight` field in `struct damon_probe`.
> --
> 
> commit 4be82423c8a2e9beb3264e298ab3af6bd580eea9
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_probe->weight
> 
> This commit adds a new weight field to the damon_probe structure. The field
> is used to specify the degree of the API caller's interest in the data
> attribute of the probe.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 616bdf0954b52..257a4769296ab 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -763,6 +763,7 @@ struct damon_filter {
> >   * @list:	Siblings list.
> >   */
> >  struct damon_probe {
> > +	unsigned int weight;
> 
> [Severity: Low]
> Should the kernel-doc comment block above struct damon_probe be updated to
> include a description for the new weight field? Without it, running
> scripts/kernel-doc might emit a warning about the undocumented field.

Good catch.  I will add the comment on the next revision.

> 
> >  	struct list_head filters;
> >  	struct list_head list;
> >  };
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260705205743.98656-1-sj@kernel.org?part=1


Thanks,
SJ
