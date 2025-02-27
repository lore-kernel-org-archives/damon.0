Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B899139E;
	Thu, 27 Feb 2025 01:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621491; cv=none; b=OBWew91s938tykafDuvh8dkYPRsMDa3s786GsviV7bMH4y0f6y/5fgu7kPf03ABi6gc7IDfjsMHpS7eMk6HCCcB4hSsG2HCiBYtVeSgzJ/fQaX8ycVEjq1DhIcdOtOPTLxciuEFmor0jvu7E27lFXBW/vB6JqPkjL6IF3IejPP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621491; c=relaxed/simple;
	bh=tQqSkhuPbb1T5x6cMu4V0N9ePh3tWbcGixS02DkoMHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCTV4A8N+lctoB5ruKDNlbfBgmPUBweZiTrRc/cOS9rTVAK9cy8TDlEhMtmW7OyqV3avPbBxU1ZbCkdN0686s9iANkjSgYBj/DEKxdnD2qzTqsf662u2Lx7oMVytQ924kqFqBLmRqHyurCMuC/f7sa9xIozzpMMklOYCXZ6nk9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFoEwWOQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFoEwWOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04EEC4CEE8;
	Thu, 27 Feb 2025 01:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740621491;
	bh=tQqSkhuPbb1T5x6cMu4V0N9ePh3tWbcGixS02DkoMHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFoEwWOQMtYL3tiHZY1Klb9D+0FI6oiHIg3qJP9gQ78IuyJzv7mC4Z5XiRo+eS7nE
	 +X9R8bAUwlgr0l6XZKdzqTkFzZMhmbd/P/Eha3YGAjfIylzddDwrO7+ZyoLTLWifu5
	 Tu2FKElANpXcF/pdBlIchfNiSWjeMm3yJ1J+d1+450u2LbP2A3i/gN+uwdA4m690lK
	 fMyX5xpGp9iB9GtaAZHtik2A0zQ/Jck7wC2VdhVNvpV4Q2movxtcZQMD9ZdPLGG+TZ
	 rshdBICJI0Y7/Iu2K60V4q/eKP4SucGbQPACyRyshuj2ZwIBdhYJT7S5rtRc7HD2oa
	 4SoI53OREUdiw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 9/9] Docs/mm/damon/design: update for changed filter-default behavior
Date: Wed, 26 Feb 2025 17:57:54 -0800
Message-Id: <20250227015754.38789-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227015754.38789-1-sj@kernel.org>
References: <20250227015754.38789-1-sj@kernel.org>
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
index 5af991551a86..ffea744e4889 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -581,9 +581,10 @@ When multiple filters are installed, the group of filters that handled by the
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
@@ -595,11 +596,6 @@ second reject-filter blocks it.  If the page is neither anonymous nor young,
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
