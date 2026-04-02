Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B19318146
	for <damon@lists.linux.dev>; Thu,  2 Apr 2026 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138597; cv=none; b=L3scGNzWAuDrAYWuq+VTmxZxhRHaok4VAipF57mgghuHg05wES3U3plrLKAGyzUxO80Md9qA/HaWiLSa2gCzy/IpZPIYl9pEdC9X5rKbT4sTLH3WSmzc7ONrfkxNOURyXolYzH2gH7086WHoevX3DISw4G0nn72IoIANCDAyUNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138597; c=relaxed/simple;
	bh=e6K5RHxaYPNsX/mOpQptU/7bBIEdtD7rePbNU1x6dXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4c4NXugobzraYMGsUA/uGmspV5yDu5XNxctUL4hZ+PraTQ03Rns871wN9oR/cVdJDEmR4czfoE91gaHPW7E6NlYN5siKfkKuNEdFvoz+nOB/ylpU61oQItHWi7P5uDrUWeq6Kq1S946mn1Qb8CxNTpEyIFG5YfT5h91jLRtuFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWTi41wK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWTi41wK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33041C19423;
	Thu,  2 Apr 2026 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775138596;
	bh=e6K5RHxaYPNsX/mOpQptU/7bBIEdtD7rePbNU1x6dXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWTi41wKLZzU76vbzURPULHn/VvvueDAbYVV8qE9QmF/cHJS9Ondz4nFT3A8aDvLh
	 v+X7Ni40TK4venaKYSXn74/LH7Y7g803UsPBUrLj07JCDvlCVwSlPLIDypaU1GPf6L
	 vghHThWBZxTiBmehZfAUrk4FHLV5eFGhHOwXpRHXTACInTcMVEaQGUA/QAzvSivtXL
	 CB7tQ0z+oSNtfVXUOlMuoCJKLg6waHCvKDudZcjcspNxCi3yYX/AJwHc9EqxKek0Sb
	 X/RSjMCMJbbeDElWXHluqNhDDcxU0tjy5oRbNX7cS6/k2qGAzPgIPvGrjAqBURf0H8
	 TVLJqp7DsgHXw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon: validate min_region_size to be power of 2
Date: Thu,  2 Apr 2026 07:03:14 -0700
Message-ID: <20260402140314.74600-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402053756.26606-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  2 Apr 2026 13:37:56 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> =======
> damon_commit_ctx() checks if 'min_region_sz' is a power of 2. But if it
> is not, kdamond will terminate unexpectedly due to the user's invalid
> input.

Could you please further elaborate visible user impact of the problem and
reproduction steps if available?

> 
> Solution
> ========
> Add the same check to damon_{lru_sort, reclaim}_apply_parameters(), but
> return -EINVAL immediately. This is to prevent user's invalid input
> causing kdamond to terminate unexpectedly.
> 
> This patch is a follow-up to the discussion in [1], where we agreed that
> the validation should be done on min_region_sz rather than addr_unit.
> 
> [1] https://lore.kernel.org/20260330233343.4083-1-sj@kernel.org
> 

Should we add Fixes: and Cc: stable@ ?

If we should Cc: stable@, and if the changes for DAMON_RECLAIM and
DAMON_LRU_SORT deserve different Fixes:, I think this patch is better to be
split into two patches, one for DAMON_RECLAIM, and the other for
DAMON_LRU_SORT.

> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---
> Changes from v1:
> - Fix memory leak issue.
> - Link to v1: https://lore.kernel.org/20260331073231.30060-1-aethernet65535@gmail.com

Seems you forgot the patch [1] before renaming of the subject.

[...]

The code changes look good to me.

[1] https://lore.kernel.org/20260327062627.66426-1-aethernet65535@gmail.com


Thanks,
SJ
