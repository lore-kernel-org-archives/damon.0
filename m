Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546C537F8C4;
	Wed,  4 Mar 2026 04:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772599289; cv=none; b=Wr2xMkxvBSO9lFVj4OVukX46UBbvqQW33JS+nX2YJ16Nqn9bs7JVMZJXScRRNUuQTVF3/xct21RQMdfHnhhe4RSP7i2niubg6OyVJZT5Ug22/209SqsYXfsFm7hCpMbxuF9U4CJtcZ+/IKpm2N90wHHAcll+OzmGWMmk/0xl1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772599289; c=relaxed/simple;
	bh=BRPVQ//gFwEK7BX6XnTBEauvn4um7HRHs55ygHmJ5MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VV7C18uF21JCnqVJhdG7puu2wD3WO+cZYdOQ/00V2gum2qzvSYYAvYThCwQRLASyx/5tLaB9XS5gedJGuvPkEqhjK3K7i7wBly0m9OONUjCO8vgYGOAL9jWq0MVde0v8gyTRSVppsI9EB331M9WnS/KtjCTTfP83QKERFqlY5x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drGqn8oa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drGqn8oa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5912C2BCAF;
	Wed,  4 Mar 2026 04:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772599289;
	bh=BRPVQ//gFwEK7BX6XnTBEauvn4um7HRHs55ygHmJ5MY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=drGqn8oasNMPpRGlhAVrnnqVCuASZrV5LJe28KZ7+yMqDFjIfwo3qSejyNL+lvPck
	 8nuOYiRbROexyxJYKh4PbkVpIpcPyPwuoYLupU9EhZ7uqocsHsmMEhWn6VfWaGQwOT
	 pBgRSbF2r1ZonJCXHSJn0bMHnOPSGtJDzlgA3iLhyfxFb/8sTrBaByila6IXVC4QzE
	 Tcvm9sRda6B2KP0ywrJh7QdzdVvE3tP7ai4oSIStmu2d4geB22MXDbcw78VC1Uow2/
	 NHUeVU68Qk8AsGzbkszZfUbqTqkf7ZQU/pTP9mIewE092cN7/fg1d/KGitPokgStKx
	 66e6IhuPilUdw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [RFC PATCH v2 05/10] Docs/mm/damon/design: document the goal-based quota tuner selections
Date: Tue,  3 Mar 2026 20:41:14 -0800
Message-ID: <20260304044122.79394-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304044122.79394-1-sj@kernel.org>
References: <20260304044122.79394-1-sj@kernel.org>
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
index dd64f5d7f3193..28d932ceaf7ed 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -564,6 +564,18 @@ aggressiveness (the quota) of the corresponding scheme.  For example, if DAMOS
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
