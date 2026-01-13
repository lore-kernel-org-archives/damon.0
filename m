Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5524393405;
	Tue, 13 Jan 2026 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318053; cv=none; b=Q1CgOCNwNgQ3I5IXAXb2a//oSx4SQzAeHJzpmIpD0PJ5bte2wZoU2wJxVFuvp8Kwhs9KSmPnbfAfHgWqX7n/llJ6k19ssSlPjtskuV78ufYbkiIc8FvVxVXNJLU/1AFCykZM7wH66yP1R31Lqpuqq3ttonN10lloNTzc1X4IxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318053; c=relaxed/simple;
	bh=Wj0dAUEbE3nyWuMQ+51OFmWg9i5unPK4WiDRQNYOALc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZuZ5AQ/tYgjf7CWrMU3EpN3+de0ZJdbBkihgYFz9XOgNCwXlHJSgoNa5dvCJhlHUuV605Tsbx2SYBKIighppjUhMqbw7Cwd5X9JJVPK4A6XsdgVY/f1nl84X+vpEo5hX0htoIRUxhm8IFJa+Kg4l+PE+DzFiC6B56WNj/1KXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdqTQfw5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdqTQfw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7F4C19424;
	Tue, 13 Jan 2026 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318052;
	bh=Wj0dAUEbE3nyWuMQ+51OFmWg9i5unPK4WiDRQNYOALc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YdqTQfw59TQTrYZHgAP3pNMp/sMoVB6t0t/t+feeT8iON9eWWmQIdgg9tB4lzdMrt
	 0EFRTszgUKharMpOUI3taS5WRcGSpXt1bY2zvJRXQ/rF2Inbs0fmu7eS7d6mw0qkR3
	 oe6TR5PrLMjWmPf/jdlQtN8JHPe3lg0zvHTmjJcanyYXRvMtdAVZQFBSqgNY0S2YQ7
	 3tVZNFOvrpHLBt6jqs13jRVygx0mAe+PUQ4NfIDoPXrOvZXuMJ8y5iXDxBx5fneGZE
	 bMmlhbq4KVYlz3z0t67O8NmMOC3dWaubERxRXMRav6j2BTIkG7Fwdu7dMdxeyKBsrt
	 Q3NXYeY3Vj1zQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/11] Docs/admin-guide/mm/damon/lru_sort: document filter_young_pages
Date: Tue, 13 Jan 2026 07:27:12 -0800
Message-ID: <20260113152717.70459-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113152717.70459-1-sj@kernel.org>
References: <20260113152717.70459-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new DAMON_LRU_SORT parameter, filter_young_pages.  It can
be used to use page level access re-check for the LRU sorting.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 72a943202676..bb222a32aefd 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -79,6 +79,20 @@ of parametrs except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_LRU_SORT will be disabled.
 
+filter_young_pages
+------------------
+
+Filter [non-]young pages accordingly for LRU [de]prioritizations.
+
+If this is set, check page level access (youngness) once again before each
+LRU [de]prioritization operation.  LRU prioritization operation is skipped
+if the page has not accessed since the last check (not young).  LRU
+deprioritization operation is skipped if the page has accessed since the
+last check (young).  The feature is enabled or disabled if this parameter is
+set as ``Y`` or ``N``, respectively.
+
+Disabled by default.
+
 hot_thres_access_freq
 ---------------------
 
-- 
2.47.3
