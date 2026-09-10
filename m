Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE333043C8;
	Thu, 10 Sep 2026 04:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013366; cv=none; b=KCez6KITkjlD3NuyWS5APaYVS6F8TlTTTFz8wcAO52pUPlAF6SvAZzLM3L/8Sk4bJHV+fa6qlL07CbWMcaF3zlKBkyyr+maBDp0hYLiI1IDYiYORLqn7g7gc9A9kJJ/tZro4VPYpimdSvCVUqU2BF8fgEL+jDhTM0D4qHgbuB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013366; c=relaxed/simple;
	bh=b/pA1nCyMg+CbM0qexhTZTS0Mddtk+mMffPWt8/OJJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQK6f333Tzy5f++ViSp0sbX/PdI7eSt679sVaPxEyaO51F7gOhRIcXzXUHgSVe6SpOCDGyjWg964xGD6l1lTxyZw4PcScJCGO2BB6Y2lbSbAOcEv93kopHTGMY6e0ZpVpG3T3jWeTJY+vZVFHNywuoF9LQ1VRXXc8ss/H0olrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIhR1Thg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIhR1Thg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C8A1F00898;
	Thu, 10 Sep 2026 04:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013365;
	bh=Ujxj5yZhRYtIbo6ExzhErsIpeWFwIc8YKBiGwvcIFOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VIhR1Thgx9vaGfgneXncEsrPex/rTuCb4Dcvr/ZFIG/8ScICVZcFNGt1stg4m+OH3
	 o07rKZIBUo5URg09BH/D7ka/GUT6UICRItjHfzITK+I8cSkimROsi/x4Y1NXu7ugrj
	 wZmTD+k3lU29mwYBaDGN+ZNyu9RKTjYWY1GeqvgUGqIFUpGcBDUgDUzFVqowoXce+R
	 YipQKJAf+dSOIO7SS1JXQnyZ2AUlAsfbnTzkCFxO363F8NQlBDZMQeWhYL63LHAvYv
	 lPbK3JyuWJpBELAItLs/NJfGfE80vn2fKXY8MxXnGpqivVT+1O2XMZgNjdmjZzgvNQ
	 egd0mE3TLpWSA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 2/5] mm/damon/paddr: support DAMON_FILTER_TYPE_PGIDLE_SET
Date: Wed,  9 Sep 2026 21:09:04 -0700
Message-ID: <20260910040911.148273-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910040911.148273-1-sj@kernel.org>
References: <20260910040911.148273-1-sj@kernel.org>
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
