Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA2B387359;
	Tue, 28 Jul 2026 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211974; cv=none; b=f0QDghzJc4HdlwoC4AX1ouD5PXFJ6EC8A0BhQGtmJkUU53y2sbDjApWl2GbfShP9fnOVxY25UaYlDE4mW41uPUAlTOEqf+IjLwiI4jHlwYl49Bs4v7pQAy+kyFwXuenAk2ycMRVK8fy4S5HdXovuKpU22wa5zIj7Ehw0h1jWd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211974; c=relaxed/simple;
	bh=jpq/IlpRlDFv3aOnFkdxRMPdHVCj+SY7//xXwyTTJK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWHtlvh8qk2xRIpRkuDuxUjtLvW5L8GecBT6n52e5xsMidfAC+N3Hs52rwy6GG1Mi11sa1wlwfJdPFL56uIUH7gF+frHD7eaGemrXqG6im//mgSWm+hegmLt2XqCyOmSx9BUVA7tRiApM4CwcQCfgOOOiAKl/bgWsVfb2ovVJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU7cvj7f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU7cvj7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C831F00A3A;
	Tue, 28 Jul 2026 04:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211972;
	bh=g9G+NjVl63rSPH9VnWm2f5oghlS13iCb5rZjc3IcuDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BU7cvj7fItepfo7P2H5V6mbK+RlllHjNhRlbYmlE8x3f5l8wkYHZvT6OP2OEuxajd
	 7bveIAFbpH+NxUTv3jAxiqTcOrZ+NI9THdXyEyDMHUpu5+MmAlbLQKWbBL3U0uCP/Z
	 2XQ5fLsNjbqzpdZkkL7dIO7Dd9/lM6KqyEkp39x05a7ecpfkzqUImVIaVpjbB5SQKv
	 niu3J7WSSKaGOUz/awPMx+3vBCQySEbITp5vEBhL2PcUr9shCmQcO4fslmFaMx6erz
	 nLkWoVjIAnEpDid3DogN4rYOOIoV/n4wjTgQucrdgWt0Z9l+54MQZTEUr90aOO2dGw
	 oyaggPaJIWtRQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 02/17] mm/damon/paddr: support PGIDLE_UNSET probe filter type
Date: Mon, 27 Jul 2026 21:12:23 -0700
Message-ID: <20260728041242.187380-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728041242.187380-1-sj@kernel.org>
References: <20260728041242.187380-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support of DAMON_FILTER_TYPE_PGIDLE_UNSET in the physical
address space DAMON operations set.  It reuses damon_folio_young(),
which was being used for access monitoring.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5c6c3a597fd0b..5b307dcbb2a50 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -132,6 +132,12 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
 			matched = filter->memcg_id == mem_cgroup_id(memcg);
 		rcu_read_unlock();
 		break;
+	case DAMON_FILTER_TYPE_PGIDLE_UNSET:
+		if (!folio)
+			matched = false;
+		else
+			matched = damon_folio_young(folio);
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
