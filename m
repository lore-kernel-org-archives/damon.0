Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38AB146A66;
	Sun, 12 Apr 2026 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028781; cv=none; b=g4fQd8JtpslCGIKVUDt7LYkachQ0mljEkzFEd3f9i54/Ib4INa60s4KqYIDwDcAMEStcyOcBz5xr11JIvjtqjby5en+tUj9MDrk3KE/rnmcwzYrb9pxm/EDZep+eR+8gQNzqBjmXgRL94JtG57x2q6X3uUvxJ8SJHNVQ+ADGcyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028781; c=relaxed/simple;
	bh=A+viAtzJhebo8EZLCtKP1pqNz8neWzmWQtOaasROq5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmP36onCMe5wkkARahu2opSIgMfPmxoy1/73aQBXcSlWGlKgDA3OSJmFQqDevhhAD6vbrwNeR1u5d1g0iUhlaKOmKGQGaozJe1NSBAx++ZfEeQkMkO2mocpdwohhyOwA2mbpmRqFk8ysj8lVaM6CNl+V5m3rDaeN/d4GgSBn6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWqUOw6W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWqUOw6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBF5C19424;
	Sun, 12 Apr 2026 21:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776028781;
	bh=A+viAtzJhebo8EZLCtKP1pqNz8neWzmWQtOaasROq5E=;
	h=From:To:Cc:Subject:Date:From;
	b=uWqUOw6W58RXhfqMvzzHjaiqCSMnugIccRIlvCBDUZbR5n05lrVD3dsDRoFnDJJDV
	 dz9/qvoDWtgV843kX1KtouCgqUwXJcx6V4Zuw5+Y48muX66ZiH3vt634iAlRu04ZWy
	 yTgQCE7NmgUoIWfZaMFR2jG40eJsXvd4cXAzMf6XIowPJ8dX7Jm0VAw32MAhqSkeDy
	 Wm46TJ5TZdPf6GaO1lThQZMd5JIyeCN2LYR4JykBLAgGDV3I+1pbc3qqRuNqY7tY1f
	 BX6+ZhOFGkogLg8KtaGXyaT6gp4CIMlTrdqI4R5xrZDyUy6FSUH0QJIlnfjZ2mXZRS
	 3utuA4U8c3T5g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	sashiko@lists.linux.dev
Subject: [PATCH] Docs/mm/damon/maintainer-profile: add AI review usage guideline
Date: Sun, 12 Apr 2026 14:19:31 -0700
Message-ID: <20260412211932.89038-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON is opted-in for DAMON patches scanning [1] and email delivery [2].
Clarify how that could be used on DAMON maintainer profile.

[1] https://github.com/sashiko-dev/sashiko/commit/ad9f4a98f958
[2] https://github.com/sashiko-dev/sashiko/commit/b554c7b6e733

Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260411183029.81030-1-sj@kernel.org
- replace typo-ed word: s/a non-mandastory/an optional/.
- wordsmith recipients reduction rule of thumbs.

 Documentation/mm/damon/maintainer-profile.rst | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index bcb9798a27a86..fb2fa00cc9aa1 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -100,3 +100,24 @@ There is also a public Google `calendar
 <https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t>`_
 that has the events.  Anyone can subscribe to it.  DAMON maintainer will also
 provide periodic reminders to the mailing list (damon@lists.linux.dev).
+
+AI Review
+---------
+
+For patches that are publicly posted to DAMON mailing list
+(damon@lists.linux.dev), AI reviews of the patches will be available at
+sashiko.dev.  The reviews could also be sent as mails to the author of the
+patch.
+
+Patch authors are encouraged to check the AI reviews and share their opinions.
+The sharing could be done as a reply to the mail thread.  Consider reducing the
+recipients list for such sharing, since some people are not really interested
+in AI reviews.  As a rule of thumb, drop stable@vger.kernel.org and individuals
+except DAMON maintainer.
+
+`hkml` also provides a `feature
+<https://github.com/sjp38/hackermail/blob/master/USAGE.md#forwarding-sashikodev-statuscomments-to-mailing-list>`_
+for such sharing.  Please feel free to use the feature.
+
+It is only an optional recommendation.  DAMON maintainer could also ask any
+question about the AI reviews, though.

base-commit: 507d761b28278a923d86e7a29c5d084b74639e15
-- 
2.47.3
