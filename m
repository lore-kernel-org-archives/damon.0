Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A909D7DA81;
	Wed, 27 Nov 2024 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732742287; cv=none; b=HKAnkG6b9fez12NixC3feh8FLrRc70w4UxGVUPI1QMn0ECnqAKfeg3DLWhw4eZs2DuwC+zv9AreqqGgFyN3G9zOxWW7+ETbLQeTKqgy/qf0MbOhJa+n0of9REdIUGbv0iXFWA7lJ2+ECBJbjZKqh2pkm63ne8CC1nI+BBcaNmxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732742287; c=relaxed/simple;
	bh=yDl5oczllgAYa8WZPNgP0zyrPYISCmrYIjhILQe6iyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RhrOrat+NIfS8PXUNqp8hpgXm5OE6fXFFHcZ8LSa98w0r5/A/ZOXYA6Zqw3ef3jcOm2n4OFMUAF6JnZoAeDD05fVOc3kUcTk0zFRUQ29b93NLqJ3xCEfS8WKdbua+VCMFhl2HDVYsRJ487SvSlO5zdNO2BpZYcudjkUi/EdEZfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ7NpMJU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ7NpMJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06FDC4CECC;
	Wed, 27 Nov 2024 21:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732742287;
	bh=yDl5oczllgAYa8WZPNgP0zyrPYISCmrYIjhILQe6iyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZ7NpMJU2B3xyBjveFVz+LibQwAp1tdS8imzjObUeLB/2sad4GJNvO0C5v/I6O3m+
	 VYCj+QeEO2E9MW3wSSx3XfKTmQyWwgfeJt7WOm4W1aLqzV4AsW2rv93pbED6RpiBN7
	 ROVx7qlP3g5EUOjLK15qqiMYL/46kG+ycbGTVuMDfxwtON/VMbgYEXihe8YbAh5jQf
	 gtbq1BPOsnieIM8pt+bi0GpxxIYi2N7vDdkAiRsOO+gxqfLt8Gv1aowZktuUy9Cf47
	 iip1Xkk1HFFsNBAzW7Y2Xpybe2cb87RB6vww477qQJOL+JQdqwqDcBHPN3YatkIEBi
	 t0JtOYvDhVCbw==
From: SeongJae Park <sj@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	kernel-team@meta.com,
	david@redhat.com,
	ying.huang@intel.com,
	nphamcs@gmail.com,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	feng.tang@intel.com,
	kbusch@meta.com,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 0/4] Promotion of Unmapped Page Cache Folios.
Date: Wed, 27 Nov 2024 13:18:03 -0800
Message-Id: <20241127211803.87124-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241127082201.1276-1-gourry@gourry.net>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Wed, 27 Nov 2024 03:21:57 -0500 Gregory Price <gourry@gourry.net> wrote:

> Unmapped page cache pages can be demoted to low-tier memory, but
> they can presently only be promoted in two conditions:
>     1) The page is fully swapped out and re-faulted
>     2) The page becomes mapped (and exposed to NUMA hint faults)
> 
> This RFC proposes promoting unmapped page cache pages by using
> folio_mark_accessed as a hotness hint for unmapped pages.

Adding my thoughts that humble and biased as a DAMON maintainer.  The thoughts
are about the general problem, not about this patchset.  So please think below
as a sort of my "thinking loud" or "btw I use DAMON", and ignore those when
discussing about this specific patch series.

DAMON's access check mechanisms use PG_idle which is updated by
folio_mark_accessed(), and hence DAMON can monitor access to unmapped pages.
DAMON also supports migrating pages of specific access pattern to an arbitrary
NUMA node.  So, promoting unmapped page cache folios using DAMON might be
another way.

More specifically, users could use only DAMON for both promoting and demoting
of every page like HMSDK[1] does, or for only unmapped pages promotion.  I
think the former idea might work given previous test results, and I proposed an
idea[2] to make it more general (>2 tiers) and easy to tune using DAMOS quota
auto-tuning feature before.  All features for the proposed idea[2] are
available starting v6.11.   For the latter idea, though, I'm not sure how
beneficial it would be, and whether it makes sense at all.

For people who might be interested in it, or just how DAMON can be used for
such weird idea, I posted an RFC patch[3] for making DAMON be able to be used
for the use case.  For easy testing from anyone who interested, I also pushed
DAMON user-space tool's support of the new filter to a temporal branch[4].  The
temporal branch[4] might be erased later.

Note that I haven't test any of the two changes for the unmapped pages only
promotion idea, and have no ETA for any test.  Those are only for concept level
idea sharing.

[...]
> During development, we explored the following proposals:
[...]
> 4) Adding a separate kthread - suggested by many
> 
>    This is - to an extent - a more general version of the LRU proposal.
>    We still have to track the folios - which likely requires the
>    addition of a page flag.  Additionally, this method would actually
>    contend pretty heavily with LRU behavior - i.e. we'd want to
>    throttle addition to the promotion candidate list in some scenarios.

DAMON runs on a separate kthread, so DAMON-based approach maybe categorized
into this one.

[1] https://github.com/skhynix/hmsdk/wiki/Capacity-Expansion
[2] https://lore.kernel.org/damon/20231112195602.61525-1-sj@kernel.org/
[3] https://lore.kernel.org/20241127205624.86986-1-sj@kernel.org
[4] https://github.com/damonitor/damo/commit/32186d710355ef0dec55e3c6bd398fadeb9d136f


Thanks,
SJ

[...]
