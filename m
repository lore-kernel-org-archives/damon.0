Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFDB1F1932
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774250849; cv=none; b=RCuCj1yL6tnzj8OqPw+JcqW+8vqh0EYYlPoAXyO0P/usm1bL26LYezkp0H7J/XeZP2iGnqLMDJBrvayho8F4k/jaRUkrzjF8jlAWiz5pbZK8CvuYOcTcktRtMumMIpi3xGfb70ZJgtYM3wF9WjylZ32yybxQzj3cxJgVK62ubpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774250849; c=relaxed/simple;
	bh=OJZbVH53yOtBR70L3BOJqu4HUbQCve2BbZnBoqZKE0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a103AnGLxd+nlrFgWfvvX2KGiKqZkckz/EmA2XmlMVZWOzUaoEWKWRNKlZ/Uro/6k1nA1L/6mkhaurI7c2KvnqPBmeJC2uAkmdMXiS5u3BhF6kxGbebiIDiOHhuIwKvC5/mOvSw/OZpQgkS8rOZoMCmoAV1IyHWBbKb9wtCWZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6Yi86mc; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6Yi86mc"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35ba2ae4df3so1777893a91.2
        for <damon@lists.linux.dev>; Mon, 23 Mar 2026 00:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774250848; x=1774855648; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti0opXmGZu97z0kNAXreOapOmgM8GmXul1oRrCViSA8=;
        b=a6Yi86mc/cpg7FxuhLEZzRP4emOhs+wtUe/MZqH21QxjU4/NPueK6Dpr+xC2/2EsiT
         /7x16mHcot3yBfgIUFqzAspm4Zf1lfvSx77HSt2Uf+z9lIcT7Kkml1Upf+uIXsyCgKNo
         LcZxkD0qg76OjH0xt1eSCc1AF44JIDIVbsMg8jBrF9cmJ+J/1HUENM55hA5V7xNE75oK
         TVsCwr/YS/ag9CknNLaPvFlEIfv/GM09lxJrWY6Blu/qs2e1HxN2WONyRnwgaHxR+OzG
         nOZ64jcQ9B+mu6/c+D11uD9CHt/x13Se1XhlpDTezPvyfR9M0wE9A4oIGOKHRrP3Lpul
         AAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774250848; x=1774855648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ti0opXmGZu97z0kNAXreOapOmgM8GmXul1oRrCViSA8=;
        b=BEiVRtWcgKYhs869DJcVeyC57Sv7CSS4Wa2K8/4OrRVLhO0MwYA78Ty8vD2wNHh3AJ
         a9CY2WLbbIEbYkZ2lxhJ8lsI3JyrjEbU+obhWqchc8dfUMe2BgNFcIPSau2u2C6/EPDo
         5NgtbEk98QGt5jB3WmzbdDYZJznMK4m2Z2otW2Gb81KBMTgXhn9SEUBf/sAhqAdkve5M
         jkZ4NA6tenzLNA9XMTVHdlOFl99wrnViBc+e4wX+bL5+2bqIaG2GmupShhapInYTQ0Ns
         0P4B6vO2rzQXqKPmvy/a/d1aMOJi96zz942mrkOGKPEHLhMBto0THd9fZgBj32ksv4KK
         WT4Q==
X-Gm-Message-State: AOJu0Yx2/ecu2nE1MgYCGp1iTtOjv7a/j624foKs9COWIOnbQNJN7YK+
	4fsvsG7uQqXGxpp+H7edYM7hzheHIxRd4c0M8UQNfM1jW4VmWi4xT7VX
X-Gm-Gg: ATEYQzxcwzWfUzc0KygSAj/bZv+2vSG1asmyUWK5OSA+eV9GfYaJHZS1F5aLy7qNLjy
	j6oRErKXeof2Q6eFZYp/Ql5a60eoywG2P77CO53DlfwCb2UJzIoIaULwkTwdmrZCP/0O90Np67v
	Al0ZFAz1Nv/ZNQZ9QXc49k6oVkQB9nGVHVmYipVD97JAfY4q2SOHVmWn80ogf8OeVKD2IHW94PT
	FL4UH+PSmubdPgP5BzSCWbFQukRQUdLxd4xJT41c0L1lnIfbmX9No6TAb2jmktf2its/1wspjFF
	S1sQrMdd8DoHorhjQUDhmcKmEqOwcSIGln9uBSohlLW2cQyWuxJuG2DkDccuJ6CUPl8GXuaK9mD
	rNtkW2gVvtntdNXUe/EyWPbUuq8hBI9A1yDUjTZCpaJoi8JSlfdqWH1Y+JPlZhPa8asM/+0ZvIB
	oyZ/Ni7CD/Epin5X4OQGnedpqefjF+GNORJK6sKdvSRsYKMm991co=
X-Received: by 2002:a17:90b:3b41:b0:35b:92c1:8a39 with SMTP id 98e67ed59e1d1-35bd2c47760mr9223747a91.8.1774250847877;
        Mon, 23 Mar 2026 00:27:27 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc60ec3aasm11041077a91.10.2026.03.23.00.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 00:27:27 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	aethernet65535@gmail.com
Subject: Re: [RFC v4] mm/damon: add synchronous commit for commit_inputs
Date: Mon, 23 Mar 2026 15:27:24 +0800
Message-ID: <20260323072724.15942-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323021648.6590-1-aethernet65535@gmail.com>
References: <20260323021648.6590-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

Thank you for reviewing this patch. I'd like to address the review from
Sashiko.dev [1] and ask for your guidance on two concerns.

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
> > +
> > +	if (commit_inputs == yes)
> >  		return 0;
> >  
> > -	err = damon_lru_sort_apply_parameters();
> > +	if (!yes) {
> > +		commit_inputs = false;
> > +		return 0;
> > +	}
> > +
> > +	commit_inputs = yes;
> > +
> > +	/*
> > +	 * Skip damon_call() during early boot or when kdamond is idle
> > +	 * to avoid NULL pointer dereference or unexpected -EINVAL.
> > +	 */
> > +	if (!ctx || !damon_is_running(ctx))
> > +		return 0;
> If kdamond is not running, this returns 0 but leaves commit_inputs set to
> true. When kdamond later starts, will subsequent writes of 'Y' to
> commit_inputs hit the earlier check "if (commit_inputs == yes) return 0;" and
> silently ignore parameter updates until it is manually reset to 'N'?

My current thought:
When '!ctx || !damon_is_running(ctx)', we should return -EBUSY instead
of 0, and keep 'commit_inputs' unchanged. This way, userspace
immediately knows the operation cannot proceed, and there is no risk of
stale state.

But, this means that users can no longer write 'commit_inputs=Y' before
'enabled=Y'.

> > +
> > +	err = damon_call(ctx, &control);
> The module parameter set operations are protected by the global kernel
> param_lock. If the kdamond thread is currently deactivated by watermarks and
> sleeping for the watermark check interval, could this damon_call() block on
> wait_for_completion() and hold the global param_lock for an unbounded
> duration?
>
> Also, could there be a race condition here if the kdamond thread is stopping?
>
> If kdamond_fn() flushes pending calls and only afterward sets ctx->kdamond to
> NULL, could damon_call() insert its control into the list precisely in this
> window? This might cause it to perceive the thread as active and block on the
> completion forever, deadlocking the param_lock.

I admit I don't have an elegant solution yet. Here are my current
thought:

Add a timeout to wait_for_completion() (e.g.,
wait_for_completion_timeout()), using 'damos_watermarks.interval' as the
upper bound. This prevents indefinite blocking of 'param_lock', though
it still holds the global lock for up to several seconds.

[1] https://sashiko.dev/#/patchset/20260323021648.6590-1-aethernet65535%40gmail.com

Best regards,
Rui Yan
