Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681AF305678
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783286727; cv=none; b=uPQICM4VunD+lJ0y2151AM7PIqTSUNeTmR732b4KLtAda7t9sXOaI41H3S6qCNClc+JmblXuppbjZgVO7UmVqNEilGlRvia+mSvxBaHowbZ2XdcF6YCOZoR33zcH4PlLAxZ8Q4/oBvq8CWUjt+2kgNM2z4NH91YtC7DPJME53As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783286727; c=relaxed/simple;
	bh=+lq28YGN2iAEI+ifJiOJdkCxKB3BgfpojsEU67sS0IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuvyPdVPaVGiT6PXf1ro+GqO2suK74QxOj5q4+GkhmVckKeWjaIIfyxp2/1UIMYHDlhnkahRCKkaXbGihldkMtG02ATmAEKg4nSro2Gt73eMyVE2zGyMWLrtWWISVBCu0atPmpfKC0lHOg+ynDmvLQqcOdX9L64DmaFI24RF2SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMl0lbJm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMl0lbJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBF51F000E9;
	Sun,  5 Jul 2026 21:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783286726;
	bh=rCLt6AV8ipQx/7jZnLW9J73AMdNbONQGMJpY8qniI1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lMl0lbJmzfRL8iVqQC7KZkZ/eEtCnHt13s9SOg0AN/SgOsEdv0JF6LWnXgehWVY8J
	 JMHJ/UgON9qOLOdO2OnNtS+LX1qbmKJqFKrSF8Yt6uQt9RWSaFiHd+C4dSEF7B8+dU
	 zSdx/yagoNmkl1Nc57jAeTgpPxXNhXnUbJVHGz0Sqab8eszBUEQ5rAbXjVT+M3+qhO
	 KM2T0B6uq0cuf16hkFZRGssRlXWYalpzfvR69h6Kniw3s+FmG5unMpIpqHF+EROtUF
	 vUiaacjYHR6Jyl3w0fti8F+s2+CtgznAVuNwlbCrosOhTgQ6qiXUXSKOGAQ7wQyNuH
	 d2ivkc0m6pz/Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 02/16] mm/damon/core: ask apply_probes() ops callback to set sampling address
Date: Sun,  5 Jul 2026 14:25:14 -0700
Message-ID: <20260705212516.100407-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705210738.5F62A1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 05 Jul 2026 21:07:37 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Malformed kernel-doc syntax and typos in the `apply_probes` documentation.
> --
> 
> commit 2691e8480612ea2e98837a8db1eb30da170cf383
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: ask apply_probes() ops callback to set sampling address
> 
> This patch updates the apply_probes() callback in struct damon_operations
> by adding a set_samples argument. It allows apply_probes() to directly set
> the sampling address for each region, minimizing unnecessary iterations.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 257a4769296ab..7c82cd0c2f29d 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -646,7 +646,8 @@ enum damon_ops_id {
> >   * It should also return max number of observed accesses that made as a result
> >   * of its update.  The value will be used for regions adjustment threshold.
> >   * @apply_probes should apply the data attribute probes to each region and
> > - * accordingly update the probe hits counter of the region.
> > + * accordingly update the probe hits counter of the region.  It should also
> > + * &set sampling_addr or each region if &set_samples is true.
> 
> [Severity: Low]
> This isn't a bug, but there appear to be a few typos and kernel-doc syntax
> issues in this documentation update.
> 
> Did you mean "for each" instead of "or each"?
> 
> Additionally, parameter references in kernel-doc typically use @set_samples
> rather than &set_samples, and the &set prefix seems unintended here.

Nice catches.  I will fix those in the next revision.

> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260705205743.98656-1-sj@kernel.org?part=2


Thanks,
SJ
