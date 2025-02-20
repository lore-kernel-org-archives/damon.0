Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD76F1E2848;
	Thu, 20 Feb 2025 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072257; cv=none; b=dhEVpfDkQ3q3qqleO+/Q5hY/ZbYzFypNh2kvCbekJDR1Al9K67pcoZMUHNbim3FGjjalUxs7SQn6y37cgov7IxT2pRDNismoLairDrwobUbT2pNuV/s76HUu1nl4K2EOOEzIRw7726pcuXSrTE0O4tV5gv4KxNRnODoKbUR7/b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072257; c=relaxed/simple;
	bh=0vTN9kKsGessHSXK1lGUwEF13I3IstE4YbEVN7z6DeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MS+l5GNFXsLdf0nPQIxIPGNORvt/zk4a/I7pf/IxwJqe6mIcL9hG1kLP2cp6tq9J8uDWTceBaB/v2IzTPzwA37BiUl06u/R8s3+93WDo2PGf4ixZmD5Ca2f5zPe7r5DQypWcbSCpuCnDlITiIuQKLtacw9CanNI39WM96QnIGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9lrXfLo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9lrXfLo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343D3C4CED1;
	Thu, 20 Feb 2025 17:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740072256;
	bh=0vTN9kKsGessHSXK1lGUwEF13I3IstE4YbEVN7z6DeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F9lrXfLoGKdONQDtLR43hvtGmLom/4cETRb9HKRvYXfvtFGfPuB16JSU+eQDALYlt
	 D4CkkHb1drhep3lxmYtX80KPSknuY2OlDgVJXUN5cOHSTwYBUsoJNOA8dz3Y0T9HRi
	 nxfEqVhfKxuJLeNDR1p+nwJ8VxR21jKCDY5p4n12JUT5HnvGyYuDnCVV4d0dSjOz9j
	 G8KFmasxukad5p+neYT67aQ1OiZ7LEi255kov736QD/de0+sW9+lno55E4djrkX4iV
	 OmFJCaZEX2cp3y6l5gLt1gJ7LV3pl5jfg6NpIl4IGmvrc3GCS9YF/IRFJbxLWEV/9g
	 t8LcST/cB8zOw==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	kernel_team@skhynix.com,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/2] mm/damon: introduce DAMOS filter type for unmapped pages
Date: Thu, 20 Feb 2025 09:24:10 -0800
Message-Id: <20250220172411.41010-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <93792bf7-9507-474f-a8b0-ccd4d59742dc@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Honggyu,

On Thu, 20 Feb 2025 16:45:56 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> On 2/20/2025 7:01 AM, SeongJae Park wrote:
> > User decides whether their memory will be mapped or unmapped.  It
> > implies that the two types of memory can have different characteristics
> > and management requirements.  Provide the DAMON-observaibility
> > DAMOS-operation capability for the different types by introducing a new
> > DAMOS filter type for unmapped pages.
> 
> I asked it before at https://github.com/damonitor/damo/issues/13 about
> monitoring unused paddr area but I see this patch series is related to
> applying DAMOS action.

My understanding of "unused" memory that you mentioned is memory that not
allocated for user data.  This memory cannot get accessed by user, so DAMON
treats this memory as always not accessed.

"unmapped" memory I'm saying about here is memory that not mapped to userspace.
For example, unmapped pages in pge cache.  This memory can be accessed, for
eaxmple through page cache using read()/write() like system calls.

So I think this is not really related with the GitHub discussion.  Please let
me know if I'm missing something.

> 
> Regarding that, do you think we can skip those unused memory area using
> this filter before applying DAMOS action?

So, no.

> 
> I'm not sure if the current DAMOS tries pageout/migrate action for those
> unused area because they are detected as cold area although those will
> be imediately skiped inside action scheme.

This is the current behavior.  DAMOS will try to do whatever action to whatever
region if requested, see the action is not applicable to the page, and move on
to the next page.  Please note that filter-based page level skipping is not
that different from the page level action applicability checking.

If you know where "unused" memory located, and you want to make DAMON/S
entirely ignore it, you could use DAMON target address range, or address range
type DAMOS filter.  I'm not sure if this is what you're looking for, though.

My understanding of your concern about "unused" memory on the GitHub discussion
was more about adaptive reions adjustment efficiency.  I recently posted[1] some
ideas to improve the mechanism.  Any feedback about the idea will be welcomed
and help prioritizing it.

[1] https://lore.kernel.org/20250213222303.244724-1-sj@kernel.org


Thanks,
SJ

[...]
