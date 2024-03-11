Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7869857305;
	Mon, 11 Mar 2024 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189960; cv=none; b=a3FFgCxhLRHbhr6no7edlMVjcZBohrLYtJJ8SIYu03JeCRbGVLOsJj1yZ+XTgSSFVqqyzmHlmoykWTvEdbXPD+iL5B8dLBSN9lrzY7rGKMqCase4ndxd9c0NdAsDClJBXIMbxs4tfSu7r0RyIsSSV9sAZpMqOSaRXgT2Ai4svzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189960; c=relaxed/simple;
	bh=fHultMqP8gCokferFy6tApU0Sk9aroAt2aHpbSo1nsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jkd64PwwW+wpf3el5XNRsJaAXOAfhBX/VcffsjH/R/39Bt6stxz92suESXVSjVkOSlGSyVacLikM9v0IMlThrSuj4Zr//3xKwl11J5yYvBmdVG9/DmRte+BECdw4mOA4dVJViTImUxQaM1DBkNCMDIbDRBN0L5nZwer9HxVRLkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLvgqV3r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLvgqV3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99101C43394;
	Mon, 11 Mar 2024 20:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710189960;
	bh=fHultMqP8gCokferFy6tApU0Sk9aroAt2aHpbSo1nsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLvgqV3r4YMJlZJBEZKjbrWC6om6P7NHp4+td02wctGQ4N3G4z7GE9qAALIugj8Iy
	 zWuhVw5VPeN5BFBkHQEw2DqnN9PJ8PzP12e7TgKpaglJp5zBNDZGXDv0WhHOd6AiRG
	 /tdhcB0X496jLKbXT1XXDe73H+lrmBfWEKaG3wQHATYab+otN2mFbzqlxdkLmPpyYe
	 PDN2igIJSFeMWgbraZ1APtggzK2pUeRE4QCsdt2fkTarI6TL0DSCzH7KXThT1wdML0
	 33+Xqm19q6A4lZlgFZz3iU0cMUq8GpK9WvSuWLa3H2gk9OADSIsLpAPWfvMuTED53D
	 lfVd5ZjQ1OwWg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/4] mm/damon/paddr: support DAMOS filter type YOUNG
Date: Mon, 11 Mar 2024 13:45:45 -0700
Message-Id: <20240311204545.47097-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311204545.47097-1-sj@kernel.org>
References: <20240311204545.47097-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filter of type YOUNG is defined, but not yet implemented by any
DAMON operations set.  Add the implementation to the DAMON operations
set for the physical address space, paddr.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 310b803c6277..5685ba485097 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -214,6 +214,11 @@ static bool __damos_pa_filter_out(struct damos_filter *filter,
 			matched = filter->memcg_id == mem_cgroup_id(memcg);
 		rcu_read_unlock();
 		break;
+	case DAMOS_FILTER_TYPE_YOUNG:
+		matched = damon_folio_young(folio);
+		if (matched)
+			damon_folio_mkold(folio);
+		break;
 	default:
 		break;
 	}
-- 
2.39.2

