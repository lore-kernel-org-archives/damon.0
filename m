Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410253EC2F6;
	Tue, 14 Apr 2026 23:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776211164; cv=none; b=UmVranEU4a1O+FZXuR+My2mppclmYKKDZlXEQr+t0QcCpujRuakJLG7ryi/DrnGD7mDbVPNTwE0uj3NwKZmKaJwprHGv75j8/X4sAvOx50s7PzIb2xhLhY3dgp98fFsYo5ObVnzu2yrhB+3qCZI5GCRmQAGqLp2gSxsj/jmEN90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776211164; c=relaxed/simple;
	bh=Te4GL7YI2bga7ObPIqHKNdIOFUrcsNxgo3oTxgGUtEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrySGSmFKnkbFaorHmYgtR1gHEap56wMnI0HTdv9jwc4IIcHjKcs8Z/U/c+jZsOYH4u/QENVD95R4/pziXEiFIWiJPLgTBeeNLAbfw8Wo6538E5c+M8kuzPvMi4+7knLzdXRgNPXnBsBlOWn739j7vnzLpy0HqvoNYj4yHroQ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3R5nb/L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3R5nb/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EFAC2BCB5;
	Tue, 14 Apr 2026 23:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776211164;
	bh=Te4GL7YI2bga7ObPIqHKNdIOFUrcsNxgo3oTxgGUtEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H3R5nb/LjForXo1hg9/adfUnX1uTLjvOLP3aU91OCaP/Ui0zSo99XMAuRsQVQRQoR
	 W/TuwCOM27bvC3Q1PuQ7GFX1WOA7cJBn+1IsS7tSdyvIrQhxThdiZN1nQFdH97ooRZ
	 4EEC+sQOfAGCF+c29eYHfuf1zSwU8l2dAXxQa3tV+FPHjAa+7aMhcb/MGU2ZaFQV/K
	 5+aJ68VP8Mb2H1Fsu9WVbNwbiF4HTrCNNFhG7bQtAH4JpekEMVxCWDfOJPRQOjt7mP
	 3KWGZOIR2DFEOtuiAR1/7N9zHHkHSHdGPmV67kRFWM/wnLVVBotKY6HArgFfw/u5aT
	 4Zi1XGmk8ZnlQ==
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
Subject: [RFC PATCH v1.1 2/2] Docs/admin-guide/mm/damon/stat: document kdamond_pid parameter
Date: Tue, 14 Apr 2026 16:59:11 -0700
Message-ID: <20260414235912.98174-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414235912.98174-1-sj@kernel.org>
References: <20260414235912.98174-1-sj@kernel.org>
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
