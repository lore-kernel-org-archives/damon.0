Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC717308F2A;
	Thu, 10 Sep 2026 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050163; cv=none; b=sKdtIxJB2z/G41xaUtz9Dv2dtndQnAyU7aQJGfnoqMSOmZDTSz2VWxKjrIdaDjBJ8Sq5eB5nMQKMQ63wYMlZmqncD2HfGPenQa/Pe7jcMwLlvtCfJdUd1e5V8n3nHDrgvaqXZYyg92kJRxWKu77IJ6Ga3cYWncvAV568czkR0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050163; c=relaxed/simple;
	bh=b/pA1nCyMg+CbM0qexhTZTS0Mddtk+mMffPWt8/OJJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GN3ngf8CRbJCtzmupF5b5qQXG/B+msN3x9Oy566puaElozw/NdyL7wx3OPzZsl5xG/Tay0ZnQFFo4Yx+2Lp0keJEyH+7F4/MKiPKB6XdlPT7Hj85fhPP2KBKFax5FVGJMsqcke7sgBPTWZOqauYeN+gUC+I/7jQdDA95UpWCBcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exa9FmDP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exa9FmDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A471F1F00898;
	Thu, 10 Sep 2026 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050161;
	bh=Ujxj5yZhRYtIbo6ExzhErsIpeWFwIc8YKBiGwvcIFOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=exa9FmDPuLLk4ySV5zRZ7Gerh+miD0YW6ZjX8DHUbTeacEm9wEPc3ZdGifHJdGhgu
	 ALqujmwfqckOlyRgRWXe7vIFgMKiK62VmmFESwk+0+8VMaOWKtZNYEVwws4q7+7qXR
	 h1/u4bL/i+kkpLKjYeRqXWrH7L/JMk3+0ZFxRZu2F03aaRMyvoREwRhO7AWvWMkf08
	 4iXbRXN+7p5i+/Vad/0w+CmXJEVQUdcvw93OhvsdU6fh9pg5z+gspXL4SArYjzrp+W
	 BAVLbSf+QnS0QeMSLvowlhlJDft2bq3XhZLelUUVz5GjShthroAzJrUA/5eEg/jRCF
	 ugLPEz0U7KciA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/5] mm/damon/paddr: support DAMON_FILTER_TYPE_PGIDLE_SET
Date: Thu, 10 Sep 2026 07:22:29 -0700
Message-ID: <20260910142234.171562-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910142234.171562-1-sj@kernel.org>
References: <20260910142234.171562-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement DAMON_FILTER_TYPE_PGIDLE_SET support on the physical address
space DAMON operation set (paddr).

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b8f4d28165dd7..5abfabaa339e0 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -151,6 +151,12 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
 		else
 			matched = damon_folio_young(folio);
 		break;
+	case DAMON_FILTER_TYPE_PGIDLE_SET:
+		if (!folio)
+			matched = false;
+		else
+			matched = damon_folio_young(folio) == false;
+		break;
 	default:
 		return damon_ops_filter_match(filter, folio);
 	}
-- 
2.47.3
