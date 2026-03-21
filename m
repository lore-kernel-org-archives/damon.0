Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D97361679;
	Sat, 21 Mar 2026 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774123837; cv=none; b=ppjPOjpeXmPoOx96/nKp6N83XBQwvxYIsem1OkUzjiQihoQkc4Te2/hoGjLNzn0usj9Z9lNdNwsSoFTWrMx77djQFTVK3diRLtY83k/yXAgm+zaKe+Gi/6VAB9vHDES8DZJ5y8G/Ypvtr/Emrje2EI9TeLNprf283+mmf87icks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774123837; c=relaxed/simple;
	bh=OxaNBhdTjMauWWAcWeiZVLFc97MstGfxacW4qKz5Lxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYcJfa5SnRrH9clMjnsywFrvVys2/aXJQZ2w8B+d2yUMEylltmUPlbw6S1+68sgHK6lNEr2xfBwKAnOVhYkptweVDPFcqMHfBneLi2JeUoSzoDWH5DTugqM7pyJcBW2Scki799LWCAE4gclT7BRekE1SmV7FidFEgnErn4nGoWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBgdRi4W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBgdRi4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAC1C2BC87;
	Sat, 21 Mar 2026 20:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774123837;
	bh=OxaNBhdTjMauWWAcWeiZVLFc97MstGfxacW4qKz5Lxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBgdRi4WLL5c6IT9JCcsrC3Etn/VrD/bX+BZIoS+CjgstzmHcjujz5l97WL5TfpU7
	 fAt65hh/gBSEh7fM/KYlHa/u1aaxXTfsEBHQyH1wme0LH2ljNatZyN30ZmxATx78gL
	 JZfniWKCAfrN7cvGOxmeF2Gf7X0lcDP47sjIujCXJgqhIqKWa6IPJ/tv+yL55ustIn
	 nt09wisv7/gsy7cps6+JtqYwox32NOYU1QqKVkgaqXZ2HIXmgdWvpaao3ihRDcorQh
	 /gByy1jglZnEIABPB9WGbpWi94BjrBQq/Y7DI808G3cOWeXO9XhkAwVbIX58pl48Vu
	 cEpM+0qu4YhpA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Josh Law <objecting@objecting.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 3/3] mm/damon/sysfs: check contexts->nr in repeat_call_fn
Date: Sat, 21 Mar 2026 13:10:28 -0700
Message-ID: <20260321201029.95644-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321200522.95395-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: no blocker for this patch is found.

On Sat, 21 Mar 2026 13:05:22 -0700 SeongJae Park <sj@kernel.org> wrote:

> Subject: (Sashiko) Re: [PATCH v3 3/3] mm/damon/sysfs: check contexts->nr in repeat_call_fn
> 
> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260321175427.86000-4-sj@kernel.org
> # start of sashiko.dev inline review
> commit 349107c02ee8a122119ac77a51451bb3d9311a34
> Author: Josh Law <objecting@objecting.org>
> 
> mm/damon/sysfs: check contexts->nr in repeat_call_fn
> 
> damon_sysfs_repeat_call_fn() calls damon_sysfs_upd_tuned_intervals(),
> damon_sysfs_upd_schemes_stats(), and
> damon_sysfs_upd_schemes_effective_quotas() without checking
> contexts->nr.  If nr_contexts is set to 0 via sysfs while DAMON is
> running, these functions dereference contexts_arr[0] and cause a NULL
> pointer dereference.  Add the missing check.
> 
> Link: https://patch.msgid.link/20260320163559.178101-3-objecting@objecting.org
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index ddc30586c0e6..6a44a2f3d8fc 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -1620,9 +1620,12 @@ static int damon_sysfs_repeat_call_fn(void *data)
> >  
> >  	if (!mutex_trylock(&damon_sysfs_lock))
> >  		return 0;
> > +	if (sysfs_kdamond->contexts->nr != 1)
> > +		goto out;
> >  	damon_sysfs_upd_tuned_intervals(sysfs_kdamond);
> 
> Does this code cause starvation or incorrect statistics when multiple
> kdamonds are active?
> 
> It appears that damon_sysfs_next_update_jiffies is declared as a static
> global variable and used by this function to throttle updates:
> 
> static unsigned long damon_sysfs_next_update_jiffies;
> 
> static int damon_sysfs_repeat_call_fn(void *data)
> {
>     ...
>     if (time_before(jiffies, damon_sysfs_next_update_jiffies))
>         return 0;
>     damon_sysfs_next_update_jiffies = jiffies +
>         msecs_to_jiffies(sysfs_kdamond->refresh_ms);
>     ...
> }
> 
> If multiple kdamonds run concurrently, wouldn't they all share and
> overwrite this single global timestamp?
> 
> If one kdamond sets the timestamp to a future value, another kdamond's
> thread might incorrectly evaluate time_before() to true and skip its
> update, potentially leading to starvation and incorrect sysfs
> statistics for all but the winning kdamond.

I answered this in the previous version of this patch.  In short, good finding
but not a blocker of this patch, I will work on it.

> 
> >  	damon_sysfs_upd_schemes_stats(sysfs_kdamond);
> >  	damon_sysfs_upd_schemes_effective_quotas(sysfs_kdamond);
> > +out:
> >  	mutex_unlock(&damon_sysfs_lock);
> >  	return 0;
> >  }
> 
> Could there also be a memory leak of repeat_call_control in
> damon_sysfs_turn_damon_on() if the target kdamond exits early?
> 
> In damon_sysfs_turn_damon_on(), repeat_call_control is allocated:
> 
>     repeat_call_control = kmalloc_obj(*repeat_call_control);
> 
> If the kdamond thread encounters an error or has no work, it can exit
> and set ctx->kdamond = NULL before damon_call() is fully executed.
> 
> In this race window, if damon_call() detects that the context is
> inactive it calls damon_call_handle_inactive_ctx(). This removes the
> control from the list and returns -EINVAL, but it does not free the
> memory.
> 
> Because damon_sysfs_turn_damon_on() ignores the return value of
> damon_call(), does this result in a permanent leak of the memory
> allocated for repeat_call_control?

I answered this in the previous version of this patch.  In short, good finding
but not a blocker of this patch, I will work on it.

> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260321175427.86000-4-sj@kernel.org


Thanks,
SJ

[...]
