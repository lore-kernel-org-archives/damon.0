Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4BF317148
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676021; cv=none; b=RzHzEAMPYpeWDN/O7txPhgU6Laqe7j7PwlUHSjYCORUvzUA86kz9Ip+bGq4TmqoAelS50w7+jTFgPLluCWwNQ+BAIHoImCdUvr7kGusbZjApOvUAr650E1Xm5ayCEX+YYVLRG+GMH0UIk/Wau5PiSbZmF98CXhqkq+xKuNhbJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676021; c=relaxed/simple;
	bh=bSMfv1spy+mBBR22M1Gd27pq2C2D9uwfnyAnxg51T5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/7UMe2+690YdX352tNsh0MlHaRzrRekuh+7mcrOopaGjMtkxZ6NbV5VAfbThxrippy7HKgUFuDiJZkvvxS7aAMNW51vfyFAyjrjlxPNYs10dPIb/Tvq5y4/LSmaWmlkYEguETkvV/1Di+tFIyk8pASn7XhYcjea//dCeMQMV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAb4DoEv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAb4DoEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD0E1F00A3A;
	Wed, 17 Jun 2026 06:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781676019;
	bh=UJGxuK6Njs8VhsilJsqNDP4tUp0w2x46iVmmqZAIjL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CAb4DoEv4PPfU7pondQV76ezUxXeuYQr8drwML+X6hw4CVcl0Vr3jyjza0068Ez3O
	 d8/LZ4DO0LqmXwdDTguZeRDA6dUXyb9P5TqQz1zFV09MOn4nCxF1iTP0RlaS5i5ab1
	 1bOwnxiJ5yJTpoelU4xXnmbDMfCAMnM8fYkvHExY3lRVYWadgw1CiXdE9eIiD5HGd+
	 i+7ylBLhguOquy0wiqkGeLk0pybrlxZxiaaJuax1FeRGUnh0g2Pa/G24dP+J2LBrK6
	 S/0OQ63x1DowvedhU3bvvNsINDcNz0vdUE7WRNyCzI1PROYmoX2VlTGucDQJI4S/AX
	 06XArX1NrMUdg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH] mm/damon/sysfs-schemes: put stats for scheme_add_dirs() internal error
Date: Tue, 16 Jun 2026 23:00:05 -0700
Message-ID: <20260617060005.86852-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617054833.3E0681F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Jun 2026 05:48:32 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Uninitialized Pointer Dereference in `damon_sysfs_access_pattern_add_dirs()` error path.
> --
> 
> commit 3b785df7194b7541f02f158bcc66d968319b86ca
> Author: SeongJae Park <sj@kernel.org>
> Subject: mm/damon/sysfs-schemes: put stats for scheme_add_dirs() internal error
> 
> This commit fixes a bug in damon_sysfs_scheme_add_dirs() where the error
> path incorrectly puts the uninitialized tried_regions directory instead
> of the stats directory. This prevents a leak of the stats object and a
> potential uninitialized pointer dereference.
> 
> Link: https://lore.kernel.org/20260617005223.96813-1-sj@kernel.org
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 329cfd0bbe9f3..0668a0e539713 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -2516,12 +2516,12 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
> >  		goto put_filters_watermarks_quotas_access_pattern_out;
> >  	err = damon_sysfs_scheme_set_tried_regions(scheme);
> >  	if (err)
> > -		goto put_tried_regions_out;
> > +		goto put_stats_out;
> >  	return 0;
> >  
> > -put_tried_regions_out:
> > -	kobject_put(&scheme->tried_regions->kobj);
> > -	scheme->tried_regions = NULL;
> > +put_stats_out:
> > +	kobject_put(&scheme->stats->kobj);
> > +	scheme->stats = NULL;
> 
> [Severity: High]
> This is a pre-existing issue, but does the identical bug exist in
> damon_sysfs_access_pattern_add_dirs() within the same file?
> 
> Looking at damon_sysfs_access_pattern_alloc(), the access_pattern struct
> is allocated using kmalloc_obj without zero-initialization, causing its
> pointer fields like sz, nr_accesses, and age to hold garbage values.
> 
> If a directory setup fails in damon_sysfs_access_pattern_add_dirs() due to
> a memory allocation failure, the error path attempts to clean up the failed
> object rather than the previously successful allocations:
> 
> mm/damon/sysfs-schemes.c:damon_sysfs_access_pattern_add_dirs() {
>     ...
> put_sz_out:
>     kobject_put(&access_pattern->sz->kobj);
>     access_pattern->sz = NULL;
>     ...
> }
> 
> Could this cause a kernel panic by dereferencing an uninitialized garbage
> pointer if the initial allocation fails, exactly like the issue fixed here
> for scheme->tried_regions?

Nice finding, I will make a fix of this and post as a series together with the
scheme dir fix.


Thanks,
SJ

[...]
