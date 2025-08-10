Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDDC1E5B73
	for <damon@lists.linux.dev>; Sun, 10 Aug 2025 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754829735; cv=none; b=VXJ6ZvqoQPotMdjTM7zfnrDBaz73yuHk5B9aKeX3dhGR4Mp4oPIT7I/1YxAjr4GCE7V0wM29uhlpM5Yt2rKJd9O2b2zTa77Ao3he8nAte33RZNqtZCg9e2bNdU61HzMtwvnT+dK/CgIZ2bX7Jdn6V53h4UzOBUVX9Wm6Jj+pF3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754829735; c=relaxed/simple;
	bh=gE96lVOtXgq/ZhlPKHnIRtmTKHb5Ug1DoPpSL4rKlHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qd2Ug7YnmzYUMw4bCUMqEKzJMnZb7Fs585V72DT19hSLYRhXaSDWkSY9yltjn8LdM3phStdOday7dSm7Aa/HTnQSrfy8asvqqso4RwHyjus+Mys9JaXSFO+wumHqHktCvERRJqir+CmqAOLzbxj3b5wtkrxS/7Xh8sdl8VzSx4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4+Z3JSK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4+Z3JSK"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2405c0c431cso33251985ad.1
        for <damon@lists.linux.dev>; Sun, 10 Aug 2025 05:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754829734; x=1755434534; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcQGvKOIDHORnKmX24vXxaChAnLPw5HFeXu1GYRj8bk=;
        b=K4+Z3JSKDO21iMUQYXTZP32G7BCGVXomDRAX3LwFYohfyNWF3dHyJ3GRpJkya78LLi
         Vb7mJiV4OBPKL8yvOwIsoc3I0zhpYmumVUs+IH/v0n8BrDJ71R32RLES0Nir0+wNNZZY
         u3+EDSMpAQAW02x+xArbzpxiEJnSIIwWiuWuLT3Umxe3nW3WYxCcN5rUxIl/J+lIQRBY
         eFmaWjpadVw3o00sWrf9pFqJyzdCo66vJB+20u08pIUV0T3tH5C5QoOLCgQK7hAtvBNu
         Z6x4UGWqhXQeI+6wrbE4N2FE0Z0ndOOgVlD6bpQOa7hKJXc6atbjWX92GeTmQCZyeDid
         MAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754829734; x=1755434534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcQGvKOIDHORnKmX24vXxaChAnLPw5HFeXu1GYRj8bk=;
        b=aY3BwPuT+QgoDgGgAZ1DyO6ztR0wfpoKQsyD9V1gCKnxB4HeDwtnk/HwVoCOZP3je5
         VZjThT1YvIi0JtTPMGTQCkO4ZhGsXQxHVkZ4gqFs+NT4DJ0HRpH//dXJUuGs4FQuXd/2
         5T7Un+2n3lkg04Nm1Udt0COQmAUEeaMlg5t8FeZd0EInM2sUow4yVuRgbAsUnEqeNm1P
         azAuUgXF7fB9hC2Q1t40SrImaxyoZzmPQFEB0RMU3UlQN3NrN9DZoxgat9oJFTTPdW0j
         pDxu1r/ahxIx4UIByXBPrqI/J3N+r11/aVf+RHVJ2dAPTVYWOPPLZ6nmjucMoUet3UGg
         dv0Q==
X-Gm-Message-State: AOJu0YwIboRax3J9TCHEImjRlNDTngFl6SaVPPUXUTOuteIhqsGKBid2
	mNz62X6lvea+PuRdgyJvkdrHSGDUJKj/fFzs40RJqs/2CqTuLRwhp/zu
X-Gm-Gg: ASbGncuPSBaNtKBC4974nSpRIv2ftDxSeO222XPbxX+C2vjNhKFKD1kYv5xff2hmBBa
	zs7e6sLsEVv/d4SVoS7gKDv2qINhgWI3ReKzKPKTf4P80GMKePNOpHunEyDgxCb3tyYD4kQWc1m
	3mB0iEfTBY4BsJuZRWmAIuR+/0ypSUkTDIKFuNyMn1KGxwlxnBH7qTeRXluOSH94NVASrKBSwdU
	9zXplrgLIh8WvhJowGHLH+wBDcklyTGCJqmYY1dpVfTYDlEtWpKTQ2lqw+XMoyyOHPWMKiZ0EHM
	eb7WgclrRtHg0R8rgs7ogZBMCDkpcGLqFdWl8vupd/JKTMMAeLE60kOwguAFf0VkKd9WyRzjnkR
	JXxW+HDF0hdGLI4KEiZr+nnLw7xQ=
X-Google-Smtp-Source: AGHT+IHyMhJfJJH1ELv2+P9EgJdV62MYhw2oG6J17PQqZcdm5A9jDNNNKFQVpJpCFbBu8/2aysNFkg==
X-Received: by 2002:a17:903:3b8c:b0:234:986c:66bf with SMTP id d9443c01a7336-242c20037f0mr118041635ad.11.1754829733612;
        Sun, 10 Aug 2025 05:42:13 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e897690csm250583105ad.99.2025.08.10.05.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:42:13 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/damon/core: fix commit_ops_filters by using correct nth function
Date: Sun, 10 Aug 2025 21:42:01 +0900
Message-ID: <20250810124201.15743-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_commit_ops_filters() incorrectly uses damos_nth_filter() which
iterates core_filters. As a result, performing a commit unintentionally
corrupts ops_filters.

Add damos_nth_ops_filter() which iterates ops_filters. Use this function
to fix issues caused by wrong iteration.

Fixes: 3607cc590f18 ("mm/damon/core: support committing ops_filters") # 6.15.x
Cc: stable@vger.kernel.org
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 mm/damon/core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 883d791a10e5..19c8f01fc81a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -862,6 +862,18 @@ static struct damos_filter *damos_nth_filter(int n, struct damos *s)
 	return NULL;
 }
 
+static struct damos_filter *damos_nth_ops_filter(int n, struct damos *s)
+{
+	struct damos_filter *filter;
+	int i = 0;
+
+	damos_for_each_ops_filter(filter, s) {
+		if (i++ == n)
+			return filter;
+	}
+	return NULL;
+}
+
 static void damos_commit_filter_arg(
 		struct damos_filter *dst, struct damos_filter *src)
 {
@@ -925,7 +937,7 @@ static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
 	int i = 0, j = 0;
 
 	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
-		src_filter = damos_nth_filter(i++, src);
+		src_filter = damos_nth_ops_filter(i++, src);
 		if (src_filter)
 			damos_commit_filter(dst_filter, src_filter);
 		else
-- 
2.43.0

