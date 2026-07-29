Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35FD486E46
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335095; cv=none; b=fjmXIPOb7agN3n74d4QYYg78iBuQuRRZUtGaIlLawvyTNo751ZrqC3rC662vCNmYIQVKBNykcpyvmvjMuxshV+NYQGwgvuehzJVerzWJwGKeGJVKqGMkXahAXV9gdPbRWy0ONKgmHsePi4ECfky5Bad14GlAEDsQQLkT+EIvOLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335095; c=relaxed/simple;
	bh=ck48P/sFscZjClPAxyIkW8AnWlpgJKh0gs+dolR4nBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGkoH13tN7K/8LqAU5TBb853poR5HXE4SIYrOfD0dYzj5hGntXoXw7dfui14j0ZmBlQOH2ooLAujrrX0qvob49vnX90ioKk64Dc5p97Gg58pGP+X4Ug0Jj/y9KwLOtL8XvQuCQgSj20Jid8QJd1bHOmtR4cIYbGiLs8EBEC+d0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpONjCmd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpONjCmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8041F000E9;
	Wed, 29 Jul 2026 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785335094;
	bh=Bip/6wz7XMNkQabaOSXgyZ41xIQtqiyJ4h60pJ7XM20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SpONjCmdQLX4D0wDol/fE79nJrPO2Y44oS+zBoUaZaup0IZ2d9eXWzkHD3xQLwxO7
	 2GFyN612Ziz/JbCIL+eHHm1oh+OnzK5QanbOVelJprVRo7GAcouAbWBMNdo145N07D
	 6GA2wkdDXhTRHECUWG4kGvhCwngqaliYa82bnGxcFUI/gj7GwzDBaMh7859JV0+UCY
	 NkavTqtKgWbEBB9rOzdMu3cBUA/oyMbFY4JXCFNPk38LdSjKVB0JnxqHJait9aH0v3
	 X5knrHBS8dYyr2qmlkm77N+KwcdHHvw/XOWf1D+rkhIrBd1blB+V/J1Uyabjjdut4y
	 fUMNHtRHK31Rg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 05/12] mm/damon/sysfs: remove probes number validation
Date: Wed, 29 Jul 2026 07:24:44 -0700
Message-ID: <20260729142446.88564-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729141624.E24191F00A3F@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 29 Jul 2026 14:16:24 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removing the upper bound check on `nr_probes` allows userspace to trigger massive unbounded kobject allocations, causing soft lockups and OOM.
> --
> 
> --- Patch [5]: [RFC PATCH v1.2 05/12] mm/damon/sysfs: remove probes number validation ---
> commit a336beb0d20022011c91edc1b40bfb3902ced157
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs: remove probes number validation
> 
> DAMON sysfs interface drops the >DAMON_MAX_PROBES validation on
> nr_probes input, intending to let the core layer validate the upper
> limit instead.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index e3858ffab4b22..85dca07169c63 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -1234,7 +1234,7 @@ static ssize_t nr_probes_store(struct kobject *kobj,
> >  
> >  	if (err)
> >  		return err;
> > -	if (nr < 0 || nr > DAMON_MAX_PROBES)
> > +	if (nr < 0)
> >  		return -EINVAL;
> 
> [Severity: High]
> Does removing this upper bound allow userspace to trigger soft lockups or
> OOM?
> 
> If a user writes a very large value (e.g. 2,000,000) here, that unbounded
> value is passed into damon_sysfs_probes_add_dirs() and iterates this loop:
> 
> mm/damon/sysfs.c:damon_sysfs_probes_add_dirs() {
>     ...
> 	probes_arr = kmalloc_objs(*probes_arr, nr_probes,
> 				   GFP_KERNEL | __GFP_NOWARN);
> 	if (!probes_arr)
> 		return -ENOMEM;
> 	probes->probes_arr = probes_arr;
> 
> 	for (i = 0; i < nr_probes; i++) {
> 		probe = damon_sysfs_probe_alloc();
>     ...
> }
> 
> Since this loop allocates sysfs kobjects synchronously without
> cond_resched(), will this cause the system to freeze or exhaust memory
> before the DAMON core layer ever gets a chance to validate the parameters?

Sane users wouldn't do that.  We can revisit if this turns out to be a real
issue.

> 
> >  
> >  	probes = container_of(kobj, struct damon_sysfs_probes, kobj);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260729140253.87753-1-sj@kernel.org?part=5


Thanks,
SJ
