Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050727AC2F;
	Mon, 15 Sep 2025 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961791; cv=none; b=mWnj2JX3MHnT3wJuKxhv6ztuAyTLOilRm8tLBY/Dfk6+velrsR/3EwJ93ey8SeRIVwbC7i5HKJjpUT6rzuUemGh2Lt8TAno6Y7+2Hm4VZjnCH6aeZ2Cq/FnYdEHBP1XE94G3HIpmwGAEVDN4NPr7b0TJEqYwOQy/cjtjfVhknOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961791; c=relaxed/simple;
	bh=aeSPb7UYuvV9fS41JrUTDI2+bisGhOXstOy+yk8seuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rJP6+qPjh6QsBI3B3HdvjZBQZlHoiJxc4y4AwdbSJD/WYtsOrYKHi3xXTPjNJiz+LYotH4KYizvB1m2UkukZDb/2mKxCx2o85QOPXgnEdCqqTRf8wedL7EvuklV2Ijvy40XrrZReDrIuQwLd5WwIIl69heOn2Fox6pmvXzj3M1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2HwtNAQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2HwtNAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B85AC4CEF1;
	Mon, 15 Sep 2025 18:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757961790;
	bh=aeSPb7UYuvV9fS41JrUTDI2+bisGhOXstOy+yk8seuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e2HwtNAQTxZUrWnS7dLonZJwz1gbzG0AwzJ+pVU4HVSml+vssWgfxld1bAUZtyRS4
	 KWbXINTvCZLgmCDZOdr8oosrGiFKG0pNZjW776jebqfR2oTINGZkdu20EVa6eZdoqf
	 ZREVi0bsHGfJvWNupHnPrkZUF2Td/QxiAatf1H+ud1wRFaVIAfM+yPHumFvKwOXWLF
	 rhIBSZFkUr1OupbGGfyjz0OhurfPoR3Xq1BWvAQoIn5S0CTBlNoGurI2qt5y21NURL
	 Gy9jHuBgVKtauKpLjEvltrqGYU4gxLpMXT2oaSmKPS7Wf+uJ6CzCYAEmGxj8sw3ywS
	 LCRUjUApIpuvg==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/6] mm/damon/lru_sort: use param_ctx correctly
Date: Mon, 15 Sep 2025 11:43:06 -0700
Message-Id: <20250915184306.110418-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915150548.1486984-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 08:05:47 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Sun, 14 Sep 2025 18:58:04 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > damon_lru_sort_apply_parameters() allocates a new DAMON context, stages
> > user-specified DAMON parameters on it, and commits to running DAMON
> > context at once, using damon_commit_ctx().  The code is, however,
> > directly updating the monitoring attributes of the running context. This
> > doesn't cause a real user problem but apparently this is an
> > unintentional mistake that can cause code review confusions and future
> > real problems.  Fix the wrong use of the parameter context.
> 
> Hi SJ,
> 
> Thank you for the patch! I am a little bit confused by the behavior in
> damon_lru_sort_apply_parameters. I was hoping that you could help me understand : -)

Thank you for sharing this Joshua!

> In particular, I think that this patch fixes two possible user visible errors.
> 
> My understanding is that we want to make changes to the param_ctx first,
> validate the changes, and commit these changes to the global ctx struct at the
> end. In the middle in the errors, we can abort the operation without committing,
> and ctx will remain unchanged.
> 
> So to me, it does seem like the current code could lead to some visible effects
> from the user's perspective (error-handling case).

damon_set_attrs() has its own parameters validation.  If the validation fails,
it returns an error.  damon_commit_ctx()'s internal validation for damon_attrs
parameters also depend on the validsation of damon_set_attrs().  If the given
parameter is invalid, damon_set_attrs() will return an error without committing
the change, so there should be no user-visible behavioral difference.

> 
> Also, I am a bit confused by how the commit is currently called. We have
> err = damon_commit_ctx(ctx, param_ctx), where the first argument is the
> destination and the second argument is the source. There is a bit of a mismatch
> because in the current code we have the following:
> 
> +------------------------------------------------+
> |              ctx                    param_ctx  |
> +------------------------------------------------+
> | New &damon_lru_sort_mon_attrs                  |
> |                                     New scheme |
> | attrs overwritten to NULL	  <--            |
> | scheme rewritten to new scheme  <--            |
> +------------------------------------------------+
> 
> So in particular, the global ctx will never have the correct attrs pre-patch,
> since it will always be rewritten by param_ctx, which never had its attrs
> initialized.
> 
> I hope this makes sense : -) All of this is just to say that this patch does
> more than just improve review confusions -- I think there at least two errors
> that this fixes for the user. So perhaps a more descriptive commit will be
> helpful in the future, since we are also adding a fixes tag?

Makes sense, thank you for finding this Joshua!  I will send v2 of this patch
with updated commit message!

> 
> Thank you again for the patch, SJ! Feel free to add:
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Thank you!


Thanks,
SJ

[...]
