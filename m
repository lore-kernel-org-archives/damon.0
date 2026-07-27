Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CEA388386
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164378; cv=none; b=qENQL2RdwJ1tEy+S3XNqF7pZ0cGgUIZfEnW8Y+QfyfkQIcbizGHlxzM9LBhtF8m1BG0PrJnhBDqn5muiJugKk91xQWOPs5yl5RsI8PvyqpIG8CWnUlFCZqlraqQpC0X1Lg2LjyCyRX/YhcuATPEQdd5foNEuuYg2tstSaE5ECkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164378; c=relaxed/simple;
	bh=nwOPeSkU2YyQikyfV9JYhUzIJY+2oF4ZeUzmJLRHqng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLm8K8gbe+eVfYq6LpnMn45HgKo4QyNLUkVfScXAl08Pf38dU1BipNZVBbTSXyEGlO5JM7IX0qEIe52CU1+lrceVlfTBsJMmDr805ElRoz6kY+yshhrLT02iJ8KkafkivSLSG3A1pgjvrmqmEECobxQ4SeEq5zp9AfAoi/6mPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWU8V/5N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWU8V/5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14561F000E9;
	Mon, 27 Jul 2026 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785164376;
	bh=e6AHofBNUU+Yj98sQoKTL0G+XCC8mfFOK1JUiut7Ugg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SWU8V/5NGmnUVmH4p9/1Ewk9Je025fefyP+TBKFVXkcvk3bLHsuWwXrqKLuMuNXUQ
	 JQoxtbY8WY8jOFuxwQG5mK8CdH17/dTvpDWfIEdzwqUqwl8j07UcLuRsvAkRAL9uZF
	 e+2fTJHm/wsuOks8Kw/gYg0T766XUkGivK6ODP6Bonl0DXnqHdBNSJI8hu7l4a7M10
	 eQVUlemT4VhXEeKcuBTujd7O9rUaeZTpiouWv1IKzpn7wo+DnwFC6FTCAAPPNMctD8
	 7NoCAxAdyDkffJEMPbqYRHDcUjfa8J9bP9g3bnrKeFUJaZf9BWP1YhsLIlG0Mk2CYG
	 ZjgR/aD82HxCg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.1 02/17] mm/damon/paddr: support PGIDLE_UNSET probe filter type
Date: Mon, 27 Jul 2026 07:59:27 -0700
Message-ID: <20260727145928.87131-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727145243.4BD2C1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 27 Jul 2026 14:52:42 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added DAMON probe filter type DAMON_FILTER_TYPE_PGIDLE_UNSET is not exposed in the sysfs interface.
> --
> 
> --- Patch [2]: [RFC PATCH v2.1 02/17] mm/damon/paddr: support PGIDLE_UNSET probe filter type ---
> commit 67629d6971ecadd1e1c345f911e353e76f34b34f
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/paddr: support PGIDLE_UNSET probe filter type
> 
> This commit implements support for the DAMON_FILTER_TYPE_PGIDLE_UNSET probe
> filter type in the physical address space DAMON operations set.
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 5a6a78054784a..199de1463fa06 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -132,6 +132,12 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
> >  			matched = filter->memcg_id == mem_cgroup_id(memcg);
> >  		rcu_read_unlock();
> >  		break;
> > +	case DAMON_FILTER_TYPE_PGIDLE_UNSET:
> > +		if (!folio)
> > +			matched = false;
> > +		else
> > +			matched = damon_folio_young(folio);
> > +		break;
> 
> [Severity: Medium]
> Should this new filter type also be exposed in the sysfs interface?
> 
> Looking at damon_sysfs_filter_type_names in mm/damon/sysfs.c, it maps sysfs
> string inputs to DAMON probe filter types, but it doesn't seem to include
> an entry for DAMON_FILTER_TYPE_PGIDLE_UNSET:
> 
> mm/damon/sysfs.c:damon_sysfs_filter_type_names[] = {
> 	{
> 		.type = DAMON_FILTER_TYPE_ANON,
> 		.name = "anon",
> 	},
> 	{
> 		.type = DAMON_FILTER_TYPE_MEMCG,
> 		.name = "memcg",
> 	},
> };
> 
> Without this mapping, does this prevent userspace from accessing the newly
> added feature, since any attempt to configure it through sysfs would be
> rejected?

A later patch of this series does that.

> 
> >  	default:
> >  		break;
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260727143829.86236-1-sj@kernel.org?part=2


Thanks,
SJ
