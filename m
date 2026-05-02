Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510962C11E6;
	Sat,  2 May 2026 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777687516; cv=none; b=UFt3ana0XTiPKUDXgNF8ASO2tL5NNtGykcAzE71qF0cDPb5bVeip4fLxHpolRf8dH1FBXNzLkWu2j7RqarlMSXuXOXz2d/MQBikp5xWoIuOS59T25AcZV8EgBliOhsQhcYgLcITnf+EbPnHsZArwqTtZgn/v4Z7PtehQsQ14qA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777687516; c=relaxed/simple;
	bh=Te4GL7YI2bga7ObPIqHKNdIOFUrcsNxgo3oTxgGUtEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEWD4kwAdOmjcSvnaASmzCbzLIYQcp7ZhAM55Q3EwcmuzsEvITGslJ2D4Ht+V2+4prn5Pux6WC+7txTFpgrHMl1LScop+blfBEPy/0wJoxNdZoyPXc9u3dv3BMgdXXmQL2Afjq6HKC6d1ijMV6ZVU4EKfIrfKg8foN1g5bAzjnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocaS+sPG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocaS+sPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F73C2BCB7;
	Sat,  2 May 2026 02:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777687516;
	bh=Te4GL7YI2bga7ObPIqHKNdIOFUrcsNxgo3oTxgGUtEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocaS+sPGGQEFhUdiF2OuL4XrIeWnt97nZiMKzfHGwlTfxdNHUUxgxSQVBvdydiZSF
	 vzEG9n1tPpOmN6kN2IRSXVqI4plFdE2BTZlMqM6jLkC5KAP2DFKBrqVljwHNo3FPfc
	 JMzbzJDGmAlaCa7n5rRBMQhCVGLcawy3UhdROKE7Lzyn70w3ICvJ/1DkU6WbL13cRR
	 x2GtazVbIiylT2gCtADUatDX+PPYA3hGBiamu43inIoAx2vPCRsNE+pChBV5JyGu/+
	 ML/M7iedM3lm9lXUJ7Alj357K2P0+nmURUN/8d4DVeL3ipckp9zxWFpD7DjujuK6go
	 YcWCo1DZ3xe0Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [PATCH 2/2] Docs/admin-guide/mm/damon/stat: document kdamond_pid parameter
Date: Fri,  1 May 2026 19:05:04 -0700
Message-ID: <20260502020505.80822-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260502020505.80822-1-sj@kernel.org>
References: <20260502020505.80822-1-sj@kernel.org>
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
