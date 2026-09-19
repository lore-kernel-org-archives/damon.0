Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C38023ABBE
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 05:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789796835; cv=none; b=gIxmOBFzMKW1XrdxNQAsOLSbnkZ4IrzYGYl9fzf0hwvbHHUJC+FFS9Z6fnvQsGd3/u7Vzo9RDHymlgRiF+Bp7EWLYOX/haloktq4TzzUtwIdiOjZhRrJWB3YFdNbQYiCzQKl6dyR+CbFg+Wua5GtjbtoapmJu7fP4UM4As/ca9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789796835; c=relaxed/simple;
	bh=v1XP5r41bgS5MWfSnZiNwpjz+p6BfN1AlYJ8Ofbd0pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mV4TLdDCGK830PcOOQUeVCwhe9qaTl93RLxAMHn0JgY3wK+tSHSyAM2qi+fJw3dQJFC3mbb/WCuwhD/33uAog+I+8txaWwoobAjZ4tO/5U4IULo90zEhLmjFPEhXWIPzRt685C6PzspAFifQz2gXng5YWVqHkDOitz84+jBy8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xha1ybpi; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xha1ybpi"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso14878115e9.1
        for <damon@lists.linux.dev>; Fri, 18 Sep 2026 22:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789796833; x=1790401633; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=COKKaSNh5aTClL3pM4Jpjuvdb7nWPK0iDVawAIP9M/0=;
        b=Xha1ybpitUlZYOVomxyc4uMnV9KhNJ2sNhcdkVetNzrvsvHtyZPXVp8KNfbxQN1gf9
         wlTYWvNFr9TkehJK9arIWoeJZYYx6EdowhcqmpsDxH6HJsC4UEMzjVXjtandDGaY5S2q
         Q+4G7LKQCax7bQ2/2LO6IA7BBnI7HxXzsxvXssMTibYZClUZtZjmuHiZYYT19E/4wpFc
         YS7qs8Bgi/SQzelgDmXzeN0m2yUKcYF0JIvLtBHJDwUQ/GWgq244OOyeW0KX7pbe7dNb
         SqNfMjzOmSyH66zH2hq+YLoPGDrFk1mzXXKTBPzNeQdxJXhq93F924eZTTvnNu57j2NF
         I1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789796833; x=1790401633;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COKKaSNh5aTClL3pM4Jpjuvdb7nWPK0iDVawAIP9M/0=;
        b=MdZwSp4Hq266nptoZBF7lNkJ63g0PHWL8phBmJeLLO0NZgi7ZrTw8BqwD6/Hj2/CcW
         JukfJJ1kXzF3YAMnZfhg9SgLqSSyuhPTpGrzFJdDGLDreEXa/MS4aQ3ex+W0PZvgowQw
         iEF/8hZtGIvVeVeFranvuFslElYdcysC70lw0lSNHU7ALxi1060kC0UgNzkAHtwUNB9a
         grGgC7sZx01I7GxBebyb8kkeG9JcIk1PlR61PgW6mUUHwlZQBCReMWWJ2/i8WL0kPSAW
         3+bhRTkyf6qCWxe47Ez8gQOtx3DtRAtDiy91DF1xC4SMPBHYFNheY5XZkWigMbrzNo9S
         uDUg==
X-Forwarded-Encrypted: i=1; AKwUvBxiVRlZzIRREXwZWMn46xv4w2EI55ZohKiziyUvxbjciXSLlG+5UfVSFEnpbmx3J7gFQ+VRZg==@lists.linux.dev
X-Gm-Message-State: AFuF++nny4kwEl8qwGmCCmvTzGQ8JURT+3LMySBUeDtiGq5ABGi+obZd
	SqT7m+vMmq2AeS7RY2DL5qSN3J1e9tGkYgMPl3JRZiHnrUpBeNPD9Jtr
X-Gm-Gg: AYBFou1d1Fgj1ecxiTA6Vo9U2DtA/xIIA+PPQE/sePy3Xj2HTSVhOZp9KM1ctTA/wbv
	abI2fJ6EsS3OA4VAwIldSvj0J0X77fC3FVZhepLWKxhLraio6+B/Ze1jN664u4gyK+vljAFNQn3
	5tJSEPFB1l0LXHVRopcOYXF0TqTtNm4nOIM6PidUmvYZ31qfxmzt/ICFDHG5Ffe0cbx/psp6Zl2
	B1XMYYrp8nIJ+3bPxB2LSC5d/L4nyzPxmos7/pM8L3Dg1Nk52Qv8vc0pkqFeV69bMx0afRzBYVh
	TXq+47WaCGC+yPGdhjLoTpF8z5Dm3AgQuFoe5x4G9PdyZGdKu7TYctiHzDePuTg5HIVh76YLnZ3
	OBwQK0gtnQDChdMaQaqAFHKNldZeTDL12B7AE5FAuD3c+osyVMOSh2X398TVk4gxwa7th1AC9vc
	kNKoM3rOyQzcnHVIf2khjpQeTtUmH3Gqvj98t+tEqCc1OIgUHTETOEaabn0MHz+a5YefddinwYl
	k5XeD7vk46KZLl6qNzWdlEoi0lXzSajuxr7h5RD8bXlJmPdVl+uf04MVB3w/DFHZPut4Wj9FO0a
	0GbbZr86m1IdjoI1PIYkl5zF+NdVfCI6kf1ng8TpfftGf84mnvGil2kg+OQjmLETGLDpeT1AJ/t
	XQkCvApf3b4wUCeSF
X-Received: by 2002:a05:600c:8b61:b0:49e:69ff:c6b1 with SMTP id 5b1f17b1804b1-49fc5749edemr70586425e9.31.1789796832402;
        Fri, 18 Sep 2026 22:47:12 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd068059sm46003715e9.5.2026.09.18.22.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 22:47:11 -0700 (PDT)
Date: Sat, 19 Sep 2026 07:47:11 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon/tests/core-kunit: test PSI goal rounds
 under the temporal tuner
Message-ID: <aq4hU5DNjnGELpUT@gmail.com>
References: <20260915060937.3423-3-kmehltretter@gmail.com>
 <20260916002137.101195-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916002137.101195-1-sj@kernel.org>

On Tue, Sep 15, 2026 at 05:21:36PM +0100, SJ Park wrote:
> So, this test depends on the memory pressure level of the testing system?  I
> concern if that could make the test result not very reliable.  Maybe we could
> split out the corner case handling logic to explicitly receive the current
> memory PSI total time.  For example, like what I suggested in the reply to the
> first patch of this series.  With it, we could build a kunit test for only the
> target logic, without depending on the test system's status.
> 

Yes, the second round reads the real PSI total. I used ULONG_MAX as
the target to make it unreachable, but I agree that a test which
does not read system state is better.

For v2 I can test only the helper from your reply to patch 1,
with explicit PSI totals. It would cover both tuners, zero and
non-zero esz for the temporal one, and the last_psi_total value after
each call as Kunwu asked.

Thanks,
Karl
