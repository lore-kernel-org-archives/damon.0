Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C743E25571;
	Sat, 17 Feb 2024 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131530; cv=none; b=hLhf7+B4KmkP7XlaskecnCQ7zGbjgRHYebJRUgb2B2yFtf6NmZfxzjhfXCk8CtH2jRTisLEqCM4D7W7NfhWqzM5bzCGH+2LhnNkwxP75B86djTfK/fCkU1obBIheD/7NXc5AA3iv8kY85R09VwMfCDhslkPZ5GL1bi7qofDIrGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131530; c=relaxed/simple;
	bh=zjtUmDw2W04Oqswzi7ugwTbYsUfBySmq7qQ57D2h3/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nFNLGfHvYCPmJlOA6TKoRRPT/XFPPBXDgS30guUgX2kIKpqKmM8WHVDanE+XJ4hZQNz7qZOgVtCEk/Ii0pp57+sEK/f76jM/6Xq5QndpFtAMsKO1GApmCZrSiePBCzfNfw1FWcr1WloNjYEPw/lJ3f8u5gDOCE+zUIhJFLdBKdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4bEzdFL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4bEzdFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D15C3277B;
	Sat, 17 Feb 2024 00:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131530;
	bh=zjtUmDw2W04Oqswzi7ugwTbYsUfBySmq7qQ57D2h3/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4bEzdFLDlF6NLqwGK/mAAgfMMKWdnJ8vklpKYAdUXCed+fMo4jl0CvKX/mU2OAFn
	 arCqEtlWyJt5NSpJVt1S0W0F4hksykL5ZFvZ9d4n7IYMnUQy46xVjZ95hKG5qtazQ9
	 mqzObWI8j5FId7H/EaphvGBxODbmk1E3N9bOTqyw/OBjE81il5DUZ23VvjMN7QpFMZ
	 UETBSwIEX9MS9V6yCtXvWn6r5ldcHWnQDixxgZ5jQ05micq0XxuvRz3M937Ftlb84H
	 4vrksfLUmh2xuqU/SyQmUsE1zjA404Sathszb2uCr6DW5kSIhXCXtRyCO9viVxCqjp
	 gigOIuoHt+lPg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Docs/admin-guide/mm/damon/usage: fix wrong quotas diabling condition
Date: Fri, 16 Feb 2024 16:58:42 -0800
Message-Id: <20240217005842.87348-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240217005842.87348-1-sj@kernel.org>
References: <20240217005842.87348-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the introduction of DAMOS quotas, DAMOS quotas is not disabled if
both size and time quotas are zero but the quota goal is set.  The new
rule is also applied to DAMON sysfs interface, but the usage doc is not
updated.  Update it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index fefe62e0a466..db6620b5bc0a 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -329,7 +329,8 @@ respectively.  Then, DAMON tries to use only up to ``time quota`` milliseconds
 for applying the ``action`` to memory regions of the ``access_pattern``, and to
 apply the action to only up to ``bytes`` bytes of memory regions within the
 ``reset_interval_ms``.  Setting both ``ms`` and ``bytes`` zero disables the
-quota limits.
+quota limits unless at least one :ref:`goal <sysfs_schemes_quota_goals>` is
+set.
 
 Under ``weights`` directory, three files (``sz_permil``,
 ``nr_accesses_permil``, and ``age_permil``) exist.
-- 
2.39.2

