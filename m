Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A32DC791
	for <damon@lists.linux.dev>; Sat, 18 Apr 2026 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776525281; cv=none; b=EBO9m8xARZoiMJ53uVZTgEuQZzpFNPKCfZ20aH0AOggkn6jcKWPk0OWhcyLe4ACPv82ujKSTVVWTOvul4fjJy41D+Y8DKad0KnUpBRqsnRDb9ca34WIMnhwL8hSbk913uaNEgrq3C6EloxPktVYvYhqQKpS/zakzSZ+6RrwD2nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776525281; c=relaxed/simple;
	bh=i9ZPojtKJTOBSVd8ECgd2ywsHFh0DMwOGHYKCayP5+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UN5qxil1Hri/IiXO88vW6sfzPP6JSFPwqfMZ3ctbJbKsHq6Tjb426oUr6B0Qw4Z6c+cyEZwJ1LPu+MaRaDPQuwFkea532flRIHqwnis4rMqMVdRgFyYhRyMaoQolngL2/dIt2UsakGdA12aA6zFFPlltpw7ttAscbEns2fS6MI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFD74qGm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFD74qGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B158C2BCB4;
	Sat, 18 Apr 2026 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776525281;
	bh=i9ZPojtKJTOBSVd8ECgd2ywsHFh0DMwOGHYKCayP5+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFD74qGm5C/bOFIizVjyVYdB2/Z8B2r+1TRZ+1N225S+44+AOjJgPkXQKR5sC2rgs
	 pUKA2+p/4HZxyPwwG0hAXVG8OYkBlNE1eX/MpeGaEaBkMkqnoGDOU7HyY92uPlidjN
	 hVL8ibPMUnlJ4nZwGYcbubgJkS8Eh8ErmHggB0+8nnPQPaFSYdc8DGxHyl902HREiH
	 langCdlK3i4sNOw1BYCNK6A+v1EY49V5BYGOIxUbobTmKlHDjQZiAwWvscCf9a/aP6
	 kHF7qgF2zpnMp6weubvpQ30Q4jqtmy1xzqwNHbedm1jtvSt6tvnj2MHik0Q70yIuyB
	 KBMtIzC+ygAjA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 1/3] mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
Date: Sat, 18 Apr 2026 08:14:37 -0700
Message-ID: <20260418151438.787-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418045715.EAF7EC2BCB5@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 18 Apr 2026 04:57:15 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [Medium] Command-line override for the 'enabled' parameter is broken: passing 'enabled=N' after 'enabled=Y' fails to disable the module.
> --
> 
> commit 6f46639cc34c6ddcbecc0aba915988dff8f651de
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
> 
> This commit updates DAMON_RECLAIM to dynamically query the running status
> of kdamond instead of relying on cached parameter values. This ensures
> that when kdamond stops unexpectedly, the enabled and kdamond_pid parameters
> reflect the correct state.
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 86da147786583..46660c8d4d422 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> 
> [ ... ]
> 
> > @@ -332,10 +316,16 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
> >  MODULE_PARM_DESC(addr_unit,
> >  	"Scale factor for DAMON_RECLAIM to ops address conversion (default: 1)");
> >  
> > +static bool damon_reclaim_enabled(void)
> > +{
> > +	if (!ctx)
> > +		return false;
> > +	return damon_is_running(ctx);
> > +}
> > +
> >  static int damon_reclaim_enabled_store(const char *val,
> >  		const struct kernel_param *kp)
> >  {
> > -	bool is_enabled = enabled;
> >  	bool enable;
> >  	int err;
> >  
> > @@ -343,7 +333,7 @@ static int damon_reclaim_enabled_store(const char *val,
> >  	if (err)
> >  		return err;
> >  
> > -	if (is_enabled == enable)
> > +	if (damon_reclaim_enabled() == enable)
> >  		return 0;
> 
> Does changing this check break kernel command-line overrides during boot?
> 
> During early boot when command-line parameters are parsed, ctx is not yet
> allocated, so damon_reclaim_enabled() unconditionally returns false.
> 
> If a system has damon_reclaim.enabled=Y in the boot parameters and an
> administrator appends damon_reclaim.enabled=N to override it, the first
> evaluation correctly sets the internal enabled flag to true.
> 
> However, when the second parameter (N) is processed, enable is false.
> Since damon_reclaim_enabled() also returns false, the condition matches
> and the function returns 0 immediately. The internal enabled variable is
> never updated to false, causing the module to start unexpectedly when
> damon_reclaim_init() runs.
> 
> Should this keep checking the internal enabled variable during early boot?

I don't think such override is common, but I also think there is no harm at
making the old behavior be kept.  I will address this like below, in the next
revision.

'''
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -381,27 +381,20 @@ static bool damon_reclaim_enabled(void)
 static int damon_reclaim_enabled_store(const char *val,
                const struct kernel_param *kp)
 {
-       bool enable;
        int err;

-       err = kstrtobool(val, &enable);
+       err = kstrtobool(val, &enabled);
        if (err)
                return err;

-       if (damon_reclaim_enabled() == enable)
+       if (damon_reclaim_enabled() == enabled)
                return 0;

        /* Called before init function.  The function will handle this. */
        if (!damon_initialized())
-               goto set_param_out;
-
-       err = damon_reclaim_turn(enable);
-       if (err)
-               return err;
+               return 0;

-set_param_out:
-       enabled = enable;
-       return err;
+       return damon_reclaim_turn(enabled);
 }

 static int damon_reclaim_enabled_load(char *buffer,
'''


Thanks,
SJ

[...]
