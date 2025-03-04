Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C427CB12;
	Tue,  4 Mar 2025 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123167; cv=none; b=g/3OH06YITdcg2G6A125kzjGpxE+KFVKfDqLv2jfZzNTLo10MYfgt4zlYpRQjJySk30dc2DIJ2UjMwY4VqW9Wwl53XaHcOHEtL9Pj74JKn6nYd6A604NLPhOLdu/fmCaOg/3XsCaRg20EFCbnzsJaDQGOrOwllPTIuIKO9DpQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123167; c=relaxed/simple;
	bh=MvYdk6+CJs1x3c6be1UzpWng25V7d78Qpub9AKz7s0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UnYByb5dmHk0dHhubw4AlkP7UEpXy9zmd92TviR5XzhUosHy0d6AqwWeNETcWlGEEl8dblN0JHD6tCsqcJ1uHmpyI5aEmBYA25n2YSXNjtJWET54PccfFCeKgNSwW+WF4WL0nKgDSXanZPQaaRce3VHvlDBZgtCx+3ghIO45P7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+yFtLDF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+yFtLDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1049CC4CEE5;
	Tue,  4 Mar 2025 21:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741123167;
	bh=MvYdk6+CJs1x3c6be1UzpWng25V7d78Qpub9AKz7s0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+yFtLDFGNtuTNbyJUs+cxgvACAguJ1tXWM+lVJ7fZHcH3tKreNyIYL/74ILQnPBF
	 LlTEEqtW0LpjlYbcTMRDaiB0S8R5VwCl0QAmj4+m4Z/cMKj7SnTTIZH0u0dGbq15km
	 XK8ubi0/sZefriDo97HjeujAKsKrZA4rtUA6leE6Z7jQFr81uQtBYPxTRh9QM6VEcw
	 DhPEPbOV8b4U43JYDC4igFQ6atTlB4hhQLvgcCwUjdYDOoZC7ifnG4fpihSm5GpHwY
	 YejZz9hEeZTh1c0n966bcFw8g722XNw6Lg6sL9DBfHXMS2xhiBKamFd/HXqSdbxpZn
	 +/ver5JBcmoZQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 9/9] Docs/mm/damon/design: update for changed filter-default behavior
Date: Tue,  4 Mar 2025 13:19:13 -0800
Message-Id: <20250304211913.53574-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304211913.53574-1-sj@kernel.org>
References: <20250304211913.53574-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the design documentation for changed DAMOS filters default
allowance behaviors.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 26c9ab10daf7..0cf678d98b1b 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -631,9 +631,10 @@ When multiple filters are installed, the group of filters that handled by the
 core layer are evaluated first.  After that, the group of filters that handled
 by the operations layer are evaluated.  Filters in each of the groups are
 evaluated in the installed order.  If a part of memory is matched to one of the
-filter, next filters are ignored.  If the memory passes through the filters
+filter, next filters are ignored.  If the part passes through the filters
 evaluation stage because it is not matched to any of the filters, applying the
-scheme's action to it is allowed, same to the behavior when no filter exists.
+scheme's action to it depends on the last filter's allowance type.  If the last
+filter was for allowing, the part of memory will be rejected, and vice versa.
 
 For example, let's assume 1) a filter for allowing anonymous pages and 2)
 another filter for rejecting young pages are installed in the order.  If a page
@@ -645,11 +646,6 @@ second reject-filter blocks it.  If the page is neither anonymous nor young,
 the page will pass through the filters evaluation stage since there is no
 matching filter, and the action will be applied to the page.
 
-Note that the action can equally be applied to memory that either explicitly
-filter-allowed or filters evaluation stage passed.  It means that installing
-allow-filters at the end of the list makes no practical change but only
-filters-checking overhead.
-
 Below ``type`` of filters are currently supported.
 
 - Core layer handled
-- 
2.39.5
