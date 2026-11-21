Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294830;
	b=m33uEuMWmzOzRJ9xt8eh3OgDFJpUWM+G/A3YO4cx8Ns0z88SlQN2FDwg9Rk0/NvNGIuD
	 98Kc5nSm55IG/KPCDiYiOmF83LP8Z1dsYEyDEfq76mtXqQb0IidkQLk+sWh+jYH5h4r8k
	 WXM9+fIT2X1MyP2OGZO6gvXjGW28Pg29nhRJtitQoVTgo/YHxBe9WsSS47YkTb/CjO5yB
	 vL95W9prNKKGM+qpYxX4dgweW/9FaPrCb7dfFyJjlUYANNb156VEdT/Wjg8RH0ZBDMGP4
	 aPmXBRUshO2XawoD49oF3c5WmetOPGZoU2kkMQqqygb4mBNX6wCKJ00lZIMftImFejQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NvjOO/+bldLi0/nuMY9P6FGGyFYE4cHne1cw3VHENC8=;
	b=hVscel4dMh74aNw/Thb7HpxSPDj0tm06eY+Xknd8GjZZEIyAQIHEdZcIhrlmYJQpaAR+
	 lP3Y9D9OnCMNy/iV6NYCYzCKzrfCs/OWMVXafJXaLrFsZYZUEesxGOG7o1LZCpbGDNeks
	 M9mFIdr3ir8JVLCzVYiTAGn8lN966NharAsQBYaKjbsVXaoQBCWecAvjpdDsl6ICkTIFc
	 xYvWXQevSnUpuxuG/SEtuWVD8lZwpO3xXIESagV32Cf9rCYmQmhRs9wsxQxEYU5hNkYjP
	 XT8gJH3x5FhhUCJjjxSAJjCamifqWhgRBXuHW/hUWKb98is38nOlLSKBR/oSHXO/spQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mPx9/RWm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549DB606A32C;
	Sat, 21 Nov 2026 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPx9/RWm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AA21F000C0;
	Sat, 21 Nov 2026 21:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294829;
	bh=NvjOO/+bldLi0/nuMY9P6FGGyFYE4cHne1cw3VHENC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mPx9/RWm3lssxvLRnk3HnUv0IEIAeVv0nkVtBDbktL2sHmJ3dRpkkpqPzo5u/6+x9
	 fK5aKX4qejxiql9Vrz764KW5Kp51YUJeQwRd/iwM5HyZeAIulJ+XhqZnVidk4OuWQU
	 hQAp8lBrKQcsWf3KpwXZyZgCjGInYKG1J0mPTjkpZFzmiJoi5cyV2DoyVVeZjNxG0S
	 oDYmPhP1sFDR/zOiQIl/mF4+tT20T0HYEP+5IbYwmG4QGxTI42S+SxC7C0Q3Ria6W+
	 S0+NWmhQRy2Fz9UMh/QnZj0UV4HkAWPO5mELvzRdDZFHvRr1nTm0HDvF7xNebyw75W
	 Rs9mJV1wFf4Ig==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 25/27] Docs/mm/damon/design: update for user report support
Date: Sat, 21 Nov 2026 13:00:09 -0800
Message-ID: <20261121210013.130397-26-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly aded user_report type data
attribute reports.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 31ca623385718..39b508bc572c3 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -382,12 +382,25 @@ can generate and submit reports of the given type.  The generations and
 submissions could be done automatically by the kernel or manually by the user,
 depending on the type of the report.
 
-For now, no report type is supported.
+Below report types are supported.
+
+- ``user_report``: User-provided report.  To use this, the user should set the
+  address range of the memory to report for.  This type of report is not
+  automatically generated and submitted to DAMON.  The user should manually
+  generate and submit each report using the interface.
 
 The data attribute probe supports the reports.  The probes can be configured to
 hit for a given memory region if a specific type of valid reports that are
 associated with the probing memory exist in the reports queue.
 
+For example, users can run DAMON in the classical page table accessed bits
+based access monitoring.  In addition to that, users could find hot data that
+might not be able to found by DAMON.  DAMON might not able to find that due to
+limitations in page table accessed bits or its overhead control mechanism.
+Users may be able to find that using their access to workload source code,
+experiment results or other tools.  Users can complement monitoring results by
+feeding the information as user reports.
+
 Dynamic Target Space Updates Handling
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3
