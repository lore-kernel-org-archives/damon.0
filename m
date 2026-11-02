Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633340;
	b=enGFzrfKydAPXl4pFcYx2aYMGcXF0u0XWi+9fdmhJb/dCMM0/yF/+VM5UfVCZUdzfygL
	 Gir6VO6RQ3Ny207k+1pY4W8xNigXcYCAgZKRTd4NWaqTrjaoAlIqt0SnZXv70pBxQufre
	 nlLEymxdKcFNm3h1iyJP2iwvqYwkc+Ufa42wBfyT4eO2mQ1ECQvxunJTaJnCTNbKjfCHO
	 SBrRBJ5NYR+e7u9orAQXbV8ihqtyAFnhxYlGfLD1Hwai3RXExruxrM68zkN/sorM4lrVo
	 ja2RZUYxD/TQbc2e4rH84E/K0zDxAeMw1/M7bL9ruZUHzg7yAxEzWt4x1aN2KQ31OfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633340;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LlMzZy2++vEEV80Q06m4mj9WBM9QJsJxRJcm7Er2ORo=;
	b=WorvXV/clCQMgJR77zcaF7k29W7Vqf4Nru+cXXOmIUWsk7jyc7BqcY9b2mHWhdy4L1Em
	 npxw6x3/ZzlovFWbDZt5MJqYKYilg5OyXZEKC/jxXfQiLAPSGsTFNnDSDIlTjkqJTkgyj
	 RL3LQaWyicRWQ8qg7q56tzbR71hDrugcQ5HBUzA0m0Uyc9ZL/40/K7I84PHMM+Ay6a578
	 w7wjJSpmFs+2b/5U+ny7d3PxOEKEpCf5qGZuDeLF5YJNCyXNnZCneQIoZTBApS6Mo+jCM
	 lufaifRETpFmPsdnkFhof3IWy/CFh4umGkmLahXz4zzUGZT/3Nq7uuYBRpg6of0gGqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=COsIYpm0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F5609D12B;
	Mon,  2 Nov 2026 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=COsIYpm0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684F51F00A17;
	Mon,  2 Nov 2026 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633339;
	bh=LlMzZy2++vEEV80Q06m4mj9WBM9QJsJxRJcm7Er2ORo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=COsIYpm08ZRi75aGJuQG+bMkt7CvV5oiS5/4li7guJF2PuUIbGAP8AQ+Y0l/onn5W
	 PAxYTF6weuSJ36KW9l+1T5vec5TURMd9NL7HyafPCPnWQSPNPLutBz6AWnQqny7FrA
	 9l4cY5bHJGcj2qAOGP2CjYjlbeBIZ55a5Y2QmBCMWS2swkNqHYmxxI70/3ZjO5ecqp
	 9GSEAjL3QAb52D56c8II8fTHvDga8icXAf30FHfSUgu+uj+XmDeSdr43SWTscPFq8n
	 34SV4xiilngQmmtGi9mvgtBl2jYibmTRCgiTxtZxCEA/IDS3KioSgCgWCPa8l0LnS4
	 E9ek02KyzdzQw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 3/3] Docs/admin-guide/mm/damon/usage: fix incorrect option syntax in perf example
Date: Mon,  2 Nov 2026 07:28:47 -0800
Message-ID: <20261102152849.96057-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102152849.96057-1-sj@kernel.org>
References: <20261102152849.96057-1-sj@kernel.org>
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

From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>

The kill command in the DAMON documentation uses an incorrect
option syntax in the perf example.

Use kill -9 instead of kill 9 to correctly send SIGKILL to
the perf process.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 3d43954c7046c..bd687d89ea4c0 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -749,7 +749,7 @@ show results using tracepoint supporting tools like ``perf``.  For example::
     # echo on > kdamonds/0/state
     # perf record -e damon:damon_aggregated &
     # sleep 5
-    # kill 9 $(pidof perf)
+    # kill -9 $(pidof perf)
     # echo off > kdamonds/0/state
     # perf script
     kdamond.0 46568 [027] 79357.842179: damon:damon_aggregated: target_id=0 nr_regions=11 122509119488-135708762112: 0 864
-- 
2.47.3
