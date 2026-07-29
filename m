Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930AA3921EC;
	Wed, 29 Jul 2026 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296286; cv=none; b=SfuldgjDtMYowkLoBMMF1W50DEO63aGhWQDkHyFwzJzwJv2tCSYTq8UhOzL2zSbHCnP9p5z5KuYU7n2a/Q6Yf5HrQfMjgh3JvfNrSPAALhSs5YF9ud2tq6JxKusBUyPg1nKLY154mve+ms3h6wzeH+BfClc2cDq6WGHJS+oUr1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296286; c=relaxed/simple;
	bh=94L9Y6jblqW5ICiSyH0suMgSyVNNc6/w7ucmr3p0soQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYQwmBpG4KX58lS0zZgn4Arxthw2EjLBj8X9LK7kYW3lJugwuHEKovA8VtuqgHgNHicZHcyeyU4HcPioAKTw6lYoQwM3memhn2hbfKseT4KbHkc18fH4nX62jsOmKjpdGm9xZL9Te7xpClaUbFRBG1zMUPgDdTuhRswCCARL0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXKQ8/gd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXKQ8/gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CBB1F000E9;
	Wed, 29 Jul 2026 03:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785296284;
	bh=+7L5cUB5gmn/G0XCH5EnzRVEYnRmQ6289QitHVcV3Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eXKQ8/gdJ5jeWOSOGK/oDNdW3r/sNFDPgeZNAx+2MAASe3LcWCL45R+98Fvn0WEwV
	 xIR5zTwa5P2zP/aKtVCZ2DpPOyZvGkU+UKISFamU+c0W2TsZrxDLwMkyImPKiLEtNT
	 h+VeOpIHHe3wGkuf02Dr5RRXZC3OMgrWAbWkwv9IqwS0sd6GgTAK030cWZccugHL7/
	 1VwRz4mKVpI2yuIqZkTgEU/ULXggXGgqLGOyLfX617BXEGISATiEPmMOd6/O2WH63b
	 i5a3QyUnG+MWI9SAvnF3fonkf/44L2o6Qanfq7vR8biK0gy5IvI2hG7RaKggSZ3V4L
	 8sFQyHHgsfI0g==
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
Subject: [RFC PATCH v1.1 09/10] Docs/mm/damon/maintainer-profile: update AI review for Sashiko replies
Date: Tue, 28 Jul 2026 20:37:49 -0700
Message-ID: <20260729033751.131213-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729033751.131213-1-sj@kernel.org>
References: <20260729033751.131213-1-sj@kernel.org>
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
