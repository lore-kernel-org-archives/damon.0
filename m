Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56942DEA62
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291049; cv=none; b=Mu+WlIjJirciLW8ogHwnE2Rrnv1ihq5cwQgrNKEHleIDdA/fE1A07S7RzvpiLiF97ea2KTIJn4rQnU7DmMv+hLXzOjw3rKacsGZyTilVsUCpLcLLvNUzzYUC1eswPuXN2IKLpr7ypct+PqDws4a5DiGH7EVCa1tQjqZu6/kpBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291049; c=relaxed/simple;
	bh=Ex/GT2UKER81RTsW1dpNnuKNvndUgVcDKydyAgPuOfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TX1ZuHUHS+bR4tJoYjLS7HStUK12MlhaS386/OV+jQCLadLr71oyQZXdS+YqRo1j+izdgLCHTIAalsiXpxpBp2+O8upR6WIx/HKLVEv2x+n/ic+lGCOzBBb5sOqephgtYb6H6mb8o5ZGV8UXz9JNPawdmIM53pVw2ZdSdJvhh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFPRVuRR; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFPRVuRR"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c73a12af63cso2038766a12.0
        for <damon@lists.linux.dev>; Mon, 23 Mar 2026 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774291047; x=1774895847; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRg2GcmKeOdJcz1z27ZxeccUDfslqg/RH/olku101LI=;
        b=tFPRVuRR5Y/XAPylZ2t6IwIBeIrl1t1D/SbPR4BsYZTvyaRKxiP7j9DsgQThw6K/g2
         WdjLDvBPDOHv6yw7vAaMY9iYbJJ/pUyg+nf7IsxfdBIZmkwoPYLfYz6BgeysAzSuVzxs
         Zw0vYUqwoaKx7b8k/USuAwwGt+6rqsPLetxMoNBF+vHFu8309IODIPU8tBad5Oa9My9j
         VhFbWeg1MJuEz4VOdjgZdJUdGA3Ei5wQFo9ldcgSmimhMhKIYZsrM0mhLr17tbXrsqyL
         4k8Afm1TJeKVTMdgGsbuUJaxdsgtqYgzYuEDc6xOt9Tz57s+6raqfgPpY/0iKYdAyzYS
         CASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291047; x=1774895847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bRg2GcmKeOdJcz1z27ZxeccUDfslqg/RH/olku101LI=;
        b=DP8Vze5YOckoje25kglVo/YMXunach1hu0Wl/hcF1KqKytI3TzaTEkQGKCdlBPk/0M
         DxNes43a0nQRovTyIRGdPJIIqOZ7CkgvuFx8/c/ClMl14CpYZo7QH2BGgYYrWhTKSJrs
         6wDvMabVype6rRrzWb7d6rrH0wJP0/VPmIrXVyomv2y/dGuCjriNF1G8AwAbnDTD7EtS
         CCLpw3lE/yd4wVMIV7igze0SZua1uXrHe+6EElK4iHV5RFdpvPfaF/XpBBppkuhVQGkz
         7jp4jz5h0Gz8iQ78GSP9kIEOzLxQxffY1nPTAYR4Nz35rDwyIww7iXcTsu8ktKQY88QT
         +cbw==
X-Forwarded-Encrypted: i=1; AJvYcCW0ZZ7XDXU/OdOw1e+RntfdTFc3Yko4BO7dYqbluxoNzz3c9Frsp/r8Wjkmur7oVkI7Azhq8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZHgo6JjPhNgMfiWi3YKjL0xKGrrQSZVj2arELEUtbb3+Bhqbx
	rmaRzMzA5Gd06PRzHjThXsNEhH0PLokodd2UI71OEfNYzww8tsZQEZcI
X-Gm-Gg: ATEYQzxIKFzxGnLlkmoZsBqOaYGeM+q9muvlQtBm2az3cODSAOuDNtmCrgLR0NMIEIu
	uYEqWt+wCIyHvEoNp7cqvNU7sC+XknN5gW/RIjQM7JBVZoaxsNPNIafmrgcfDSrAlRB4zyEYl+w
	E6PWhJIA2CG8t+qrLhj9yWpftPRzJIxBbGluwWyH4/yFmfX2Fb1qoPrp0UCh7zVLKUpCThZE0IV
	AQjXhbiUSlx2uCruN5pNcXiO9iZw3KIlu56UMuCqUFJaFQPDe4b3X9MOA9eVfddlc+nh7ZmAvzK
	5v6ofCfq2Yms1iyXzvoHhqn6RwEi/bAHEf/CRgluPCW8RPdU7GykH5O46eyDN9lJFDNC1sDDXTg
	oN3GC3bhPRURqEwHUHPnWBrinXJMYnTX8QUr16vCgZzhi3YdNglJrDtbH/DawKxV3/pj8/0p42C
	i5rTp6i5YXqYs9Sh9tTLmWh0hE984=
X-Received: by 2002:a05:6a21:6da6:b0:39b:a48e:6a77 with SMTP id adf61e73a8af0-39bceb68288mr10367425637.37.1774291046971;
        Mon, 23 Mar 2026 11:37:26 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74456fbfb0sm8198280a12.29.2026.03.23.11.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:37:26 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC v4] mm/damon: add synchronous commit for commit_inputs
Date: Tue, 24 Mar 2026 02:37:22 +0800
Message-ID: <20260323183722.42045-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323150544.81042-1-sj@kernel.org>
References: <20260323150544.81042-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > Problem
> > =======
> > Writing invalid parameters to sysfs followed by 'commit_inputs=Y' fails
> > silently (no error returned to shell), because the validation happens
> > asynchronously in the kdamond.
> > 
> > Solution
> > ========
> > To fix this, the commit_inputs_store() callback now uses damon_call() to
> > synchronously commit parameters in the kdamond thread's safe context.
> > This ensures that validation errors are returned immediately to
> > userspace, following the pattern used by DAMON_SYSFS.
> > 
> > Changes
> > =======
> > 1. Added commit_inputs_store() and commit_inputs_fn() to commit
> >    synchronously.
> > 2. Removed handle_commit_inputs().
> > 
> > This change is motivated from another discussion [1].
> > 
> > [1] https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com
> > 
> > Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> > ---
> > Changes from RFC-v3:
> > - Added checks for 'ctx' and 'damon_is_running()' to prevent NULL
> >   pointer dereference during early boot. (Found by Sashiko.dev)
> 
> I'd prefer archiving sashiko question on the mailing list so that others can
> also read it without have to visit the web site.  Please consider doing so.

Sure, that was indeed my oversight. I didn't consider that others might
not want to open other websites (or that the link might become invalid
someday). Next time I will try to archive shashiko question on the
maling list. Thanks for reminding me.

> FYI, because such sharing is not very comfortable for now, I developed new hkml
> features [1] for helping such sashiko review sharing, and I'm using the
> feature.  Please fee free to use it if you think it can help you, too.
> 
> [1] https://github.com/sjp38/hackermail/blob/master/USAGE.md#sashikodev

I will try this tool.

> > - Removed handle_commit_inputs() and its associated polling logic as
> >   they have become dead code after moving to the synchronous damon_call()
> >   approach.
> > - Ensure the 'commit_inputs' is properly updated.
> > Link to RFC-v3: https://lore.kernel.org/20260322231522.32700-1-aethernet65535@gmail.com
> > 
> > Changes from RFC-v2:
> > - Removed damon_validate_attrs(), now using damon_commit_ctx() for
> >   synchronous validation in the kdamond context.
> > - Following DAMON_SYSFS pattern for synchronous commit via damon_call().
> > - Link to RFC-v2: https://lore.kernel.org/20260321140926.22163-1-aethernet65535@gmail.com
> 
> Thank you for adding the detailed revision changes.
> 
> But, please consider waiting about one day before posting a new version, so
> that we have enough time to discuss on the previous version.  If you find
> something you want to change on the next version, you can comment that to the
> current version of the patch and give time for others to comment about the next
> revision plan if they have any opinion.

Understood. I will post the new version only after careful
consideration. And when I have a new ideas (of next version), I will
clearly comment on them.

> > 
> > Changes from RFC-v1:
> > - Remove question from commit message area.
> > - Added synchronous validation for DAMON_RECLAIM.
> > - Rename damon_valid_attrs() -> damon_validate_attrs().
> > - Exported a new function damon_validate_attrs() and declared it in
> >   damon.h.
> > - Link to RFC-v1: https://lore.kernel.org/20260321002642.22712-1-aethernet65535@gmail.com
> > 
> >  mm/damon/lru_sort.c | 49 +++++++++++++++++++++++++++++++++++++++------
> >  mm/damon/reclaim.c  | 49 +++++++++++++++++++++++++++++++++++++++------
> >  2 files changed, 86 insertions(+), 12 deletions(-)
> > 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 554559d72976..37b3c897e822 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> > @@ -39,7 +39,6 @@ static bool enabled __read_mostly;
> >   * the re-reading, DAMON_LRU_SORT will be disabled.
> >   */
> >  static bool commit_inputs __read_mostly;
> > -module_param(commit_inputs, bool, 0600);
> >  
> >  /*
> >   * Desired active to [in]active memory ratio in bp (1/10,000).
> > @@ -349,18 +348,56 @@ static int damon_lru_sort_apply_parameters(void)
> >  	return err;
> >  }
> >  
> > -static int damon_lru_sort_handle_commit_inputs(void)
> > +static int damon_lru_sort_commit_inputs_fn(void *arg)
> >  {
> > +	return damon_lru_sort_apply_parameters();
> > +}
> > +
> > +static int damon_lru_sort_commit_inputs_store(const char *val,
> > +		const struct kernel_param *kp)
> > +{
> > +	bool yes;
> >  	int err;
> > +	struct damon_call_control control = {
> > +		.fn = damon_lru_sort_commit_inputs_fn,
> > +		.data = ctx,
> > +		.repeat = false,
> > +	};
> >  
> > -	if (!commit_inputs)
> > +	err = kstrtobool(val, &yes);
> > +	if (err)
> > +		return err;
> 
> I was not very sure what 'yes' means.  How about renaming it, say,
> 'commit_inputs_request' ?

Indeed, that makes sense, I've now changed the variable name to
'commit_inputs_request'.

> > +
> > +	if (commit_inputs == yes)
> >  		return 0;
> >  
> > -	err = damon_lru_sort_apply_parameters();
> > +	if (!yes) {
> > +		commit_inputs = false;
> > +		return 0;
> > +	}
> 
> I'd prefer doing !yes check before 'commit_inputs == yes' check.  That
> eliminates false request case earlier, make my brain cleaner.

Since 'commit_inputs' always is N, I will remove 'commit_inputs == yes'
and keep only '!yes'.

> > +
> > +	commit_inputs = yes;
> 
> We will anyway set this 'false' after damon_call().  Before returning this
> function, users cannot read commit_inputs parameter since this callback is
> protected by param_lock.  I think we don't need to change commit_inputs value
> at all?

I think so too!

> > +
> > +	/*
> > +	 * Skip damon_call() during early boot or when kdamond is idle
> > +	 * to avoid NULL pointer dereference or unexpected -EINVAL.
> > +	 */
> > +	if (!ctx || !damon_is_running(ctx))
> > +		return 0;
> 
> damon_call() handles !damon_is_running() case.  So I think you should check
> only !ctx.
> 
> Also, this exposes commit_inputs true.  Next 'Y' write to commit_inputs will
> make no effect?  Again, it seems we shouldn't change commit_inputs at all.

You're absolutely right; I realized this during my code review as well.
Changing the value of 'commit_inputs' is indeed unnecessary.

Best regards,
Rui Yan
