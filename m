Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9332FD69A;
	Tue, 14 Apr 2026 04:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142214; cv=none; b=tcokSDjoeGnfzDIOluyQ+zjNKLHgLRahqWSsYcWo1y0bZ/0I3vIlkayhk7xwBvs3An7AZr/ZsIqm9fmQzVbILqyyHsRjl69UJz6YMJWQ+TrmS4RWAAn0PnbDHBpRjsB55ZbGYOSw1+4vHJNU0k0+A44WVRnFNZ64zPFfG4SQZn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142214; c=relaxed/simple;
	bh=Te4GL7YI2bga7ObPIqHKNdIOFUrcsNxgo3oTxgGUtEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Og/DnKs2KLJ8+sbQEb4xNpK5fRvWOL2/LhO+Kzj8hR2gJZ39HGKMFvQtj+Kj12WP06MdbLdxpe/C5gI3dCZl53Loi8opR+pTsFIBw5qneyR8B1QOwFod3p9vXzLykX1KN5y98c7yc3QfSKP1xeLd7UR4vCOfhN1VfpRqHwNFSYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O41lfk3t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O41lfk3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B871C2BCB7;
	Tue, 14 Apr 2026 04:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776142214;
	bh=Te4GL7YI2bga7ObPIqHKNdIOFUrcsNxgo3oTxgGUtEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O41lfk3tx4LDd6ZI5YugjYAHTmDpBB3Z9WOtx/8ul230mVvea+IRclgfX9xOKMnuu
	 yDmf15V5BDiXD1R+bZ77R7ARhB7U/vBqwGepCPGmxtqXpzWEjITNyg7ictoS3NQZdl
	 MPISL4UKh2jZjC1YNFfj4btg1h7l3TTlTzyJOf3WowY8CxJLaEQe4ZCmWs/VymHLmz
	 4cc0A2K/rllsNntuRK333jXn0m774Txn6ntISewsHSPnX+rcUTaVdTH1PQswb8OOX5
	 2+Q9fb6uN1AMZ1PHvGJJXezj4OjYRrroNrfn58YXOmuOVv7a7is2F8eUQvzBUB4Q+p
	 VeVw8Lc9xjSDw==
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
Subject: [RFC PATCH 2/2] Docs/admin-guide/mm/damon/stat: document kdamond_pid parameter
Date: Mon, 13 Apr 2026 21:50:00 -0700
Message-ID: <20260414045002.88110-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414045002.88110-1-sj@kernel.org>
References: <20260414045002.88110-1-sj@kernel.org>
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
