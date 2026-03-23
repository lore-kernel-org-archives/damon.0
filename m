Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751042571C7;
	Mon, 23 Mar 2026 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774309537; cv=none; b=k9AIxuaF+yig3JfG+V/517MGuRkzhkTAXMF3jzs0Dq9SLZVqB+Of5xiFQDmQfA96+NVysnqFTECOaLliyrHRCxOihKNPBngg4Ifzy9cTmgI8XjuMxpkpZuyR8/BgGFvOrhWynvmi6YMv9ofanDIRVhUKvVF5WWNAvd5Xjf5LOJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774309537; c=relaxed/simple;
	bh=wAhrSG+O4G13mI6rUqEHR2ZQ5aOUUhnwCEn157FgXIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jd7PQfCC+VgQJSsLJZOWe8Qdf6PAvquE5JetSsemt8xaqb9E8GGIyfkGT6XXg3z1oMzjC79XBt1kY/98ZoZZ2wyEssQmFPS43c5BkvJDRnmqV7phEX2QDMTjXHqcnWPJgtP067MmL+M6E4CBfvEw3CxNfURFIVJZuiUoHKmYeNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wu4eNhCq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wu4eNhCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE097C4CEF7;
	Mon, 23 Mar 2026 23:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774309537;
	bh=wAhrSG+O4G13mI6rUqEHR2ZQ5aOUUhnwCEn157FgXIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wu4eNhCqey6dvy9Pj3dGKa7HfQmwK6p7XQuJ1/3jfIY2eB6q0lo6Oe91eMmiBOLYq
	 U+0pyryBL0yAlBxDmOGWnSVBpWUH+JPsKEqGJXL2Ig59wTGicUwqEAN0EVBoJBagkC
	 ecV0T+ZOQT07+KKeFUzahXS9DinIfzIfOhvQSdqJC+ZK5cZ5kjLl3EgtqaCBeham8i
	 bXMCTGTW5QI4qiwGdcV2zpcACP3Fsooy3Wu+62m8QyWyw47bDYvkdS07FupCEKLhN4
	 N1QNllBVwPDvxAuNv9tG56HQx795yz8TcwidO4GhteH7BEFL/BeK5pgH21Ty2HrNVs
	 bvrehnewkVTPg==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH v4 0/1] mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
Date: Mon, 23 Mar 2026 16:45:27 -0700
Message-ID: <20260323234529.85790-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y15sBCyVgGKC5994-WhS31nahyT=8uitDPG_isZ7sp_g_w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 12:23:49 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Sat, Mar 21, 2026 at 9:57 AM SeongJae Park <sj@kernel.org> wrote:
[...]
> > >
> > > Changes since v3:
> > > =================
> > >
> > > - The first two patches from v3 (goal_tuner initialization fix and
> > >   esz=0 quota bypass fix) are now in damon/next. This submission
> >
> > It is not also in mm-unstable :)

What I really wanted to say is, s/not/now/

> 
> Good to know. Will mention this in the next version.

I think Ravi understood what I really wanted to mean, though.

[...]
> Thank you! Will drop the RFC tag for v5.

Looking forward to!


Thanks,
SJ

[...]
