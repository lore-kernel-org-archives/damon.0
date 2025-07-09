Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E473280CD5;
	Wed,  9 Jul 2025 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059211; cv=none; b=CVXWOScwMv1kYY+TVM9hCVkFGPCh4wtBOKvKH7goGUZkP2PB6f48wQSgdEADWg0n9s1UHQe2hUaAQCItHfHxrBi350Xs+wSaRueOnBjJOVkjMoDTiF8GAXXrjTJcYRIVzrAAto3rI9u7b2lGirviDzNtr1QTYpgqXg/jqvaFhpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059211; c=relaxed/simple;
	bh=XMXplijwP1E5Q0AZ8hTKIOCASc0BkQCBS9592DqXXSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JU4csA02JxB0/yfXOgxafMbUIOrTtByz4d5nVsSPE1+nxFb3yfg5KDmTT6fRKgIVbISBvhF3/MPu0B9QkK9wrenmOtedq1oX1urhYwcMYjtYEAma6n/6y+Zjnp3tekvbdxkdZz4sebpErUnnBRjSIPaxGEcrdPXIe/UtmKda76M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG9c5w91; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG9c5w91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A09C4CEF4;
	Wed,  9 Jul 2025 11:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752059211;
	bh=XMXplijwP1E5Q0AZ8hTKIOCASc0BkQCBS9592DqXXSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WG9c5w91Xj9toKF14iz+X2qGi5u9CRRQOmR6lu2mxx5TuJIFaVwaCetwWmeDI6YVi
	 0xTpTt6ohizOVyQYLwtOh7ADphUTBEIj0YZ3lp/DtzW5ElG5XqogRtB112Z28gZJAb
	 bHRUDlTXW/IH+s3+gS5gUFg7D+8q26Skr90xvhwsckCh193AhxZmvNzwZgWGpjJSGg
	 Eh6dj2RVqiwMWHGLGNt5UPqatow2HhT2m8Neucpgv17o9D7GnJP1vfcLj6pVwEs58s
	 5GihYGGew0d66otqRtaejJQ0udjg8NvyqJ8a6abdAZWx7lH5BW2DeOKOBhRiGqYTJB
	 T9in802m7wd4w==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com,
	bijan <bijan@node0.bijan-262664.superpages-pg0.wisc.cloudlab.us>
Subject: Re: [PATCH v4 00/13] mm/damon/vaddr: Allow interleaving in migrate_{hot,cold} actions
Date: Wed,  9 Jul 2025 04:06:48 -0700
Message-Id: <20250709110648.52688-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  8 Jul 2025 19:59:30 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> From: bijan <bijan@node0.bijan-262664.superpages-pg0.wisc.cloudlab.us>

Maybe this is not an intended part but something from misconfiguration?  I show
Andrew merged this series into mm-new after removing this, but headsup for a
case that we might do rebase.

> 
> A recent patch set automatically sets the interleave weight for each node
> according to the node's maximum bandwidth [1]. In another thread, the patch
> set's author, Joshua Hahn, wondered if/how thes weights should be changed
> if the bandwidth utilization of the system changes [2].
> 
> This patch set adds the mechanism for dynamically changing how application
> data is interleaved across nodes while leaving the policy of what the
> interleave weights should be to userspace. It does this by having the
> migrate_{hot,cold} operating schemes interleave application data according
> to the list of migration nodes and weights passed in via the DAMON sysfs
> interface. This functionality can be used to dynamically adjust how folios
> are interleaved by having a userspace process adjust those weights. If no
> specific destination nodes or weights are provided, the migrate_{hot,cold}
> actions will only migrate folios to damos->target_nid as before.
> 
> The algorithm used to interleave the folios is similar to the one used for
> the weighted interleave mempolicy [3]. It uses the offset from which a
> folio is mapped into a VMA to determine the node the folio should be placed
> in. This method is convenient because for a given set of interleave
> weights, a folio has only one valid node it can be placed in, limitng the
> amount of unnecessary data movement. However, finding out how a folio is
> mapped inside of a VMA requires a costly rmap walk when using a paddr
> scheme. As such, we have decided that this functionality makes more sense
> as a vaddr scheme [4]. To this end, this patch set also adds vaddr versions
> of the migrate_{hot,cold}.
[...]
> Revision History
> ================
> Changes from v3 [10]:
> - Fix bug where huge pages would be split

Maybe "walk->action = ACTION_CONTINUE;" of ninth patch?  Nice finding!

Nontheless, since this was found by you and didn't discussed in public before,
it would be nice to add a short additional clarifications like above, if we
(unlikely) do rebase.

> - Fix code nits/issues SJ pointed out
> - Added SJ's Reviewed-by tag where appropriate

Thank you for revisioning :)

> 
> Changes from v2 [11]:
> - Implement interleaving using vaddr instead of paddr
> - Add vaddr implementation of migrate_{hot,cold}
> - Use DAMON specific interleave weights instead of mempolicy weights
> 
> Changes from v1 [12]:
> - Reuse migrate_{hot,cold} actions instead of creating a new action
> - Remove vaddr implementation
> - Remove most of the use of mempolicy, instead duplicate the interleave
>   logic and access interleave weights directly
> - Write more about the use case in the cover letter
> - Write about why DAMON was used for this in the cover letter
> - Add correctness test to the cover letter
> - Add performance test
> 
> [1] https://lore.kernel.org/linux-mm/20250520141236.2987309-1-joshua.hahnjy@gmail.com/
> [2] https://lore.kernel.org/linux-mm/20250313155705.1943522-1-joshua.hahnjy@gmail.com/
> [3] https://elixir.bootlin.com/linux/v6.15.4/source/mm/mempolicy.c#L2015
> [4] https://lore.kernel.org/damon/20250624223310.55786-1-sj@kernel.org/
> [5] https://lore.kernel.org/linux-mm/20250314151137.892379-1-joshua.hahnjy@gmail.com/
> [6] https://lore.kernel.org/linux-mm/87frjfx6u4.fsf@DESKTOP-5N7EMDA/
> [7] https://github.com/SNU-ARC/MERCI
> [8] https://lore.kernel.org/damon/20250702051558.54138-1-sj@kernel.org/
> [9] https://lore.kernel.org/damon/20250709004729.17252-1-bijan311@gmail.com/
> [10] https://lore.kernel.org/damon/20250702201337.5780-1-bijan311@gmail.com/
> [11] https://lore.kernel.org/damon/20250620180458.5041-1-bijan311@gmail.com/
> [12] https://lore.kernel.org/linux-mm/20250612181330.31236-1-bijan311@gmail.com/
> 
> Bijan Tabatabai (7):
>   mm/damon/core: Commit damos->migrate_dests
>   mm/damon: Move migration helpers from paddr to ops-common
>   mm/damon/vaddr: Add vaddr versions of migrate_{hot,cold}
>   Docs/mm/damon/design: Document vaddr support for migrate_{hot,cold}
>   mm/damon/vaddr: Use damos->migrate_dests in migrate_{hot,cold}
>   mm/damon: Move folio filtering from paddr to ops-common
>   mm/damon/vaddr: Apply filters in migrate_{hot/cold}
> 
> SeongJae Park (6):
>   mm/damon: add struct damos_migrate_dests
>   mm/damon/core: add damos->migrate_dests field
>   mm/damon/sysfs-schemes: implement DAMOS action destinations directory
>   mm/damon/sysfs-schemes: set damos->migrate_dests
>   Docs/ABI/damon: document schemes dests directory
>   Docs/admin-guide/mm/damon/usage: document dests directory

For the entire series,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
