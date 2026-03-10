Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC7630BB9D;
	Tue, 10 Mar 2026 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104740; cv=none; b=jxtM2xTXqFqpaOVjmsWdTWQ0NZkoqxVOMiQ8yB2mnoygwILngQMv0/j80RW/uSeeJXGNRq16fxhKcnNb55SB2mYz51bFQNysZ6MXFCDXW5jf9iiAti0F5vLrTXQz9fFJ1EyrDHR2b6/ILXpXK9PGfAqZ9+Uu/gyYt4Py2KgvBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104740; c=relaxed/simple;
	bh=yTvCo+JXdygWDppuMY59cBuy+ffz+XijY5gZYAbrrfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaTfY7jy5pe9yW5KvypM65mYymvbf9hJJVe5vIeBLYWZmC0hc1VOfovlc3iqVvzMT8e/IgMhLZUVF1Up2L+W4B8SO9jmWbKff/1gDAIRaF/MlPykGviT3nPf5VlXT++rYpOpkxaWk5lVnU40sDiEq8wQ9U/csrdG13eiKGwwbxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfiM1MsN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfiM1MsN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00F9C2BCAF;
	Tue, 10 Mar 2026 01:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773104740;
	bh=yTvCo+JXdygWDppuMY59cBuy+ffz+XijY5gZYAbrrfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfiM1MsNSmm3WEADxWNf29ZgMu+jsFkfxsa2a2ZOxtfqhMDKNeD4ymTphfOlK8ULi
	 Gpmws3E34ovE+lMw5Jgqouj5gpLzn6WB3zijl+7gt0TWPOFXyY67xN0S07TzsULSrU
	 cPb1hp7ctCr8nL5HcRsvnTojy3TyNihgWh/Lqvod+yWvM/9Z2XwkqBcPHoOG9Vqm5d
	 dIdKAu5t9IBBqdnBVxMlE6Y4DQ/kVWYimUhqdXZT47ksdqKjTTp3FtttOtWBA7ds2j
	 4ycyG6DGB76YlDz+ureGMT/9Yfd71uJ40L3SmuZRl8JP48I3UjH0GIOeGotkXbA5Ce
	 YZ508Oi6fPOTA==
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
Subject: [PATCH 05/11] Docs/mm/damon/design: document the goal-based quota tuner selections
Date: Mon,  9 Mar 2026 18:05:21 -0700
Message-ID: <20260310010529.91162-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310010529.91162-1-sj@kernel.org>
References: <20260310010529.91162-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the design document for the newly added goal-based quota tuner
selection feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index ac795f30519c5..29fff20b3c2a9 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -566,6 +566,18 @@ aggressiveness (the quota) of the corresponding scheme.  For example, if DAMOS
 is under achieving the goal, DAMOS automatically increases the quota.  If DAMOS
 is over achieving the goal, it decreases the quota.
 
+There are two such tuning algorithms that users can select as they need.
+
+- ``consist``: A proportional feedback loop based algorithm.  Tries to find an
+  optimum quota that should be consistently kept, to keep achieving the goal.
+  Useful for kernel-only operation on dynamic and long-running environments.
+  This is the default selection.  If unsure, use this.
+- ``temporal``: More straightforward algorithm.  Tries to achieve the goal as
+  fast as possible, using maximum allowed quota, but only for a temporal short
+  time.  When the quota is under-achieved, this algorithm keeps tuning quota to
+  a maximum allowed one.  Once the quota is [over]-achieved, this sets the
+  quota zero.  Useful for deterministic control required environments.
+
 The goal can be specified with five parameters, namely ``target_metric``,
 ``target_value``, ``current_value``, ``nid`` and ``path``.  The auto-tuning
 mechanism tries to make ``current_value`` of ``target_metric`` be same to
-- 
2.47.3
