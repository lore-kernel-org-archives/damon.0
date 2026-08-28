Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E1356759;
	Fri, 28 Aug 2026 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787941959; cv=none; b=Al5qCmIQ5aRNpqLJjyBnX4fkVlumesDe1XYbaPrZLx7guzt6ADEoD6n4Mys9Sed2+J7+0yDf7f7o2ZOYKuahTR3x7VO7KX5fkPjse1KOgboXrSel/e7JqrK2KmItc2Pdwi3J2wFmZ2qGapN0CO1y6ZdbK6x6Ip+GHi3rbiwa0lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787941959; c=relaxed/simple;
	bh=atqdbFiHi4Z9Umih/jw5on6AGChbub5zzqEsdbfodb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4ZJmf7AjVqAiwFs8Tpmpyyw7JE9qL+qZ2la8MMOHGaC2w5o+evT9JcsC3NlasQWAEZKfzdaGZeh2x1b1zglDQ+hbFGFsMrOu8YFUWIZDIGi3sHbw834MJlOmeDAoqkBc35eMxoBW5E7BweylbMIrRaxP0BxGdl4CpmrXgAEVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYr3tu3r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYr3tu3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6544E1F000E9;
	Fri, 28 Aug 2026 18:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787941957;
	bh=ABzg8YpGTvxs6hey/VNDQl6c5Dr0N0qxeGAAzhfOySw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lYr3tu3rftVInD8hI/OBLLJivWgGSF1DEvvwXVfBHSSC8j2F02/X2kdiP0xFg/XHt
	 c5JevwGA8ABY8E0/zZ5YOWY6yoRT+rwbYTbyy7U6UN/rt3yKFclxv4vXz/t/MrR8FQ
	 W/Rg3c7dV4jFD+h9fF9E/j7nYXLSl36m89FTTU0GIP/RH9nYwDoeXBAFJDydOPOMxW
	 AOVqeSHShtUhFh+aZNrOAB3phRBKdm1cKjh20O/kT/S5O9aKym0QHDr6UC7QEhs8Ja
	 Hm9mflD1+P8Gyj9dzOX/Q+3rP4PyJr/WGYRnHxHC+/o9gKWrVszCtX3ffTiZeTv/Jx
	 mssMBwW2WyZIA==
From: SJ Park <sj@kernel.org>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v3 22/37] mm/damon/sysfs: implement cpumask file under sample filter dir
Date: Fri, 28 Aug 2026 11:32:30 -0700
Message-ID: <20260828183230.70517-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3cb41363-76e8-434b-add3-3cb4b83a6d9e@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 28 Aug 2026 11:59:47 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:

> On 12/8/25 2:29 PM, SeongJae Park wrote:
> > The DAON sample filter directory has files for only common properties.
> 
> DAMON
> 
> > Add a file to further specify the CPUs to filter in or out.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/damon/sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> > 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 74594e6e461c..d6b0b6513fd1 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -758,6 +758,7 @@ struct damon_sysfs_sample_filter {
> >  	enum damon_sample_filter_type type;
> >  	bool matching;
> >  	bool allow;
> > +	cpumask_t cpumask;
> >  };
> >  
> >  static struct damon_sysfs_sample_filter *damon_sysfs_sample_filter_alloc(void)
> > @@ -765,6 +766,19 @@ static struct damon_sysfs_sample_filter *damon_sysfs_sample_filter_alloc(void)
> >  	return kzalloc(sizeof(struct damon_sysfs_sample_filter), GFP_KERNEL);
> >  }
> >  
> > +struct damon_sysfs_sample_filter_type_name {
> > +	enum damon_sample_filter_type type;
> > +	char *name;
> > +};
> > +
> > +static const struct damon_sysfs_sample_filter_type_name
> > +damon_sysfs_sample_filter_type_names[] = {
> 
> Looks like this should be defined in patch #21.

Thank you for your review, Zenghui.  I will nearly entirely rewrite this series
using probe itnerface, following the DAMON extension roadmap [1].  I will keep
your review in my mind when writing it.

[1] https://lore.kernel.org/all/20260525225208.1179-1-sj@kernel.org/


Thanks,
SJ

[...]
