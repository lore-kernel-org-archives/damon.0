Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB43F9F2B;
	Fri, 26 Jun 2026 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485971; cv=none; b=NYD8EITdugeOuWbn/3SI/nqze3RJGwFv6gYaPV/sdDz2jA7iBZRHMcfneUmvqj3cLxhveRqR0RBO87+KcoHeONrz44irEJe76S81H9OTlXdylX/vZ9QiH4Frllt7DodcRbQWZtguF2Nxp3Gg3sPrtS/7NFr4TDPapBAYmtU0RGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485971; c=relaxed/simple;
	bh=Kz90amDPMzyconLN0t1O9z8pcQIDSZWe5ONwJoco054=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVzdxZ1zNGinjeyb/D+tBw5XGrka/uU1KkqFMAAHXMO+QCs1tvdAYTp7VuqRGef7TsODUAvKqle5fXDAgVk1G9ZJSNmXstRH1wkvy0NV7UiLCfm9aHo9lf2FBwcLO5gWkFpP4q2o6suABjHfcxDgGv4WicCWSnUzrxPlTEgw178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEXyo0RY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEXyo0RY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BF11F000E9;
	Fri, 26 Jun 2026 14:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782485965;
	bh=x9LvqpwysSqofZzAIdP9KQqPtkdx0PkmmB9N5eDhoqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UEXyo0RYES2I1TolfWEle3jihyB9LeVYjE/KYQdQCdqT+zL3Thznkkv3+9IrEe/a8
	 evwMe7Gs5LCKcdkQLvgCj89zymBD9J4MPUtX1maookb8ha6Tu8ngb4DOUoBiiSwLky
	 vTZQ016vyJVG366HcrGkJAERZlbWsmkR0Dg2P+330kGOV0uOPhw3tp7oOrJqIf2dBw
	 uOfkl7W9abmkfAjq0GNZofBAGtUBELMINSMd608F3NkHBldl5goGzekX7clHPUFSZl
	 S1IhHB6VQ+H4BoDoVmp4/+3tRaZHRW7t7WHCyuEEtvr7F8nm2TX7iHevmyDlH7a/1C
	 h5FpbmULqIewQ==
From: SeongJae Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	jiayuan.chen@shopee.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Shu Anzai <shu17az@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mm/damon/core: detect internal variation above max_nr_regions/2
Date: Fri, 26 Jun 2026 07:59:09 -0700
Message-ID: <20260626145910.88535-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626085851.70754-1-jiayuan.chen@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Jun 2026 16:58:36 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> Sorry for the late.

No worry!

> 
> kdamond_split_regions() bails out early when nr_regions is already
> above max_nr_regions / 2.  A large region that picks up new internal
> variation after that point never gets split, so we lose visibility
> into its hot/cold structure.
> 
> We hit this with damon-paddr on hugepage workloads and damon-vaddr
> on processes that mmap a large anonymous range.
> 
> Example with max_nr_regions == 1500.  A target ends up with 799
> small hot/cold regions plus one big region (an earlier merge
> collapsed a uniformly-accessed range into a single piece):
> 
> H:hot
> C:cold
> 
>       r1     r2     r3                 r800
>     HHHHHH|CCCCCC|HHHHHH|...|HHHHHH..........................|
> 
>     nr_regions = 800  >  max_nr_regions / 2 = 750
> 
> Now a cold subarea shows up inside r800:
> 
>       r1     r2     r3                 r800
>     HHHHHH|CCCCCC|HHHHHH|...|HHHHHH........CCCCCC.............|
> 
> The small regions can't merge with each other (their access counts
> differ), so budget never frees up.  r800 can't be split because
> nr_regions > max_nr_regions / 2 returns early.  The cold subarea
> stays invisible.
> 
> Patch 1 keeps refining on this path: when nr_regions is above
> max_nr_regions / 2 but still under the maximum, it splits a fraction
> of the regions instead of returning.  The fraction shrinks as the
> remaining budget shrinks, so the count approaches max_nr_regions
> smoothly.  A useless split is undone by the next merge cycle.

I assume you confirmed this change is making somee progress in a test or on
your real use case?  It would be great if you can confirm that and/or even
share your measurements.

> 
> Patch 2 adds a KUnit test for the case where nr_regions is already
> above max_nr_regions / 2.
> 
> Thanks to SeongJae for the suggestion to drive the split fraction
> from the remaining budget rather than an age-based filter.

I'm glad to help this grateful improvement!

> 
> 
> v1 -> v2: Some feedback from SJ.
> v1: https://lore.kernel.org/damon/20260521045236.115749-1-jiayuan.chen@linux.dev/
> 
> Jiayuan Chen (2):
>   mm/damon/core: split a fraction of regions when nr_regions exceeds
>     max/2
>   mm/damon/tests/core-kunit: test split above max_nr_regions/2

I have trivial comments to the second patch, but all looks good enough.

I will apply this series to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
