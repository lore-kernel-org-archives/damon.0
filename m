Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECCB23EAA6
	for <damon@lists.linux.dev>; Thu, 26 Mar 2026 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774505817; cv=none; b=nG6FuaYNh9ejHUs8XxBGOOqRLM/PXpc0sgRjy03KZ799KpNLStkBv6CYdnGSwNTkfenKRoWFKViGauAqv76jWmy59xNn1NvMVJagfZvQtVWNz4QUII5oTCVzlJeQcBdo0eAM/jw3UyPho4ErYCclTJT6WsNxQeslYNfUPW/SQ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774505817; c=relaxed/simple;
	bh=sxZ9uqz5mMnvR2PwtvAXvf5o2qhntmaUznDfQ3ePb4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTymYBt5UYjoeSy0P2KR6AGr8kZxF1PAEntzfHO6gC0a7S9G6ZlIgJV1wuse8zEeUqV1yrh72hTvzQIlnM91fVDqZLZEUFveVkOWdghfjsKRdKske1ra4BzUL4fmfoM74VBiCgthKG5h5IumreIKiPGpKe2jwkqWsmxaSJlIQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REn16efY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REn16efY"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad21f437eeso3404185ad.0
        for <damon@lists.linux.dev>; Wed, 25 Mar 2026 23:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774505814; x=1775110614; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaXdTogJeFPi3EmTAth0u459UDtlcsY8EDprhKyZo+4=;
        b=REn16efY6BtFa+WW2tNaMnf51mjET0FvhS0hKfkjd1xdHqteoRMjIV+9OhipxXkkiE
         Vu8Z6B4/eUtZ1EIdTXit8CNcrIknC7WmiOcXcrNZc9DhwsfwYtYILfrrP+IQlicuPaDa
         PA47Zs+mLOaaUki9gMnrDi86xT+eyBZc707n3YGnyox/BudOGEIatvEhqJPiAtfswyxO
         x+sllV0+VstZTGi/O+T70lSN+zvqa0pFy+90+ys2sowz5rQBvu0zCJ9uLolNEmsU6bTP
         +7iev0/61//BtnHsEwRcyVd1K3/cTC0+aDOb5aVRng49CMf2tLyJR8rmsQXQ3gpDHYcM
         h/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774505814; x=1775110614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xaXdTogJeFPi3EmTAth0u459UDtlcsY8EDprhKyZo+4=;
        b=P0tIR8bvQcJrOK0TsurOJ89c9WKaCl4LXrzLMk8m/XWkyfrPFQDNXXFVFJF8jyukTR
         sZmwirktYcQjbUrdlKdXhGZACJvsVIaY0gZt8aPAJqAGQHtvBdSeIuaj58ZqKb991jCD
         phvy+1tkXr0UVbdNI9gs9ayQAYXOj9TihPAZS1HBmF4CW4xcSzRLg0CFAJ8SA9oCqB0S
         c4UtCAIZwwtr9B5XO6p5Ys391wI6kmBh7SFgQQvNgmBPDUTSTJeLxLzTg+MuZ3bhPlq5
         G/vLmz+muAA6xdDlMQhYSRZZGPYsUL3d/Ij6ZLHGOklo6ZWnPOL8OVO2mkZzNcZVKO7X
         INWg==
X-Forwarded-Encrypted: i=1; AJvYcCWnYCuZrD4OODd9kr+RU/1aD3OSjfycQzdH8YtTrA8m3fu/PcUbEx573oKySczh+nJpREjmFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSSy1VzDqIInNcFDhHFByo6YpZ7rVChGZA/aed3o+LCj4J1WB3
	icvkWFqBuXL0aE2Jfq1zX7ZfUxpcSkCu75bTK8p2wuP1riXsyIGHaLF3Wmpbcw==
X-Gm-Gg: ATEYQzyXQF4nF5Sm/oJeYT+iAUGecgvdVZpo7zNeGWBMDT9ydgP7UqSPYMNomJCxqIW
	ARIY6jf9qbRQvab2m1HTv+VXUmdt/xqUI7FmwgHIG2qCJlrhsKaSSKaNMs/0Loc//shIX5BzYZf
	S4v5DYGJ+pRg3LfpOEtK5TNzEHU5KaU0AiaW94uNsAjiK2YWBODRdxnrcPIi0xZFfsJ2sip2ddm
	kmM3UTeq9vhh3I2jSHoNgLy3/4tHGPTEzHfH3rEuBF9+q4VS3nKWpPM4LMgUcNLJydK3aMWbj+K
	BCar1F3cZKhEvSbSsccPUfWf3Xf+9y0Fh4bRK/4Ui8v7Ws3azkN+N39M4HE2U+w96PDlJxNBxwy
	vY6QrIjtVd3DmULk204rKcqy0i8uHYMEGIcoBIPUzN68FVUMehIOjkyjHRXtXHl2LaRLHtWQfwV
	0dk2BgqawAHZMSCTUU6rsn7iT7/YLtAwtt4GX276hWjxKwKyR91W8=
X-Received: by 2002:a17:903:943:b0:2b0:b258:2a57 with SMTP id d9443c01a7336-2b0c4945e09mr4741085ad.27.1774505814466;
        Wed, 25 Mar 2026 23:16:54 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8bdfe5sm18201605ad.61.2026.03.25.23.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 23:16:54 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC v5] mm/damon: add synchronous commit for commit_inputs
Date: Thu, 26 Mar 2026 14:16:50 +0800
Message-ID: <20260326061650.20569-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325142920.87299-1-sj@kernel.org>
References: <20260325142920.87299-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 25 Mar 2026 07:29:20 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Wed, 25 Mar 2026 09:39:39 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
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
> > Changes from RFC-v4:
> > - Rename the 'yes' variable in commit_inputs_store() to the more
> >   understandable 'commit_inputs_request'.
> > - Return -EBUSY instead of -EINVAL when 'commit_inputs' is triggered 
> >   while kdamond is not running.
> > - Link to RFC-v4: https://lore.kernel.org/20260323021648.6590-1-aethernet65535@gmail.com
> > 
> > Changes from RFC-v3:
> > - Added checks for 'ctx' and 'damon_is_running()' to prevent NULL
> >   pointer dereference during early boot. (Found by Sashiko.dev)
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
> > 
> > Changes from RFC-v1:
> > - Remove question from commit message area.
> > - Added synchronous validation for DAMON_RECLAIM.
> > - Rename damon_valid_attrs() -> damon_validate_attrs().
> > - Exported a new function damon_validate_attrs() and declared it in
> >   damon.h.
> > - Link to RFC-v1: https://lore.kernel.org/20260321002642.22712-1-aethernet65535@gmail.com
> > 
> >  mm/damon/lru_sort.c | 54 +++++++++++++++++++++++++++++++++++++++------
> >  mm/damon/reclaim.c  | 54 +++++++++++++++++++++++++++++++++++++++------
> >  2 files changed, 94 insertions(+), 14 deletions(-)
> > 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 554559d72976..a2410f648b51 100644
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
> > @@ -349,18 +348,59 @@ static int damon_lru_sort_apply_parameters(void)
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
> > +	bool commit_inputs_request;
> >  	int err;
> > +	struct damon_call_control control = {
> > +		.fn = damon_lru_sort_commit_inputs_fn,
> > +		.data = ctx,
> 
> You don't really use the data in the callback function.  Why don't you just
> unset it?

You are right, thank you for pointing this out. I will remove the
unnecessary assignment in the next version.

> > +		.repeat = false,
> > +	};
> >  
> > -	if (!commit_inputs)
> > +	err = kstrtobool(val, &commit_inputs_request);
> > +	if (err)
> > +		return err;
> > +
> > +	if (!commit_inputs_request)
> >  		return 0;
> >  
> > -	err = damon_lru_sort_apply_parameters();
> > -	commit_inputs = false;
> > -	return err;
> > +	/*
> > +	 * Skip damon_call() during early boot or when kdamond is
> > +	 * not running to avoid NULL pointer dereference.
> > +	 */
> > +	if (!ctx)
> > +		return -EBUSY;
> > +
> > +	err = damon_call(ctx, &control);
> > +	if (err) {
> > +		/*
> > +		 * If kdamond is not running, damon_call() returns -EINVAL.
> > +		 * Remap it to -EBUSY to better reflect that the operation
> > +		 * failed due to the current state of the system.
> > +		 */
> > +		if (err == -EINVAL && !damon_is_running(ctx))
> > +			return -EBUSY;
> 
> In my opinion, EINVAL is a better return value.  It was failed not because
> something is busy but just because DAMON is not running.  Committing something
> to DAMON while DAMON is not running seems invalid operation to me.

That makes sense. I will revert this to return -EINVAL when DAMON is not
running.

Best regards,
Rui Yan
