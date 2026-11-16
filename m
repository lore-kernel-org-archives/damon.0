Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841865;
	b=5eF4r8SfS2xXNnlIyMmsUX0m8GttCKiEDqnogIVy2KvWuId/zSlYlU4GZoCVchZdQ9jX
	 KW2FF5nZPTcq0qEm0JCNdAqn9YX+BJkesqATZZUcYmTBuOAI5yBcb2Cqz+2UEA1UebfRz
	 vPyReCIvR3Na9vpJkXiPDF22/8Btuabl8qX4IO/x22e2eue4cCqPlFa/GLLki5CiNAyTF
	 yZwvBTpcTpoIwN0QTv+R1bn0EThpELHp2Vcb6WQ8BRByKatJ1i44gZrNv4xlv5gEUQg96
	 up+ufiPHkh2NhnqOOmwKdNOHhSQIqlotOKumnXtGJQCewm83P4UsrkEs061LIcsG64Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841865;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w1WUFy00WKif50635jpAYGG0Z7r0L+cuC+V6UO7Tvv0=;
	b=SzGhq4OtjufYuiEjxsaStkftQY5zo332Lyptsa12GKQdRBdkNiGKlWf6Rp3irT8lj1Vp
	 4TIwHxkIk83ks8SbsxWivBhwRShqE/PVDrNTbfHUwBZYnOQO7/Dn5VR0RI2aL2aB5FGqm
	 CjxabX0uxHREBCjzLqkHsnrB3ZoRoCPEpiYLNcg2jGUWeb2OddPthXujfIwIhz10DTk5L
	 RxX7NLTCHZbkN+ONTnEULwjU3akUhYukUWGjgU1DmVdKr0g87uFKbooGPkZ2z0s2LPeAM
	 OH3mOBDqZ9IETtKze8devEAVJkvoAD02Gt0tfs5IL0r4DrZBqlQhDazm+UZEma1dtmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E/NTwgEo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9AA606A33D;
	Mon, 16 Nov 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/NTwgEo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5611F000CA;
	Mon, 16 Nov 2026 15:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794841865;
	bh=w1WUFy00WKif50635jpAYGG0Z7r0L+cuC+V6UO7Tvv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E/NTwgEoelaYeC6OqXmks8N/gaUD+AcdUO8xivFoV/Ry26MI65gDTP9Ku0jol9iFJ
	 tDagg5m3MgBwxozICWPiRceFqhmjtSQa0Pg0tlEsI2eSRrS5HBjEwjSOTdaOYOP4Pw
	 sLpxCJ2dNldClQYI5XqEWGpERmwgVvBvJToJhJNfBgnuwSEmVKkXD51Zqbhbb37neC
	 DXU10NdfGwhiHvc0TBe6YIterzMpGxBTLR1hmdAqxJXIzOV/nXWEugbxnEWaPrTvSY
	 T79+2yYiY1BLICqLqXRHpQW3dPcIhogVa4euAS+9JScmG0ivR2hIRIixBwSsOdgz2B
	 LelZrxTgyAOJg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Enze Li <lienze@kylinos.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] Docs/mm/damon/design: replace "same to" with "same as"
Date: Mon, 16 Nov 2026 07:10:52 -0800
Message-ID: <20261116151057.81692-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116151057.81692-1-sj@kernel.org>
References: <20261116151057.81692-1-sj@kernel.org>
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

From: Enze Li <lienze@kylinos.cn>

"same to" is not idiomatic; it should be "the same as" or "same as".
This doc has six such usages.  Fix all of them at once for consistency.

Signed-off-by: Enze Li <lienze@kylinos.cn>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20261114055436.5546-1-lienze@kylinos.cn
- Collect A-b: from Randy and R-b: from SJ.
- Rebase to the latest mm-new.

 Documentation/mm/damon/design.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index b676be6971589..6284b90054430 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -292,17 +292,17 @@ DAMON :ref:`context <damon_design_execution_model_and_data_structures>`.  The
 registration is made by specifying a probe per attribute.  Each of the probes
 specifies a rule to determine if a given memory region has the related
 attribute.  The rule is constructed with multiple filters.  The filters work
-same to :ref:`DAMOS filters <damon_design_damos_filters>` except the supported
-filter types.  Currently below filter types are supported.
+the same as :ref:`DAMOS filters <damon_design_damos_filters>` except the
+supported filter types.  Currently below filter types are supported.
 
-- ``anon``: Same to that for DAMOS filters.
-- ``memcg``: Same to that for DAMOS filters.
+- ``anon``: Same as that for DAMOS filters.
+- ``memcg``: Same as that for DAMOS filters.
 - ``pgidle_unset``: Matches if the page for the memory is marked as not
   access-idle.
 - ``pgidle_set``: Matches if the page for the memory is marked as access-idle.
 - ``hugepage_size``: Matches if the page for the memory is a part of a hugepage
   of a given size range.
-- ``active``: Same to that for DAMOS filters.
+- ``active``: Same as that for DAMOS filters.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
@@ -706,7 +706,7 @@ There are two such tuning algorithms that users can select as they need.
 The goal can be specified with six parameters, namely ``target_metric``,
 ``complement``, ``target_value``, ``current_value``, ``nid`` and ``path``.  The
 auto-tuning mechanism tries to make ``current_value`` of ``complement``-ed
-``target_metric`` be same to ``target_value``.
+``target_metric`` be the same as ``target_value``.
 
 - ``user_input``: User-provided value.  Users could use any metric that they
   have interest in for the value.  User space main workload's latency or
@@ -736,7 +736,7 @@ auto-tuning mechanism tries to make ``current_value`` of ``complement``-ed
 
 ``complement`` is a boolean parameter that determines whether to use
 complemented value of the target metric.  For example, if ``complement`` is set
-and target metric is ``active_mem_bp``, it is effectively same to
+and target metric is ``active_mem_bp``, it is effectively the same as
 ``inactive_mem_bp``.  ``complement`` is no-op when the target metric type is
 ``user_input``.  For the metric type, the user should be able to emit
 complemented metric values on their own.
-- 
2.47.3
