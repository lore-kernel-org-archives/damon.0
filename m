Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A0365A18;
	Sat, 16 May 2026 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956654; cv=none; b=o8tVJtIGXDgO7gWNWhORfZpm6+3eg0xTZw35UVbOsvTIHHqa5eh5idpVBOFa6H6mWgvhd6NKqDU2mk+ds53g7hKjoPd4pPXsXpXlmcM4K6f7C5ogUVGUgrbaYJxIiBD0cy6NXOH5qvYcPnfgxdgRMTdMNqLOwdZfOmeOKWLbqGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956654; c=relaxed/simple;
	bh=onL2oA2hYb1zaxrnUJeL671RaJBAxGU6o7+rYnG/uh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFL+CL+SjX7rWV/TPqNQaBdLPOMqCyfN3aOqbIbu9OomRtfAgP5Zv+5axLNXAOyj344xoriPqygvXBsEKfX081XIPv5mAmeOTmTUg9T4/Ee0lBDt5QzMIyJwK57DeojmyBbWAd7Ecg8fQZ+7po5fYujF7vU6Z61X8GvvG2JaBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi0oWhV/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi0oWhV/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F96C2BCC7;
	Sat, 16 May 2026 18:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956653;
	bh=onL2oA2hYb1zaxrnUJeL671RaJBAxGU6o7+rYnG/uh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qi0oWhV/hz3fVqVfc9dcYPFprssBLlVKN9rpYjeUANPC2uPTW25eSDIP712BxzE14
	 bD9+/aog6rGqovT/4eylDDDpeNJOn+fXT5udYwY+LTh+h7f42E6Rh+8X4TCMwAx9RO
	 FY8ehGGRmRIPOXjx6M9/FZkZNPrfsScFYcJ550Rgblgi1APDA8ZL3SMLgKOT3vwDYd
	 qyiiSMt3eFu4iwLI5gxdmTfkPS1cfboGcg75aP2J9p+DX0rylcuvV11X7+hf+l0g+w
	 h5gohnM1hgfVVFw39wr1VSXmbOLW3Ydz6+HsOlnisy2tw3QPQxO7zTcGU3eKYByQpK
	 3YckedT71iVlA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 23/28] mm/damon/paddr: support DAMON_FILTER_TYPE_MEMCG
Date: Sat, 16 May 2026 11:37:04 -0700
Message-ID: <20260516183712.81393-24-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516183712.81393-1-sj@kernel.org>
References: <20260516183712.81393-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the support of DAMON_FILTER_TYPE_MEMCG on the DAMON operation
set implementation for the physical address space.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 81780b05c175e..ad5a65f2398f0 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -124,6 +124,7 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
 		struct folio *folio)
 {
 	bool matched = false;
+	struct mem_cgroup *memcg;
 
 	switch (filter->type) {
 	case DAMON_FILTER_TYPE_ANON:
@@ -133,6 +134,19 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
 		}
 		matched = folio_test_anon(folio);
 		break;
+	case DAMON_FILTER_TYPE_MEMCG:
+		if (!folio) {
+			matched = false;
+			break;
+		}
+		rcu_read_lock();
+		memcg = folio_memcg_check(folio);
+		if (!memcg)
+			matched = false;
+		else
+			matched = filter->memcg_id == mem_cgroup_id(memcg);
+		rcu_read_unlock();
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
