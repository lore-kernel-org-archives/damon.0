Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9D23B47E0;
	Tue, 28 Jul 2026 05:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216501; cv=none; b=iHlh/R/CEwo3fPdp/cOoD8ERVRwqTQ53z9bgs2Xbf6nOCMiiyu4KufZGDEPU6trn1s6PxZ6v7mfNmANI5Vt2oJ91I9KFqV4mQvQ7+E3bNWaNlQYZQcwMZUfewTPJenmoRyPT9s4XRy70F7lopeWin2PYU4BmMRy2omzCk0TA98s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216501; c=relaxed/simple;
	bh=94L9Y6jblqW5ICiSyH0suMgSyVNNc6/w7ucmr3p0soQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6v2W5v/NS2aFks5rKiIyg+t1Bdqlc1TKE8FsPjBf7ZnicSqFosGVYa6ek0Db3R9oEa/PzmpTkXCTi1esB8JrtE0W0pPIHp/6fcQcSZhpgIybMWTEUypXnINy8GuevbQaV/DpkmeoPj3t5AZdBtJ37OG4Vh9WhGetvWQ4qHtDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVt3VbG2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVt3VbG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA061F00A3E;
	Tue, 28 Jul 2026 05:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216499;
	bh=+7L5cUB5gmn/G0XCH5EnzRVEYnRmQ6289QitHVcV3Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QVt3VbG2+UUJwhyOFGMlC4p5BB9UX9zAbrDUSY4ugI3W1kI2lxkdwDG0oAlGC0S0m
	 7ViLVdAdd2KFukOc6mIwbE7YUG9jLqlxhooMrjKTalB3SHGjL6s1pmvg+Ru4b1ry1e
	 XZGKX7c8B3OPzellSm3tJOmJtldea4eFv+ifNg7XSIOW5lySQKpadFokmN1ZLLx+di
	 oCVC2HdOqPhzAHF1KfVAyvnMgusOD27Z1gcO+EuVXA/GW0qYTOsBbHpRnwf3dYknW4
	 I4jF/VbbIJIT/AMRRV8H7V8iw+En+xxauXjO2OrmmJFw7/i2/MagjBXQxYvxlPtLw0
	 Q5/PkpCsoNXoQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
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
Subject: [RFC PATCH 09/10] Docs/mm/damon/maintainer-profile: update AI review for Sashiko replies
Date: Mon, 27 Jul 2026 22:28:08 -0700
Message-ID: <20260728052811.192712-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728052811.192712-1-sj@kernel.org>
References: <20260728052811.192712-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the past, sharing Sashiko review results was tedious.  Also it was
suggested to minimize the recipients on the sharing mails.  Hence the AI
review section of DAMON maintainer profile document was updated to give
guidance about available tools for making the sharing easier, and how
the recipients list should be managed.

Now DAMON is onboarded [1] to Sashiko's automatic review replies
feature.  Sashiko directly sends its reviews as replies to the patch
mail thread. It also reduces the recipients list to deliver the
reporting to only the author and the mailing list.

Remove the old guidance that is no more necessary but only confusing.

[1] https://github.com/sashiko-dev/sashiko/commit/b554c7b6e733

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index fb2fa00cc9aa1..a7c1352339378 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -106,18 +106,9 @@ AI Review
 
 For patches that are publicly posted to DAMON mailing list
 (damon@lists.linux.dev), AI reviews of the patches will be available at
-sashiko.dev.  The reviews could also be sent as mails to the author of the
-patch.
-
-Patch authors are encouraged to check the AI reviews and share their opinions.
-The sharing could be done as a reply to the mail thread.  Consider reducing the
-recipients list for such sharing, since some people are not really interested
-in AI reviews.  As a rule of thumb, drop stable@vger.kernel.org and individuals
-except DAMON maintainer.
-
-`hkml` also provides a `feature
-<https://github.com/sjp38/hackermail/blob/master/USAGE.md#forwarding-sashikodev-statuscomments-to-mailing-list>`_
-for such sharing.  Please feel free to use the feature.
+sashiko.dev.  The reviews will also be sent as replies to the author of the
+patch and the mailing list.
 
-It is only an optional recommendation.  DAMON maintainer could also ask any
-question about the AI reviews, though.
+Patch authors are encouraged to check the AI reviews and share their opinions
+by replying on the mail thread.  It is only an optional recommendation.  DAMON
+maintainer could also ask any question about the AI reviews, though.
-- 
2.47.3
