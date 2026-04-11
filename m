Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C846E81AA8;
	Sat, 11 Apr 2026 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775929755; cv=none; b=DuB1aYZ6J1UkY8VFnfI35NpuJsUEs5FPX7TAXEi/nxT6J3bt6qQ3/1RfEMwhU02MUK+6p23/5O93M2K8RxDk6R/kiHApF1In8LtESyml+fsSYiYJAQvr9k7hHhuVWCmkjo3Nhq7Qncy5jHtiK0Op/uPQAH+PbiVlmD4mxCON4/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775929755; c=relaxed/simple;
	bh=+6mYAdHtZoxSPEip1gB6CQRvcztNhH7wHvVyj8tMCMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Skru4Un+d1Q1N1EQswswXvMRngMRip/VXlANlpm+yA8GZgZwKSKKNnjSrSPsxkNAMBMgkkRwxm5XaZr9Sywo5mWNRwd6K4hu1NQkJ/QEPpma1GBFk6n6vHbMDVdpy0sW7zZ2IhUOBAACr0x9ESTT8LWvXB8AIhPXEp9/UnYRNlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NecIxejH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NecIxejH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B2DC4CEF7;
	Sat, 11 Apr 2026 17:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775929755;
	bh=+6mYAdHtZoxSPEip1gB6CQRvcztNhH7wHvVyj8tMCMM=;
	h=From:To:Cc:Subject:Date:From;
	b=NecIxejHHgL7OTGZNJKfdRSYkrGQeFnaOyknArh0kDzSfCJFCvaA+lRyUwh0z3JkO
	 S9MgoemYi3uZWzl+zA6Zi4ZnRF6xR5PJnYTA/+U1LywdxqPvoAgoGYM0ZlJhX3eRqm
	 7D7ppemTslRGqDBrZ7TZYguNFIo/IumMDnaEwJ1d6/C4n3Nsn6b0cqOT0CCSJ7gcAX
	 vxCJPV2uf25iF6rXN8384gJhlkaGeAYqVOp3lQF8uJvUFlNCqBfAl6lVrixFv/UtZm
	 QUBFY+vaU+OBrFA5gpxkpoCWdZ1BGJ7jRo+zVHlL2USpSRXHC13dhd1FRxgM/nxT45
	 dd5FMrlcEbCxQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [PATCH] Docs/mm/damon/maintainer-profile: add AI review usage guideline
Date: Sat, 11 Apr 2026 10:49:04 -0700
Message-ID: <20260411174906.79491-1-sj@kernel.org>
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
 Documentation/mm/damon/maintainer-profile.rst | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index bcb9798a27a86..5c23b1281c50c 100644
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
+in AI reviews.  As a rule of thumb, drop individuals except DAMON maintainer
+and stable@vger.kernel.org from the recipients list.
+
+`hkml` also provides a `feature
+<https://github.com/sjp38/hackermail/blob/master/USAGE.md#forwarding-sashikodev-statuscomments-to-mailing-list>`_
+for such sharing.  Please feel free to use the feature.
+
+It is only a non-mandastory recommendation.  DAMON maintainer could also ask
+any question about the AI reviews, though.

base-commit: aeaae01df7d17b5742e22b65b06f666ddea76816
-- 
2.47.3
