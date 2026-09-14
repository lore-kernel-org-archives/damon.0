Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E847FB1E
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398068; cv=none; b=B409Rik6Ptk0PL1g4KTynCVn+IOS9JCfncrVnvfMrEk3NRp7A+pok0K+psZ1o/wPw3N5IDYHbsT0ER7eujsjT8M0ddsElGxhY48UP/gE7AxZgpDkOagRvYL98dauD1EgRog575wnUy20XeAOC6FlDXDVpRn2UgROFfpx78KeGNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398068; c=relaxed/simple;
	bh=9JnaHTgX+ArAerT4EREFcRyJK8wbm8nZhwv4ZqlKrao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEToKXpDY/+Oq2diMK/220Ilhdf7j/TS2OPe2iP3FqGtE3KrioYcY6Tag/bi0L+FLzrBPxGVnIkR7jNafk4h+iyvpLklreYz0PFoes4Rs/qCkQ1LwzBHgPSeOmgWX55wLzquIBwkgaclkNlNB/YSiZ5dJUWcKGD49yYzVBaVCXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX14eZsb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX14eZsb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BF11F000FF;
	Mon, 14 Sep 2026 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789398067;
	bh=7VTKfHOZR8BBu2PoPnWERiVtsq41mSIfUXOw3A7wcog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dX14eZsbLgOe4QDmviXRy2pba5ub01TeOQMdpAnnYmiMTFGPv34vlM2aq2llGGmEj
	 8GRRfM2wk/FUhpwbt311rf4YY5ODO3e+oOQLhJ/qQ9QNljnj1lCGbApQp1VS5t3laT
	 VbyN+BLhgaYFUGb7ZBBarEiOWQgpfvNR0jyPZX4kABlxoTTOzJHFjFlcALITkJp7WK
	 mgrykVRdJrg6HgRXOxLn0FsKUy0TmqIq9MQG2rPvYsSG0OISi25Wos5PBJndO7gita
	 Evw+7Yg0ey+jEo0GqKilBvI/2j8SdFOs9aYCIYfN2LOB7+aC75XWz6uHB742rQ47Va
	 qTquptPdup//Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 5/8] mm/damon/sysfs: support hugepage_size probe filter
Date: Mon, 14 Sep 2026 08:00:58 -0700
Message-ID: <20260914150100.97326-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914145404.2BC851F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 14 Sep 2026 14:54:03 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing range validation for hugepage_size filters in sysfs allows triggering a memory leak in the DAMON core.
> --
> 
> commit 2e8e2509774f21f3f602056d79fd21880b487fde
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs: support hugepage_size probe filter
> 
> Extend DAMON sysfs interface to support hugepage_size probe filter. Allows
> hugepage_size user string input to the filter type file and passes the size
> range argument via min/max files to the DAMON core.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 8e8d89b8ed981..43519afb9eb7f 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> [ ... ]
> > @@ -2273,6 +2277,9 @@ static int damon_sysfs_set_filters(struct damon_probe *probe,
> >  				damon_destroy_filter(filter);
> >  				return err;
> >  			}
> > +		} else if (filter->type == DAMON_FILTER_TYPE_HUGEPAGE_SIZE) {
> > +			filter->range_min = sys_filter->range_min;
> > +			filter->range_max = sys_filter->range_max;
> >  		}
> >  		damon_add_filter(probe, filter);
> >  	}
> 
> [Severity: High]
> Does this code need validation to ensure sys_filter->range_min <=
> sys_filter->range_max before passing the values to the DAMON core?
> 
> If a local user configures a filter with a minimum value greater than the
> maximum value, this unvalidated input will reach damon_commit_filters() in
> mm/damon/core.c.
> 
> In damon_commit_filters(), the core detects the invalid range but returns
> -EINVAL directly:
> 
> mm/damon/core.c:damon_commit_filters() {
> 	...
> 	case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> 		if (src_filter->range_max < src_filter->range_min)
> 			return -EINVAL;
> 		new_filter->range_min = src_filter->range_min;
> 		new_filter->range_max = src_filter->range_max;
> 		break;
> 	...
> }
> 
> Returning directly bypasses damon_destroy_filter(), which leaves the newly
> allocated new_filter orphaned. Because a local user with sysfs access can
> repeatedly trigger this by writing invalid ranges and committing the state,
> could this lead to a memory leak and potential memory exhaustion?

I will fix the leak in the next spin.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260914144448.93732-1-sj@kernel.org?part=5


Thanks,
SJ
