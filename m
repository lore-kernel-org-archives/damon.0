Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58333B970;
	Sat,  4 Apr 2026 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332419; cv=none; b=eJCXNuQohavTRuDkYnyA5n+Qx4yk8NL7SHaCyZ8eqSd/DO9su9d8mhhNtvdFJ9ytZQsaPfgCsuLUJv3TrzbY1GI4zV9S6qD53ZviJXu2WPCgASt4IACkYxn85EU5CPt3xRS5Ha7hsiegTnwl0U3Bf4NIDZ2eU+mPmQ61LitP06U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332419; c=relaxed/simple;
	bh=KIyQFCexOJ3GWSHEbtzW2pSLEsIiY9S8dv+B7bmaG+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3H+oGBk6451VK/X2kQnLBY4M1J1vT22DBIoxMf/A4XVXf5I4RkmBHYw6mP8aeT4nTF3a9QYpO8ZPEU47a9xa+IbiRy2PTd9Wo9R+FY8NF2jhXvAVLqar7DSuKq0IRXjOYyfYA8vUVfuKEEqnX9KFA78hkfP4dcWx5tsFzn0Ums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzAhhg4I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzAhhg4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F6AC19421;
	Sat,  4 Apr 2026 19:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775332419;
	bh=KIyQFCexOJ3GWSHEbtzW2pSLEsIiY9S8dv+B7bmaG+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OzAhhg4IT4uDD6s1jppMeqlKNBGYOCW4X7Ea1BTUPvxmwMDn6eA6xZMZMQ2tIcddR
	 8IuMjJvLcBp+uRc9KBkJr8MFK2hx6Crp2yrGY4iH1C1a7oaT+tQE8CQn5PAp7iJdnL
	 JmJnNoF2/8S9tPNs/RA3lJCnDamB5rotH7ts+gji8lcyXCqLldnaJds/FOsSU2V/+J
	 jk4vRr8DjruUHrDak/o2Pc5BaPz/n8hlChoFFz85DAt8ZKai5OhHPA40XOFmzGrpuW
	 AnZQFxRo3gx5814dtAtskWEc3Oab9R3a051pIaRta2ColzDkw07k1krnuuOjKMXxUs
	 +kvwf2guH77zg==
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
Subject: Re: [PATCH v5 0/1] mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
Date: Sat,  4 Apr 2026 12:53:29 -0700
Message-ID: <20260404195330.85809-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260404012215.1539-1-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Ravi,


On Fri,  3 Apr 2026 18:22:14 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> This patch introduces two new DAMOS quota goal metrics for controlling
> memory distribution in heterogeneous memory systems (e.g., DRAM and CXL
> memory tiering) using physical address (PA) mode monitoring.
> 
> Changes since v4:
> =================
> https://lore.kernel.org/linux-mm/20260320190453.1430-1-ravis.opensrc@gmail.com/
> 
> - Fixed commit message description for DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP
>   per review feedback
> - Added clarifying comment for ops-common.h include (for damon_get_folio())
> - Fixed build error when CONFIG_DAMON_PADDR is disabled by adding
>   #ifdef CONFIG_DAMON_PADDR guards around functions using damon_get_folio()
> - Dropped RFC tag per maintainer feedback

Thank you for revisioning while addressing my comments on the previous version!

> 
> This patch is based on top of damon/next.

Maybe because of this, sashiko was unable to review this.

To my understanding, there is no real reason to make this based on damon/next.
And I'd like to get sashiko review for this patch.  Could you please rebase
this to latest mm-new and repost for that?

> 
> Background and Motivation
> =========================
> 
> In heterogeneous memory systems, controlling memory distribution across
> NUMA nodes is essential for performance optimization. This patch enables
> system-wide page distribution with target-state goals such as "maintain
> 30% of scheme-eligible memory on CXL" using PA-mode DAMON schemes.
[...]

Other than the lack of the sashiko review, this cover letter looks good to me.


Thanks,
SJ

[...]
