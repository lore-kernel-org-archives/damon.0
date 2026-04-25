Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1A311973;
	Sat, 25 Apr 2026 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777149199; cv=none; b=LmlIVN4yyyJzPJiYoGLJPjPsWKYN1bbpwTQsyzB3gk98jbf+N/WUSAG3dcB6HFtedtTNPuOfVwt4yNJ3n2z37dy1TO66yYPIsaJp1wmzhL7MSakPzk8lFeImkhuMFQeaz9TS/kK1TGLL9coLZTHoI0aOa92MZAVg1MF0t2pf9mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777149199; c=relaxed/simple;
	bh=Te4GL7YI2bga7ObPIqHKNdIOFUrcsNxgo3oTxgGUtEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKASRFrTCOvryyb8RowVgFMJyAJf36Yzpd08XJ56ZvsNjmkY28xBLN1KnZBuNwtdy0Os6+Hytafcg4xgDy+Lm6zzJTEuzeaBMSPZdfI8Qs8klWeWPyjm3evgTpch5LZgh5EW7CSrn53uw7/BkMx1KAMw145AM7U7jdhcaSDBU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHKr7mAR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHKr7mAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E747EC2BCB3;
	Sat, 25 Apr 2026 20:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777149199;
	bh=Te4GL7YI2bga7ObPIqHKNdIOFUrcsNxgo3oTxgGUtEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHKr7mARiuCYpZMXucBM5HNsb0AisKL+SVs6qyMvTi07bf/1Ls7AO+MSs2jwnVry8
	 PxvVkBnwGZzLB3BufsHaU12SiWfMZF3UurrTQ70NvpfsaE0K871I9ic8sQTgJAPlSA
	 gdtnR8N2RBk/5N4Sv6kHerDJ5S0/otzhXyXEd8Ie/p2mzOiccsKp+JONLRlKEa3O3S
	 cdhVSIW+ai0g+R5kbiD4FHs4MJDoH69DeRLgL6wlVz+YBuMQeM97EcrALzkZM2Pmok
	 mStAcqhr5Q5n8hoK2lCMrgWxSypH7m+shHwp5MY5wtzRN5nwzUs1R7a/N1IqEe6SJB
	 0Wbuga3b/TQ2w==
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
Subject: [RFC PATCH v2 2/2] Docs/admin-guide/mm/damon/stat: document kdamond_pid parameter
Date: Sat, 25 Apr 2026 13:33:07 -0700
Message-ID: <20260425203309.108879-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260425203309.108879-1-sj@kernel.org>
References: <20260425203309.108879-1-sj@kernel.org>
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
