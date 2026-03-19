Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD5F9C0;
	Thu, 19 Mar 2026 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930683; cv=none; b=i09DZ8vD94nRpb8MlDDqPpnxXuVrXJUxxYhZJtX4PdQOQIh7wXhoaIqyTEplD+awXFm3JrTmTAqp2ttqTHZt3SQ+STd5ajTcuxkxxWpoMIDk9GaUtp4HK3lxqqw03MaRMyvdWc8JXVizi6yEhxqXJjo/6M0JoCE1LDMOacgOZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930683; c=relaxed/simple;
	bh=h5Aa5pRSR7eKNJFLVE6Af15Uj6701Id7RhmHu3jhLXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrMUoaiwHs5gWwujsPDA/ov3JsNDmrMS70MpVffOER6rtzkTkVmJFYb19Yywr4LlT/4o3Q/e4VhrRNcsZ/k8iUVD9zKwFIZJuCmhYE6kI9XuErx9eLE9xODl9GF9aNFxMmb1fUXoBnEazFBJm1a/i6vWLV3Zczjga5XiEjTFJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbkoqjlB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbkoqjlB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13EEC19424;
	Thu, 19 Mar 2026 14:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773930683;
	bh=h5Aa5pRSR7eKNJFLVE6Af15Uj6701Id7RhmHu3jhLXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbkoqjlBACSHhUzBH9DGqtKAeX+2K/xHxxe01kPTQVUJNF2ik9tbfXUyaRlZAqmWc
	 j4qgcpRUnYEAprDTsczHdpo2OxjRjywi1UIzoAlk3NmS0oggdV0O8EDLV8LyVtSSdU
	 m/3xmLXWUzHjX0sP2GXpyviT9wA/M5NlIWnYyljQNK+Mxt5mc4neynaNv1cXpJlMzH
	 y5MsTQkMkGlAe3fDO5eG9xYLXGKjpl4AN6ubRLFlg1IaU2Qy3/BnRlf6aL2jQ0HcYx
	 sWC0kv8D2LThrvuoQfPpFs/dmAcfNBIeG0GIr6C3Hq7+3iEUOHxl+768Fd1E36HI/z
	 XC3ciJEzo+hlA==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: document damos_commit_dests() failure semantics
Date: Thu, 19 Mar 2026 07:31:14 -0700
Message-ID: <20260319143116.82849-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319071332.114595-1-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Josh,

On Thu, 19 Mar 2026 07:13:32 +0000 Josh Law <objecting@objecting.org> wrote:

> Add a kernel-doc comment to damos_commit_dests() documenting its
> allocation failure contract: on -ENOMEM, the destination structure is
> left in a partially torn-down state that is safe to deallocate via
> damon_destroy_scheme(), but must not be reused for further commits.

Nice patch.  We intentionally do not use kernel-doc comment for static
functions, to not encourage API document readers use the non-public functions.
We still use kernel-doc like comment for static functions, to help developers.
That is, starting the comment with '/*' instead of '/**'.  Maybe 'damon_call()'
is an example.

> 
> This was unclear from the code alone and led to a separate patch
> attempting to reset nr_dests on failure.

Good point.  Adding a link [1] would be nice.

> Make the intended usage
> explicit so future readers do not repeat the confusion.
> 
> Signed-off-by: Josh Law <objecting@objecting.org>

Other than the above trivial things,

Reviewed-by: SeongJae Park <sj@kernel.org>

I added this patch to my tree, after addressing my above comments.  If you
don't mind, I will post it tomorrow as a v2, for mm.git inclusion.  If you have
different opinions to my comments or you prefer to post v2 on your own, please
feel free to do so :)

> ---
>  mm/damon/core.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index e233eb84a2d5..c884bb31c9b8 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1054,6 +1054,23 @@ static void damos_set_filters_default_reject(struct damos *s)
>  		damos_filters_default_reject(&s->ops_filters);
>  }
>  
> +/**
> + * damos_commit_dests() - Copy migration destinations from @src to @dst.
> + * @dst:	Destination structure to update.
> + * @src:	Source structure to copy from.
> + *
> + * If the number of destinations has changed, the old arrays in @dst are freed
> + * and new ones are allocated.  On success, @dst contains a full copy of
> + * @src's arrays and count.
> + *
> + * On allocation failure, @dst is left in a partially torn-down state: its
> + * arrays may be NULL and @nr_dests may not reflect the actual allocation
> + * sizes.  The structure remains safe to deallocate via damon_destroy_scheme(),
> + * but callers must not reuse @dst for further commits — it should be
> + * discarded.
> + *
> + * Return: 0 on success, -ENOMEM on allocation failure.
> + */
>  static int damos_commit_dests(struct damos_migrate_dests *dst,
>  		struct damos_migrate_dests *src)
>  {
> -- 
> 2.34.1

And Sashiko comment [2].  TL; DR: Good finding.  We aware the issue and working
on the fix.  Nonetheless, that's out of the scope of this patch.

: Does leaving dst in a torn-down state cause a NULL pointer dereference in
: the background kdamond thread?
: 
: If damon_commit_ctx() fails during damos_commit_dests(), the sysfs update
: aborts. However, the broken scheme remains active in kdamond->damon_ctx
: because damon_commit_schemes() does not remove or destroy dst_scheme on
: error.
: 
: When the background thread calls kdamond_apply_schemes() and invokes
: damos_va_migrate_dests_add(), it iterates based on the unmodified nr_dests:
: 
:     for (i = 0; i < dests->nr_dests; i++)
:         weight_total += dests->weight_arr[i];
: 
: Since weight_arr is NULL but nr_dests retains its old non-zero value, will
: this unconditionally dereference the NULL pointer? It appears the previous
: patch attempting to reset nr_dests on failure might be necessary to prevent
: this crash.


Nice catch.  We actually figured out [3] this issue from the discussion on
Josh's previous patch that motivated this one.  And I'm working on it.  Because
the issue is arguably orthogonal to this patch, I think this patch is good to
go.

[1] https://lore.kernel.org/20260318214939.36100-1-objecting@objecting.org
[2] review url: https://sashiko.dev/#/patchset/20260319071332.114595-1-objecting@objecting.org
[3] https://lore.kernel.org/20260319043309.97966-1-sj@kernel.org


Thanks,
SJ

[...]
