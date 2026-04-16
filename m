Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2C30EF64;
	Thu, 16 Apr 2026 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776312796; cv=none; b=TlBElCWOKnU/L2klbPqZ9ub0QxmupSBZ4KyEZM/jFFRyeG3oTyhX2ek3hZak0UzvST1F93fHyCVJuu800eb/v7zFjTIGZpibC3AIUV/Tgn741KqtZpVGb8Q3/+LYy+17+4Vqo+pRjyboEkXntsSIJUjxjYC58BAQIJA3HjVXaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776312796; c=relaxed/simple;
	bh=vD/gcfMzRsuavrVDfqMZ9Hv/UoqXXZdxe2zTSNX13zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrsKP9z85gab3HhRhQ4Jm34JA2y4+ukZ7tkLFw8mNxOdv8IkoH6E0q6n3nPet64lB3mfc1nnTZXSe2cpJb1M21kC/Ydt6gsyC79UtlobOv8AhYBCu0swiwOM8lW2olUZ8MG9RUmtK753G5Lqt2SwK1rrnkMAWcsCeCy2jhP3P3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a68wlh3T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a68wlh3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8FCC2BCB4;
	Thu, 16 Apr 2026 04:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776312796;
	bh=vD/gcfMzRsuavrVDfqMZ9Hv/UoqXXZdxe2zTSNX13zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a68wlh3TrNLWL226PEY2wRj8qC4CEkv1VGgX2ByJ5PesKDTKVok/onKStNEgl2RCE
	 tUrM4MT4GSwLuSiJV2sP9f0xYPjHM68sulgAq09yIEAwItHHUqVy2Yp5HxdusOjmbZ
	 hblkQvYk7pCUiyVXWLBsTbbeTfgK7MIl0/zjQAbPiLgCfpSpmgyYJ3ntZs1gyvs77v
	 aEOEaTUeyD5J2QrFiJOJjdg3UCFofNhF63gKQ52CrfErnj4CuC7QofgxFPka9BMbah
	 d4y5NT19OcRG736N248zx1JwAAM5uRvBft0nC1S6AwI50XIQ42bB6JyKFlTHAxsTyw
	 IRURg95W4VlpA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH 1/2] mm/damon/stat: add a parameter for reading kdamond pid
Date: Wed, 15 Apr 2026 21:13:05 -0700
Message-ID: <20260416041306.88803-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414053742.90296-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 Apr 2026 22:37:41 -0700 SeongJae Park <sj@kernel.org> wrote:

> TL; DR: Sashiko found a bug of this patch; I will fix it in the next revision.
> Sashiko also found one issue in the existing code; I will work on it
> separately.

No, I was wrong.

> 
> Forwarding full sashiko review in a reply format with my inline comments below,
> for sharing details of my view and doing followup discussions via mails if
> needed.
> 
> > # review url: https://sashiko.dev/#/patchset/20260414045002.88110-2-sj@kernel.org
> > # start of sashiko.dev inline review
> > commit fc6c9ec12df0df57fcce5c90c7a0604cddb1cc78
> > Author: SeongJae Park <sj@kernel.org>
> > 
> > mm/damon/stat: add a parameter for reading kdamond pid
> > 
> > This commit exposes the PID of the DAMON_STAT kdamond via a new read-only
> > module parameter, kdamond_pid. It intends to set this to -1 when DAMON_STAT
> > is disabled.
> > 
> > > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > > index 99ba346f9e325..21fa04d95eeac 100644
> > > --- a/mm/damon/stat.c
> > > +++ b/mm/damon/stat.c
> > [ ... ]
> > > @@ -260,6 +269,9 @@ static int damon_stat_start(void)
> > >  		damon_stat_context = NULL;
> > >  		return err;
> > >  	}
> > > +	kdamond_pid = damon_kdamond_pid(damon_stat_context);
> > > +	if (kdamond_pid < 0)
> > > +		return kdamond_pid;
> > 
> > If damon_kdamond_pid() returns an error code, doesn't this leave the global
> > kdamond_pid set to that negative error code instead of -1?
> > 
> > Also, if we take this early return path, does this code leak the
> > damon_stat_context allocation? The error path just above it correctly
> > calls damon_destroy_ctx(damon_stat_context) and sets it to NULL.
> 
> Nice catch.  I will fix this like below in the next revision.

The kdamond_pid stale value question is indeed a nice catch.  But the
damon_stat_context allocation leak question is not.  It will be cleaned up when
damon_stat_start() is called again, by the cleanup logic at the beginning of
this function.  This is not a bug but an intended behavior.

[...]
> 
> '''
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c
> @@ -223,8 +223,12 @@ static int damon_stat_start(void)
>                 return err;
>         }
>         kdamond_pid = damon_kdamond_pid(damon_stat_context);
> -       if (kdamond_pid < 0)
> -               return kdamond_pid;
> +       if (kdamond_pid < 0) {
> +               err = kdamond_pid;
> +               kdamond_pid = -1;
> +               damon_destroy_ctx(damon_stat_context);
> +               damon_stat_context = NULL;
> +               return err;
> 
>         damon_stat_last_refresh_jiffies = jiffies;
>         call_control.data = damon_stat_context;
> '''
> 
> > 
> > >  
> > >  	damon_stat_last_refresh_jiffies = jiffies;
> > >  	call_control.data = damon_stat_context;
> > >  	return damon_call(damon_stat_context, &call_control);
> > >  }
> > 
> > If damon_call() fails here and returns an error, the caller will handle it
> > by setting enabled to false. Does this leave kdamond_pid holding a stale
> > positive PID instead of being reset to -1?
> 
> Nice catch, but not this patch's fault.  I will separately work on it.

I'm wrong here, too.  This is this patch's fault.  But, there is actually a bug
that pre-existed before this patch.  I was somehow confused.  That is, the
'enabled' value can also be stale, and it can make DAMON_STAT cannot be
restarted before the system is reboot.

I will hold this patch and fix the bug first.

Refer to my comment [1] on the next version of this patch, for more detail.

[1] https://lore.kernel.org/20260416040602.88665-1-sj@kernel.org


Thanks,
SJ

[...]
