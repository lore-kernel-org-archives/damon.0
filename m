Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193133DA5B2;
	Sun, 26 Jul 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087592; cv=none; b=nOvkkKCQts0gTGCNAr2prNJmVqdphdTT/OZO+640AOp2uUfkq3w2JXouwAtgSCJAaXO5aDjvUK72C+Eu/45ghMdOykrwJ2QEZAN2HpTfUovneF3VY3mu8CX/pa7Fem1fhYQXhOaHd5/WeNRI2VLXjuQpYCTXoKyj1QezGx7yjYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087592; c=relaxed/simple;
	bh=aoRgt2zs3P3du5y3Rj1fYcZJYPyHzaafK4HDrZKqtGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHlSbsi5+xJk1z6+HHI4s1aOXIAK+cjsxeQZ9GckPanxdTNEu9zxrCaU2/7nlodJwfH9beZY9yiCAheURGcsI7ZYwco1On8pl0C1XWwfxivOZnnOoKXSBRyKty4d8ksLOLoMu+cJFm/+tntARZZYYtuaoC9ZWe8MCwpJH4Az4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfxKAN+U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfxKAN+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930A01F000E9;
	Sun, 26 Jul 2026 17:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087591;
	bh=zLddCQIKLIqqHQQB1XegUK1ksWkMV2zqLgwJFjP3qcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VfxKAN+UXDa+v0mAcGrhe7wCB5ya7W/uQKmpvzAz4W1il9FKDeMlDVPicXUcJqUsb
	 6uj9RloR/Kohn5dO5zBzQhEtdLH9u6u60Ha8+UlTwcYGnZkKwd+FINKOv4OvkbPr/P
	 mFJiSE5vaz6O5vKiBniwVFCtn3Z26+zuLOHLZyJAJHR4ku99qc03qbN4T+6CW6OTy9
	 4TuFkLmCk+eGVW7r7l+3x5gpXCMSsw2vSkl18Dn3NDqKlM8cMj/xAx2Wj2tQvgp0Xh
	 EeEv3mh7uuAfojsxXq4F7pYuRhDl+zQhrKsjQ9jDKrbPeD7gh2UzMmXigU0vKRVkLy
	 5hgrYa7QJn8Jg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 17/17] Docs/ABI/damon: document probe prep sysfs files
Date: Sun, 26 Jul 2026 10:39:33 -0700
Message-ID: <20260726173935.94046-18-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726173935.94046-1-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added DAMON probe prep sysfs
files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index e9488bb48d23c..339b7c4177ab7 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -173,6 +173,19 @@ Contact:	SJ Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the
 		per-probe attribute weight.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/preps/nr_preps
+Date:		Jun 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for each DAMON probing preparation action named '0'
+		to 'N-1' under the preps/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/prep/<R>/prep_action
+Date:		Jun 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the probing
+		preparation action.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/nr_filters
 Date:		May 2026
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
