Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30D42B75F;
	Thu, 30 Apr 2026 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558825; cv=none; b=eMK8CKxOJ5LX8Y13pgM+Ye2mDpV/jcKm+KtAUidA3Vl9Hf0k5jc+TqO1Hch8QBNIL4xvHc/o0pAJfyoWU2r45rOQomzLvUCmZ5NwbsMiU70JNsPApEQNA4VBWCTt6blI1P2U+yBiJdfp93Qamqmwn9e4yvMRBodHyiBaFJ+XtRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558825; c=relaxed/simple;
	bh=Te4GL7YI2bga7ObPIqHKNdIOFUrcsNxgo3oTxgGUtEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYsDgf2jvehPKXnNXeIo6pXR27+Xt7SWGBHKzYxKB43COrNBIvxIPk33MlhV+A4zM7pHky2DYGlIXDHy5CanLD9pXsMvAarc7NpjCTCeC34UbEc32JzDQlrQazKhe03MA/dhRReW0TPUD5v9ZxNHJkHncPfM9PuMFSQeit4NAsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f71is1W0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f71is1W0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573D7C2BCB3;
	Thu, 30 Apr 2026 14:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777558825;
	bh=Te4GL7YI2bga7ObPIqHKNdIOFUrcsNxgo3oTxgGUtEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f71is1W03Gv5p9K6GlrFzAT2iUxOlUj4H3VnjrbHxXYbFPybR03a07PgR0YoSD+od
	 1DN0qv76USgK4oJCBh4E3bxxpNkdmjYhIoGW3KFPlc+hSwbKIWQbXVldndQ20v8fQ7
	 JXLa8Qf7izxzu0+b2Yfc1t44XGC2TL6pLjjoN4bk96ttqoQWfJsi4ywu9xYxBicm+z
	 LQD2nws99o0wkvm0XgII/ALLNjH2TMst35vvdYGOeVl4caUmF2nr/oldbO1pmIZmMm
	 2kGqVBG/iOIzzcKyFgM9Uk63tl3tVKC0I4JlaiAG3IkFjexZibebCuVwAaPcrrR4ZT
	 6rpBRZXZOF5+w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 2/2] Docs/admin-guide/mm/damon/stat: document kdamond_pid parameter
Date: Thu, 30 Apr 2026 07:20:10 -0700
Message-ID: <20260430142013.80993-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430142013.80993-1-sj@kernel.org>
References: <20260430142013.80993-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON_STAT usage document for newly added kdamond_pid parameter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/stat.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation/admin-guide/mm/damon/stat.rst
index c4b14daeb2dd6..46c5dd96aa2ed 100644
--- a/Documentation/admin-guide/mm/damon/stat.rst
+++ b/Documentation/admin-guide/mm/damon/stat.rst
@@ -89,3 +89,10 @@ percentiles of the idle time values via this read-only parameter.  Reading the
 parameter returns 101 idle time values in milliseconds, separated by comma.
 Each value represents 0-th, 1st, 2nd, 3rd, ..., 99th and 100th percentile idle
 times.
+
+kdamond_pid
+-----------
+
+PID of the DAMON thread.
+
+If DAMON_STAT is enabled, this becomes the PID of the worker thread.  Else, -1.
-- 
2.47.3
