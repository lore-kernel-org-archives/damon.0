Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0740DFDE
	for <damon@lists.linux.dev>; Sat, 28 Mar 2026 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774704579; cv=none; b=CRvbtFcP4IaUVCMh3Ar3/E+4PgLiDIb6t7dinSFgSxhAXjE1b8U4L/v/7oJIxOBtVdoAHw1ejVuW3h8rxn7Ott2OKepXy8TNY0iF3N53Z8fTENnx4/QzVqPlKK9SOX5onLsjbRft1BH9DCxzVu8YD0IJ+ZkRR5G7qI+vIQK9oi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774704579; c=relaxed/simple;
	bh=mys/1ZYPavmeUV1mqT0qVhxOQKC1CUsE60UApH2p0p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7B5rn7Q1jII1iMjdueaY8TYf7RuH2xd2dgFBbhLtX7d6OwjPE9PrD4ITUMHns/sjvvll2sFTkhFV/2NzuvU4mYhYJ9By5XD/Tq82FzCJPhQF3cJ/6eylIfZLMK/RpdqUCixbo4GuhjhurFB9jI5/QbElQ7KF3bCj2EJx4S8Yck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2TTFNpT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2TTFNpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15303C4CEF7;
	Sat, 28 Mar 2026 13:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774704579;
	bh=mys/1ZYPavmeUV1mqT0qVhxOQKC1CUsE60UApH2p0p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2TTFNpTfHJLyJoK802k47RjtRf31xzwqkhKxJKVxRzy7fF3oJKzJjyjyi4P9N/fd
	 Lqn8s+yJoa54lGFZH6owgV6tyYvsDEZuhXjKB97M578ISCy3qLDRtfK3zm0gWoPATn
	 1GB89BKfkXG+FAyMvpvg2jhOdvhi0B24HgwcCkKOq08suy8vSTEuW5XdrklTnLFLC1
	 mjujOW0OvEJBtD9lXFMuC7YR65q27aCa7uMaraWIx0rjhLYtSPnwqsr2c7pEDhqKr6
	 D/5IM8H7uBoDhWN/lgEyCKMbjj507cyg25OV7W5/eVcQkHZmTfoabUaZkZw8m3SXfh
	 d29zyZ3arbb/g==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Sat, 28 Mar 2026 06:29:37 -0700
Message-ID: <20260328132937.9580-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328022651.41744-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 28 Mar 2026 10:26:51 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

[...]
> Just to make sure I captured the full context, in my earlier follow-ups
> [1][2] (in case they got folded in your email client):
> 
> - Does the current kdamond termination on invalid user input align with
>   your design goal mentioned in [3] (stopping only for "internal
>   errors")?

No.  I still think it would be better to avoid wrong input-caused termination.
But in a simple way.  Also, it would be better to be consistent.

> 
> - Would a lightweight fix be acceptable? For example, performing
>   validation at the very beginning of damon_commit_ctx(), and returning
>   -EINVAL before setting 'maybe_corrupted' to true. Since no
>   modifications to 'dst' would have occurred, kdamond could safely
>   continue with its old configuration.

I suggested you to try something similar to what DAMON_SYSFS is doing.  But I
didn't get your response to the idea yet.  Could you please let me know what do
you think about the approach?

> 
> Thank you again for your time, and guidance. :>

You're welcome.

> 
> [1] https://lore.kernel.org/20260327064517.68131-1-aethernet65535@gmail.com
> [2] https://lore.kernel.org/20260327121009.38374-1-aethernet65535@gmail.com
> [3] https://lore.kernel.org/20260319151528.86490-1-sj@kernel.org


Thanks,
SJ

[...]
