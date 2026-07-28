Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868F1E5B68
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785214351; cv=none; b=sXI9gg//AiuW+GUxQjR0pVdkfaAWB4U94tH9KSyXuQAey4kTVEHpfX1SH4eEwV0S0kFVe17OZBlGuCHDnu6pvFGFacm7NO4Pa2JvXH8RG6T14qtA8KIZiF/f6kTgREwx5dIdiuxDLe8sRYjO3oRWqdh5SEtdsyqxeFztZAmDsto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785214351; c=relaxed/simple;
	bh=iMLTUfgqOL7H2eui2w3ysnWUSGHb0c99hvw5nMxBbhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZseE8p/ym0hO/jtfmlum2+84M60HnT/jxCCX+are3hjjnnGDOwOgO/OI8EwXaKIL3YGc9M59Y5x76LyWw/i4RbOax5tVOW1SNcEd7pxnyJ7apyWvPZ4blLnoihEocWOk28Mt/kRAeHvAbRPoBV5MxNvS3PidnVzehusXeL87DEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW/jLsbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW/jLsbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675711F00AC4;
	Tue, 28 Jul 2026 04:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785214349;
	bh=g4cncyxW5+IBGPipBbiNEbHpsNARmynDhOqXGKGLB4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oW/jLsbZOpl2A0QvR/HHRGDd0/aC2r1ohikZIWa2aoOxa2uMpGfca/UsTTOlb3vCo
	 N/zp0uKGlN69EF5/GmI6D/EcQ7bklro+f/m1ltMUnV3mV5H39/ffXme24a5mrlT83X
	 rs6NGHoaPw6eMOVXbq5QRAZba7uUoA58OhZMhd16JxjhCYp2xZLHffWbJNfXPTPdht
	 sxT/+/xB2L6ghc+K+NX0HjvRq+qWUozCWXyWP9C2lGXmXaUoYj+pwziAFS/z10ZTSb
	 4yP1kTFs2xUrH8+lGAxUMm0zNl+GFjDH3C1zOuX0CRuIk4ZuJq70WUnlxD9uBzWBjW
	 6yKSX6YkgAdtw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 02/17] mm/damon/paddr: support PGIDLE_UNSET probe filter type
Date: Mon, 27 Jul 2026 21:52:21 -0700
Message-ID: <20260728045222.189550-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728043259.ACFA71F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 04:32:59 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] DAMON_FILTER_TYPE_PGIDLE_UNSET blindly matches almost all pages when probe weights are used, rendering the filter ineffective.
> - [High] The newly added DAMON_FILTER_TYPE_PGIDLE_UNSET is not exposed in the sysfs interface, making it impossible for users to configure.
> --
> 
> --- Patch [2]: [RFC PATCH v2.2 02/17] mm/damon/paddr: support PGIDLE_UNSET probe filter type ---
> commit 98c0d4f6b2dcc4c706f1af62a258dd827b89bc7e
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
> [Severity: High]
> Is this new filter type missing from the sysfs interface mapping?
> 
> Looking at damon_sysfs_filter_type_names[] in mm/damon/sysfs.c, there is
> no entry for DAMON_FILTER_TYPE_PGIDLE_UNSET:
> 
> mm/damon/sysfs.c:damon_sysfs_filter_type_names[] = {
>         {
>                 .type = DAMON_FILTER_TYPE_ANON,
>                 .name = "anon",
>         },
>         {
>                 .type = DAMON_FILTER_TYPE_MEMCG,
>                 .name = "memcg",
>         },
> };
> 
> Without an entry here, will users attempting to configure this new filter via
> sysfs receive -EINVAL, making the filter unconfigurable?

A later patch of this series does that.

> 
> > +		if (!folio)
> > +			matched = false;
> > +		else
> > +			matched = damon_folio_young(folio);
> 
> [Severity: High]
> Will this blindly match almost all folios when probe weights are used?
> 
> In kdamond_fn(), if damon_has_probe_weights(ctx) is true, it skips
> ctx->ops.prepare_access_checks():
> 
> mm/damon/core.c:kdamond_fn() {
>         ...
>         bool access_check_disabled = damon_has_probe_weights(ctx);
>         ...
>         if (!access_check_disabled && ctx->ops.prepare_access_checks)
>                 ctx->ops.prepare_access_checks(ctx);
>         ...
> }
> 
> For physical addresses, this skips damon_pa_mkold() which normally sets the
> PG_idle flag on folios.
> 
> When the filter uses damon_folio_young() here to evaluate access,
> damon_folio_young_one() checks !folio_test_idle(folio).
> 
> Since the idle flag was never set, will this evaluate to true for all
> folios, causing the PGIDLE_UNSET filter to unconditionally match?

Yes, and it is intentional.

Later patches of this series add a way to automatically do such idle flag
setup.

> 
> > +		break;
> >  	default:
> >  		break;
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260728041242.187380-1-sj@kernel.org?part=2


Thanks,
SJ
