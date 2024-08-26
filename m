Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EBD168C4;
	Mon, 26 Aug 2024 01:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724637468; cv=none; b=F3n65Zz5+FaGsCmII7OM+17TrrZmV0tToAN49eqXJl18zCJyANJ/me9NCjk7Nh47AHyuZQdec2DewWAUCsNGFuJDZ4X9+/7C1t2UvHz4A+uSyP8Bbruq1Afb2apWoXl46ycPEcqivOrHnxTBr5ClgWmApcOBElnQ+TFWLz2Yn3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724637468; c=relaxed/simple;
	bh=gea9mUAXiEJkvTAvBc5bm1Bd90hC20jz8ChzK7BjWCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iFlOqz9NWfdK8lBwDbMu2LsjvcyLsm9OWn6EWy7xfCds8j35BceMTy6HzY0vzqRANNpsIu5CbXHRr8rsx5hVFJKnWif4f555OvXFDCxa6xHB8JX7/LdNPGLHNQ51Fcvstxq07Rc5Sa7ub2zknWuhtu/TU6fiyqTxR84dTu8pRwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOeVL12L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOeVL12L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB52C4DDEF;
	Mon, 26 Aug 2024 01:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724637467;
	bh=gea9mUAXiEJkvTAvBc5bm1Bd90hC20jz8ChzK7BjWCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iOeVL12LSOwQyKI5vW9FASmShYc2pnkTCsfW/YGxAVkAI7Q1Hs8vEzztLaI4Yo/x0
	 VT4HjMMKdJKxs9xwCsmjCSHaQCf0gm+xpyibQd1NE1Xfem+7GHdkOQXCtJTKBKgvhR
	 NyTeX0Sx6v4bBmdXpJBGXzicTwwjA+np+dJp8pGp5WDRQLTEMmUvdQOQiMG0VNxIfj
	 qVEN4uvuvUVoReoxMPTxwfVTeKpumhIraPQE+sv7cXLfaiUFeZy/ygRQRiARJ3mdYU
	 1TcB+D/xP+78+cjI9hcghS6FvhdQN0+OJ3XeDltb/Fs5sKI6wHLgM5M5XZuzyASVWD
	 mbWMYZvOGh8/w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Docs/damon/maintainer-profile: document Google calendar for bi-weekly meetups
Date: Sun, 25 Aug 2024 18:57:41 -0700
Message-Id: <20240826015741.80707-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826015741.80707-1-sj@kernel.org>
References: <20240826015741.80707-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We added a public Google calendar for easy sharing of DAMON bi-weekly
meetups[1].  Add it to the official document for a better visibility.

[1] https://lore.kernel.org/all/20240717235812.53087-1-sj@kernel.org/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index 3c1b42b062ea..2365c9a3c1f0 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -99,5 +99,7 @@ time slot, by reaching out to the maintainer.
 
 Schedules and available reservation time slots are available at the Google `doc
 <https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing>`.
-DAMON maintainer will also provide periodic reminder to the mailing list
-(damon@lists.linux.dev).
+There is also a public Google `calendar
+<https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t>`
+that has the events.  Anyone can subscribe it.  DAMON maintainer will also
+provide periodic reminder to the mailing list (damon@lists.linux.dev).
-- 
2.39.2

