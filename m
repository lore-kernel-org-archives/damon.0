Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945FD317166
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091355; cv=none; b=XZ+tInDreknXC2jSqswQm+ibFmYOE0V3wddZ4JX8ZQrE8dCvbmfgyfgA3sDmhtJ1XhB5zdUpUvopisufCYb2H4LgGrAQzOL/yYTC0AQY8i+KCKkCouzXrCsy5kL5W1SShop24D19DfsZcb3+pKfSIWZEh/q1YxVXjEFvAX4KIEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091355; c=relaxed/simple;
	bh=btPOBsHwBA09MIlMSn0G/oIx+DGBA5mEqn/zXRSRa1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXlzCMp5do/fwX8cxR+/aoCdqGUep3zUMgZmUiBPoUxA5FMmsJmbsF+NqV6F3shu6G9a+s1scpqYo6CxANZqbKr1DeGntg2vHyYNjCikAkDHCrmkqn9I6U0+qWJZnzOleQRH6AavAwzf0WKjQSNrb2TbacveG2t0EhCqU+FVTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLz/q5vv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLz/q5vv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153A61F000E9;
	Sun, 26 Jul 2026 18:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785091354;
	bh=OQtY2a8xxFu8Gg2coTBFcSHBErnrfp0vBxLo5T+UAzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aLz/q5vvJTdL36UDHpn284Hky9RLnEfptmk+ec+Tet3tAU73Du1MgfEocUvYx5Dpg
	 8NCvDMuKJmeaCS8wgQhOCcpbRxWjAW0j5iE5X78C5UPir5NwE3MJQLq+aDAUsz8gRO
	 hEc6NgnlNijR2PdCs+Wsp++3WLVE/dZTs/xx4TGBEpv9uiCeC0pUt4lPoZxnOvWP5S
	 kOOY2x6UXq7SM5ktn9DI8z5letjoAGaBxmmCC8lVh7z74xDA5W9W0pTPIxD/Y6JJGc
	 rNysi7okgZBFfareanMcTJx/Ju0dAm4EATxz0Yfl8tJoejvuZLthCummAQSLsd9cL6
	 mG5vSmcqnbSaQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 02/17] mm/damon/paddr: support PGIDLE_UNSET probe filter type
Date: Sun, 26 Jul 2026 11:42:28 -0700
Message-ID: <20260726184229.848-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726175334.0E7501F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Jul 2026 17:53:33 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly introduced DAMON_FILTER_TYPE_PGIDLE_UNSET probe filter type is completely inaccessible from userspace because it was omitted from the sysfs string mappings.
> --
> 
> --- Patch [2]: [RFC PATCH v2 02/17] mm/damon/paddr: support PGIDLE_UNSET probe filter type ---
> commit 28cc087ac53ca1eb5ea0ff45e8fd4a6108a12c9f
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/paddr: support PGIDLE_UNSET probe filter type
> 
> Implement support of DAMON_FILTER_TYPE_PGIDLE_UNSET in the physical
> address space DAMON operations set. It reuses damon_folio_young(),
> which was being used for access monitoring.
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
> 
> [Severity: Medium]
> Will this new filter type be inaccessible from userspace?
> 
> The DAMON_FILTER_TYPE_PGIDLE_UNSET filter type appears to be missing from the
> damon_sysfs_filter_type_names array in mm/damon/sysfs.c:
> 
> static const struct damon_sysfs_filter_type_name
> damon_sysfs_filter_type_names[] = {
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
> Without adding it here (for example, as "pgidle_unset"), won't userspace
> attempts to configure this filter via sysfs be rejected with -EINVAL,
> effectively making it unusable?

A later patch of this series does that.

> 
> > +		if (!folio)
> > +			matched = false;
> > +		else
> > +			matched = damon_folio_young(folio);
> > +		break;
> >  	default:
> >  		break;
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260726173935.94046-1-sj@kernel.org?part=2


Thanks,
SJ
