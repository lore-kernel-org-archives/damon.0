Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795290716;
	b=fgvN1lCssgZiKtlpq+YXiVQ8SDvUa8HmOnmKGwtIXP5/35S/7KwHgiRQNbXEvpZ4cYpe
	 Ijddcqfh5b3bhQjETWNGO1b/+neyiJU/2cLRdmg2pFPoi13wOOSL2gwvIhi6FPQhKoVsv
	 V9pnANt5oqp/Vx4mZcC/E9N4wRaBw22O0ADhK4gtxH4SBoPkdd6xDwqQfQ/gZQ1lj0BR6
	 raz2QazRsHn0rOpoKojesb142JEemtUWUxwq1goP+Zq7gF7uYEBc21DhFdujpSHrGJN1+
	 st21ZgPra14Ch0yBA3Mw6n/ip21GmzXdz/xHI4nHx10BH5F1TriwtiX7M/WNSOlraAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795290716;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Lacc16GR/cOxfo9/HxRF4FW+CuTPCiAe6jg0QMOUkhw=;
	b=i9Pg1lSvUUkwgQEYIYSfSS2OIFnnjCTPGMyqo+mvDVNDMOrSyjo+TmkqBa4JBhElUfpc
	 4AKGbNXokRE5cpjnkE/xG5pXJ+vR8QyVerHnI2D21yXWE+zMWcTuvk2UkBgWzmf+wDE2i
	 refVjiM1/a85SC+gdC4DhswWoYsgRgi3RVH+Ocm0jn3D2BQIN0PApNrwQEFvakhUu7RSX
	 njmYLGBhF4HLjoUyTRo+RElQ53wTwBDn+o2PEbmsvP5ajc9DJ0BD0+BOSym8sw8KBO+6T
	 NoaL9Wknm/LNt8cefyzi23lwo+hbfkT+UcGwef9mN2IGR9HO2V4TV9CEjC1u7wpqIhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0zr1ZrU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955BE606A320
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0zr1ZrU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289471F000CA;
	Sat, 21 Nov 2026 19:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795290716;
	bh=Lacc16GR/cOxfo9/HxRF4FW+CuTPCiAe6jg0QMOUkhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m0zr1ZrUvK/FyVOUfqOXaYvsR86ilglrgFjyJfaJOlyr4Yz1nZLtLq08wiUwpEbUh
	 h3DEY57FbywD/BgNE1bhZO22LslxX7gYFMEFS+wZ4qPFZczQyMyb2F36lyjekNyi2O
	 W4cEUevlXm1Uhl/xOPFjJoulp3mPZg6qOOtQGX07x9s3cwolyoy3UXO+mukklVFKgn
	 3UCBhLOTdvmZy66iV02Qo+Ef6V8ngjrAt7ahv06IGm5R6F22QPbIi82jUHINKAmtY2
	 XvN0GmUlkpXWwuOlfuw0qiKSs6YHM3kkAfYzcdo2wYz+ncizn/WD71eXmjVVWEgg7+
	 z0hB8tStVGXbQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"David Hildenbrand" <david@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/4] Docs/mm/damon/maintainer-profile: use damon.git for patch baselines
Date: Sat, 21 Nov 2026 11:51:42 -0800
Message-ID: <20261121195144.109526-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-227319@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 21 Nov 2026 19:42:08 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] Docs/mm/damon: commit message omits MAINTAINERS section name
>   update
> --
> 
> commit 6bab7534a11559ea9b976bf2b9816f3e4a1d90b2
> Author: SJ Park <sj@kernel.org>
> 
> Docs/mm/damon/maintainer-profile: use damon.git for patch baselines
> 
> This commit updates the DAMON maintainer profile documentation to direct
> patches against the damon.git for-next and for-next-fixes trees and updates
> the referenced MAINTAINERS section name.
> 
> > diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
> > index c482690320249..cc6b79c066a64 100644
> > --- a/Documentation/mm/damon/maintainer-profile.rst
> > +++ b/Documentation/mm/damon/maintainer-profile.rst
> > @@ -3,13 +3,20 @@
> >  DAMON Maintainer Entry Profile
> >  ==============================
> >  
> > -The DAMON subsystem covers the files that are listed in 'DAMON' section of
> > -'MAINTAINERS' file.
> > +The DAMON subsystem covers the files that are listed in 'MEMORY MANAGEMENT -
> > +DAMON' section of 'MAINTAINERS' file.
> 
> [Severity: Low]
> This isn't a bug, but the commit message only describes updating the patch
> baseline branches to damon.git and doesn't mention updating the MAINTAINERS
> section name reference to 'MEMORY MANAGEMENT - DAMON'.

Good catch, I will update the commit message in the next spin.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261121193331.108587-1-sj@kernel.org?part=2
> 


Thanks,
SJ
