Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77542513550;
	Mon, 31 Aug 2026 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188557; cv=none; b=Ji8TUh9cU0pSBEH58Pn+wQDw85yTmpbwaGh0MtPKNJLV7YGb3YtHBqmJs+JbqgHnjXRlB0QYbd6zFzhFf7GdrpFpnMZuo8ahOU5Q4nReNlowZwBG3ubl3Fu7BZ5d1m2IbsSpfU83mJ0A2anfWrgvstAo2HnKYQYEZRsLX6qw9T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188557; c=relaxed/simple;
	bh=FMTJY8tQ5CYFu/2voOK9rmQtbOuXDG1O1x347yWlbFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgxmjqHtpYZN5R8L3XEduooSDnRKTs0fXYv74aaTh1h2ti0FMq+gmvfa37KeJZll94ucYZsgqSVMVqNs6Dv3ddWSsmMxG/JR5/XLWSjcV72VZf2gzpkyf8keJlocLPxYYY58ItBBP+ID3GX2szPLhjDzk/aktG0ZHGC9va175Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP91+K6W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP91+K6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FED71F00A3D;
	Mon, 31 Aug 2026 15:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188556;
	bh=ldXVDAFrMK0WYov6Pz6vPJ0KverWYpiwq3DPXGBw6GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cP91+K6W1l0vMNI+aEt9HBCS/BD6vcbKSlcqecGCbKjPJ0EO/2njoekJReJYjHGds
	 /gpP4UxjDqKgu6WfUbKC55GQGHg8rNohpF5cZfesoRhRkMZkFRO02a4dSpJRqdhL8S
	 o4gLlxubm9ssPjMhpYzRg86UnIGzq9hkn+GXtAH2bkdrrciK1LdVzDOx+3KLqNk4EW
	 ZjCbE9dCe3AAtf32cXyR63y3XfDyjm45kcIbCoc7hyoXAVRUC7ztynZAk+HTqVGEFK
	 FSPJhDYcBQhoZCRQ3AMKiThTSzeLnIiNcNYX0ql8AGGN+ZSO16jpGG1zyXtc1T8Pia
	 hw8QEh50gWFmg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 1/3] docs/mm/damon/design: accurate semantics of nr_snapshots
Date: Mon, 31 Aug 2026 08:02:24 -0700
Message-ID: <20260831150227.83416-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831150227.83416-1-sj@kernel.org>
References: <20260831150227.83416-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

Change "tried to be applied" -> "completely tried to be applied" to
maintain consistency between the documentation and the code.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 4 ++--
 include/linux/damon.h             | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index a8c163475ef2b..af94fc27890b8 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -848,8 +848,8 @@ scheme's execution.
 - ``nr_applied``: Total number of regions that the scheme is applied.
 - ``sz_applied``: Total size of regions that the scheme is applied.
 - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
-- ``nr_snapshots``: Total number of DAMON snapshots that the scheme is tried to
-  be applied.
+- ``nr_snapshots``: Total number of DAMON snapshots that the scheme is
+  completely tried to be applied.
 - ``max_nr_snapshots``: Upper limit of ``nr_snapshots``.
 
 "A scheme is tried to be applied to a region" means DAMOS core logic determined
diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6842a336291e8..d3f45f4dcdafa 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -359,7 +359,8 @@ struct damos_watermarks {
  *		Total bytes that passed ops layer-handled DAMOS filters.
  * @qt_exceeds: Total number of times the quota of the scheme has exceeded.
  * @nr_snapshots:
- *		Total number of DAMON snapshots that the scheme has tried.
+ *		Total number of DAMON snapshots that the scheme is completely
+ *		tried to be applied.
  *
  * "Tried an action to a region" in this context means the DAMOS core logic
  * determined the region as eligible to apply the action.  The access pattern
-- 
2.47.3
