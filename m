Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF46641C71
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951419; cv=none; b=FXYtoLiPhmn1/MNVqhyNZUUFRvRUxm9Y9diCJvBlG4m/11ytJeGxm9jOTpaPYR83yBUtZ/dopjErqkOidIbJG6qOxsxPhrySiAkDdQEVvwRtuVQO0ZUa/Wd7qRIXgtwQWUrjUxGoiW1sL8+EhRdaX21rGniUnbi11JfkiRWLpJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951419; c=relaxed/simple;
	bh=ceR/i6hBvtGK7iCXeweH0LIEaoYHiRY64Ykp108QYf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYpxAuQ+9Za/yGXUsvW4vBg193/9zkfFjI88K347CCB4/gpQXXPBm/Q867qap3OdzOKB/CYISzjghzg+K4YVESxE6bWiFvl1t3x4Otz6vExBgDOnAoUeR7fUYxp+dTKL6t8ddRIbdOkVXugJ1JBJhXE05+qNAyS+XD6yaTxwcZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jm3OtK5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jm3OtK5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610FB1F000E9;
	Thu,  2 Jul 2026 00:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782951418;
	bh=afmg5ngjmZSR96lWjwHYXC9D5BFmQJWINJNwWJqlfGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jm3OtK5vXQFdGrLXI2GeHaZ+ezu4yE0gsOwnLQG5o/Px6VrME6ea2PCER84J4jfIa
	 gOdUR6SQVoV3cmLxVHUTW1J3/4y25GRrnLO+FUybqM0EbXYpdb4k0xHNpsp2dnnaqN
	 JWF7HTI0a2WmiSy2Xbn2tk87ErzaA7cV29qqx5wvfKHEQ3kCorsTTZUHwDwsa8upu9
	 WnDqmoRo828S0vGWotRogRaqOSNLhYEDlW+vGNGI8AKfbFFZWNrP3Ty/1wcm754Ler
	 KsKuD6Fk8gPyx+ftkAGOiJnxw+W6DOxZcfVhMZxUlGf0eSvCYHpcsNUDOBN7wQcx2H
	 8LRXY6J9W/HgQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 6/8] mm/damon: document region size validation in damon_set_regions()
Date: Wed,  1 Jul 2026 17:16:50 -0700
Message-ID: <20260702001650.86841-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701160419.4A40B1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 01 Jul 2026 16:04:18 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The documentation incorrectly claims `damon_set_regions()` validates region sizes, which led to the removal of input validation in callers, resulting in a kernel OOM panic when negative-sized regions are processed.
> --
> 
> commit d4cdfb1871ad152ec6d79d41fca7f1497b7467a0
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon: document region size validation in damon_set_regions()
> 
> This commit updates the documentation for the damon_region struct. It
> clarifies that callers can pass any values for region addresses because
> damon_set_regions() validates that regions have a positive size.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -51,7 +51,8 @@ struct damon_size_range {
> >   * @list:		List head for siblings.
> >   * @age:		Age of this region.
> >   *
> > - * For any use case, @ar should be non-zero positive size.
> > + * For any use case, @ar should be non-zero positive size.  damon_set_regions()
> > + * does the validation.
> 
> [Severity: High]
> Does this documentation accurately reflect the implementation?
> 
> Looking at damon_set_regions() in mm/damon/core.c, it lacks checks for
> start >= end before passing boundaries to damon_new_region():

As I noted on the cover letter, the check is not yet merged into mm.git.

> 
> mm/damon/core.c:damon_set_regions() {
>     ...
> 			r = damon_new_region(
> 					ALIGN_DOWN(ranges[i].start,
> 						min_region_sz),
> 					ALIGN(ranges[i].end, min_region_sz));
>     ...
> }
> 
> If a region is created with start >= end, would damon_sz_region() underflow
> to ULONG_MAX?
> 
> This enormous size could trigger an infinite memory allocation loop in
> damon_apply_min_nr_regions() which repeatedly calls damon_split_region_at():
> 
> mm/damon/core.c:damon_apply_min_nr_regions() {
>     ...
> 			while (damon_sz_region(r) > max_region_sz) {
> 				damon_split_region_at(t, r, max_region_sz);
> 				r = damon_next_region(r);
> 			}
>     ...
> }
> 
> Since a subsequent patch in the series (mm/damon/sysfs: remove region size
> validation) relies on this guarantee to remove the validation from sysfs,
> could a user writing a region with start >= end to the DAMON sysfs interface
> trigger an Out-of-Memory kernel panic?

So no issue.


Thanks,
SJ

[...]
