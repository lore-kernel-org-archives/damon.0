Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248411F891F;
	Tue,  7 Jan 2025 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281096; cv=none; b=pBt34/b0YNSqIaIpP7wtw6EtCa9W0UTqsbcegENVXcowcmKUxN40X2AVSSB7MtUHQAIcFaiTjWfTJwTs/4OznOPQh7EZ5q76tmttX1E2otsaa+HxegvrPpaNOTT0TW8/3oefp2Q3W7X8h/XApgFrTJtjkPoqrk4ZANOrGfvwu9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281096; c=relaxed/simple;
	bh=HXA5UPYM/GgxhLgL56pBJuUIhF/kTZ/VCy8SKfZbnOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bS5x/LGjJsMZC592GYw9kO+K0APjv59kCIfir1ol4oH+AuyFw3UOyIGIORxSn4YEgLSgIjit/Uq/sOsm+sKyAYiIgdqY7KY80kWKH/27GwpA5OdBVofmomUYXFofGqiNmpAXSeThjblnX6zxNyvFqqP3273KJ5hw5It1o97M/2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkcueAy9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkcueAy9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4E6C4AF0C;
	Tue,  7 Jan 2025 20:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736281096;
	bh=HXA5UPYM/GgxhLgL56pBJuUIhF/kTZ/VCy8SKfZbnOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AkcueAy99tJZzibzNuROIjVEKSp3HVa0hplQr2dlkw1Gb4ZhWDBNd/cLD/u/ExntH
	 1S/U5SbspW4U4kLrmfEBFI6cn8HblH6UfAiESFY4H8iIbszBodE56UyX7SMBYU6WXz
	 HVYY7E7ePgU6U6V+HYBMV5VdL1FLM/XgidFBv/I6K+8a6YcRCd/pjavVsIt5/57KGX
	 MwyETpH0e2xqRJOjCZIdiskc7WpdNznQpjK9OKaF+Mhw9Uqry1eCro0XRRfVCB4ozr
	 KIz6kJd4eaY1KZj4C97MNDy1IZwc1WP6gJErNxNCPX6D5NYyYCj7liTu3SrtGNfBKi
	 z0G4cHcLCp99g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/10] Docs/mm/damon/design: document pass/block filters behaviors
Date: Tue,  7 Jan 2025 12:17:36 -0800
Message-Id: <20250107201739.79484-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107201739.79484-1-sj@kernel.org>
References: <20250107201739.79484-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMOS filters design document to describe the pass/block
behavior of filters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 34 +++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 449eb33688c2..3682e719b8a6 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -504,9 +504,35 @@ have a list of latency-critical processes.
 
 To let users optimize DAMOS schemes with such special knowledge, DAMOS provides
 a feature called DAMOS filters.  The feature allows users to set an arbitrary
-number of filters for each scheme.  Each filter specifies the type of target
-memory, and whether it should exclude the memory of the type (filter-out), or
-all except the memory of the type (filter-in).
+number of filters for each scheme.  Each filter specifies
+
+- a type of memory (``type``),
+- whether it is for the memory of the type or all except the type
+  (``matching``), and
+- whether it is to allow (pass through the filter) or reject (block) applying
+  the scheme's action to the memory (``pass``).
+
+When multiple filters are installed, each filter is evaluated in the installed
+order.  If a part of memory is matched to one of the filter, next filters are
+ignored.  If a part of memory is not matched to any of the filters, the default
+behavior is applied.  That is, as long as it fulfills other conditions of the
+scheme including the access pattern and quotas, the action will be applied to
+the part of the memory.
+
+For example, let's assume 1) a filter for passing anonymous pages and 2)
+another filter for blocking young pages are installed in the order.  If a page
+of a region that eligible to apply the scheme's action is an anonymous page,
+the scheme's action will be applied to the page regardless of whether it is
+young or not, since it matches with the first filter.  If the page is not
+anonymous but young, the scheme's action will not be applied, since the second
+filter blocks it.  If the page is neither anonymous nor young, no filter is
+involved, so the action will be applied to the page.
+
+The fact that the action can be applied to any memory as long as no block
+filter explicitly excluded it means that installing pass filters without any
+block filter after those is same to not installing the pass filters, in terms
+of the ``action`` applying.  Statistics for DAMOS filters will still be
+accounted, though.  It is therefore still useful for monitoring purpose.
 
 For efficient handling of filters, some types of filters are handled by the
 core layer, while others are handled by operations set.  In the latter case,
@@ -516,7 +542,7 @@ filter are not counted as the scheme has tried to the region.  In contrast, if
 a memory regions is filtered by an operations set layer-handled filter, it is
 counted as the scheme has tried.  This difference affects the statistics.
 
-Below types of filters are currently supported.
+Below ``type`` of filters are currently supported.
 
 - anonymous page
     - Applied to pages that containing data that not stored in files.
-- 
2.39.5
