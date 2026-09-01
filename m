Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C8130649C;
	Tue,  1 Sep 2026 04:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237267; cv=none; b=ZTSVqXDW8IpvaInb7fDU5dUaioVurz/zdkaqDRkeHdMA81yMZC+a3qNgjYqdW/94DMjxMUT7CBhMmoZCSdPo0ZGcoWq88mQKii8GiMkxERHn9K2a61PzuofEDmUe1LP1UW4v8Yp9WVpmf2VvcqHN8uNtLTwk8Z10BZKQTJg8Eqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237267; c=relaxed/simple;
	bh=ieT/ne0vOY5EYTrH52WVPjFrGyxfjporIuBqWV3GlGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3dfYcdSlNHv9+2aeaUo7eyw5kaeWNhOw604T+rXmz/wtKg9CpvudzvBjA5RymZNutJT8aeoB3m5n3i+jrd7jUI2Gg3KNytt+hNqFAZHLPG3/vhA2af/lgvrVi8xYBOl0Yi3KZjU2Mn+TQanz3nHFBLyaGziUtoHcg3DwhmQWlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYH3zQ5S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYH3zQ5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E065C1F00A3E;
	Tue,  1 Sep 2026 04:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237266;
	bh=atWhsqWAE5VXdJdWplOPI8OSXhIZpjioTpYT4VKG/08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lYH3zQ5SYuwmCzVXw1REpmSNZgFjVOsByf6Q1uK0lugnPZhdQWMzCHvyY4kH+Z3RV
	 oUTL0YnSlkcmSj1DGoGZf9ya/a2JfqIoPPNpD8728FfC1jeYBqLMx+rBC6IeufIehi
	 o+8xoqtqOA4nxI6KoEJV/Sfg3TcOUNXSGHaNP43tBO4ZuFQT490Ux9Mkx3nKVGHYxa
	 Ce8sCG0hmz/9kEgQw2dDvqoPTCFE8dVqYplQ0N/VaiCYFlHnV0Dbi3oGkZW7fz7hE0
	 i2KaXBCGMPg3r1qkYEjM6n6PjJCwG2T/OWYkMjAElBAb+dgRFH4otY681Frxkf2hVF
	 qgwyMFxfkeaFQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/17] mm/damon/paddr: support PGIDLE_UNSET probe filter type
Date: Mon, 31 Aug 2026 21:33:58 -0700
Message-ID: <20260901043417.2165-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901043417.2165-1-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
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
index 9ddd1ec8202b7..6f756f8493894 100644
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
