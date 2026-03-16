Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91ED1A9FAF;
	Mon, 16 Mar 2026 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689691; cv=none; b=NQdPvkH/sQ9Z1YjCNjJ7gMrsO7zWdpB1gYFv5QEc8q72zvKzUyUDt2LIBDUpCxEfS62g2ZjC8h8g/ry7fZYWGuvFdxdVFfXRkOWDzR6AoaztuzgXC4uiG/TGaIEisz4nUvK3zKmu6/5C9FP1lS8y1/36W06J962Njhs4JtSh8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689691; c=relaxed/simple;
	bh=ypMADP71DX2Iy1YOt9Ke+EpLL8A4YBFUr74ekNFQ57U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ensnkZpFgNdBzeKPqkLBdCgG3c5G9EqqjmMcWGvyQgCmLh8Xl4e15gwBKvGQzeC+rZJXs66v2R73AxHKvvaaddc14wbe+ApOxGsOBCht6g884FBCLyIHLkIlSX3uS+LHQpYdExwdstJ9zeUdrK1dXsHxSTVsGobuKiRvfVdjnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOTDcPAN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOTDcPAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55360C2BCB0;
	Mon, 16 Mar 2026 19:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773689691;
	bh=ypMADP71DX2Iy1YOt9Ke+EpLL8A4YBFUr74ekNFQ57U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dOTDcPAN27JEc0aoYvLAzmR+L1LIxNUknSz4dQ1rJSa02UmlZG3h8g8cd9j4r51pC
	 YRrUzY3/OA0NehmrglV+le3T7pHax2YBcDVljkFi5zLAcFP7lyRw/UNr/CxbHotPdS
	 R2ScqitwzblTJF4bxXgZ1eJq3+oEOvNf+9/Mob/HJiUPkagnLKyMSz4DpRJRdJHUYq
	 RsSwrEhz6+OtOQXBrxGaAHK/5brpTdYOP93RIdxL9vg5MUD6vhp+K3JP/RTta0TZ1R
	 8V5r2SZ6dRkRH1XmkRnVsc+rCbLCp1YpLQPiHyChBXxgo38oqG/ebKa3bve8U+uf7t
	 2baotgtsoaBVw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon/stat: monitor all System RAM resources
Date: Mon, 16 Mar 2026 12:34:49 -0700
Message-ID: <20260316193449.6053-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316102539.2af039f5ca7ce1164da34b47@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 16 Mar 2026 10:25:39 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 15 Mar 2026 09:27:15 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > DAMON_STAT usage document (Documentation/admin-guide/mm/damon/stat.rst)
> > says it monitors the system's entire physical memory.  But, it is
> > monitoring only the biggest System RAM resource of the system.  When
> > there are multiple System RAM resources, this results in monitoring only
> > an unexpectedly small fraction of the physical memory.  For example,
> > suppose the system has a 500 GiB System RAM, 10 MiB non-System RAM, and
> > 500 GiB System RAM resources in order on the physical address space.
> > DAMON_STAT will monitor only the first 500 GiB System RAM.  This
> > situation is particularly common on NUMA systems.
> > 
> > Select a physical address range that covers all System RAM areas of the
> > system, to fix this issue and make it work as documented.
> > 
> > Fixes: 369c415e6073 ("mm/damon: introduce DAMON_STAT module")
> > Cc: <stable@vger.kernel.org> # 6.17.x
> 
> This doesn't apply to current mainline?

Ah, you're right.  Sorry for this noise.

I will rebase it to mm-hotfixes-unstable and post it as v3, by tonight.  If you
prefer mainline or another tree other than mm-hotfixes-unsable as the baseline
of v3, please let me know.


Thanks,
SJ
